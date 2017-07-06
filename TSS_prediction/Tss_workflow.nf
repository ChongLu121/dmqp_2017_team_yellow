#!/usr/bin/env nextflow

/*
* Import file pathes from Tss_workflow.config. 
* Pathes are defined by users in TSS_workflow.config.
*/
genome = Channel.from(params.fasta)
read = Channel.from(params.fastq)
indeces = params.outputfolder + '/index/index'
samFile = Channel.from(params.sam)
bamFile = Channel.from(params.bam)
sortedBamFile = Channel.from(params.sortedbam)


/*
* Set output directory of wig files:
*/ 
outWig = params.outputfolder + "/wigFiles"

/*
* 1.Preparing.
* Pull docker images.
*/
process pullImages {

    output:
    file 'run_docker.txt'  into DOCKER

	"""
	docker pull dmqbyellow/bowtie2
	docker pull dmqbyellow/samtools
	docker pull dmqbyellow/tsstools
	docker pull dmqbyellow/tsspredator
	echo 'pull finish' > run_docker.txt
	"""
}



/*
* 1.Mapping.
* Build index-files.
*/
process index {

    input:
    val fasta from genome
    val i from DOCKER
	
    output:
    val indeces into INDEXED

	"""
	bowtie2-build -p $fasta $indeces
	"""
}


/*
* 1.Mapping.
* Perform the actual mapping.
*/
process align {

	input:
	val files from INDEXED
	val fast from read
    
    
	output:
	val samFile into MAPPED

	"""
	for fastq in $fast
	do
	bowtie2-align-s -x $files -U \$fastq -S \${fastq/fastq/sam}
	done
	"""
}


/*
* 2.Conversion from SAM to BAM.
* Converts the output SAM file from bowtie2 to a BAM file.
*/
process convert {

	input:
	val smf from samFile
	val c from MAPPED

	output:
	val bamFile into CONVERTED

	"""
	for sam in $smf
	do
	samtools view -b \$sam -o \${sam/.sam/_r.bam}
	rm \$sam
	done
	"""
}
/*
* 2.Conversion from SAM to BAM.
* Sorts the BAM file from the last process to a sorted BAM file.
*/
process sort {

	input:	
	val bamF from bamFile
	val s from CONVERTED

	output:
	val sortedBamFile into SORTED

	"""
	for rbam in $bamF
	do
	samtools sort \$rbam -o \${rbam/_r.bam/.bam}
	rm \$rbam
	done
	"""
}


/*
* 3. Conversion from BAM to .wig.
* Convert sorted bam files into wig files and rssc files
*/
process toWig {
    
    input:
    val sorted from sortedBamFile
    val t from SORTED
    
    output:
    val outWig into WIG
    
    """
    for bam in $sorted
    do
    java -jar /Tss_workflow/tsstools.jar -w -i \$bam -o $outWig
    rm \$bam
    done
    """
}


/*
* 4. Tss finding.
* Check whether there is a config file for TSSpredator.
*/
process checkTssConfig{

	input:
	/* If you have changed the container's folder /Tss_workflow,
	*  Please modify the value of ${dataPath} to make them identical.
	*/

	val dataPath from Channel.from('/Tss_workflow')
	val c from WIG
	
	output:
	val 'check' into CONFIG

	"""
	find ${dataPath}/tss/Data/*.config || java -jar ${dataPath}/Tsspredator-1.06.jar || ls
	"""

}	 


/*
* 4. Tss finding.
* Run TSSpredator with existed config file.
* Set MasterTable.tsv and TSSstatistics.tsv
* as the output of following process.
*/
process runTSSpredator{

	input:
	/* If you have changed the container's folder /Tss_workflow,
	*  Please modify the value of ${dataPath1} to make them identical.
	*/
	val dataPath1 from Channel.from('/Tss_workflow')
	val r from CONFIG

	output:
	 file 'MasterTable' into mt
	 file 'Tssstatistics' into ts

	script:
	"""
	java -jar ${dataPath1}/TSSpredator-1.06.jar
	java -Xmx1G -jar ${dataPath1}/TSSpredator-1.06.jar ${dataPath1}/tss/Data/*.config
	cp ${dataPath1}/tss/Result/MasterTable.tsv MasterTable
	cp ${dataPath1}/tss/Result/TSSstatistics.tsv Tssstatistics
	"""
}

// Check and feedback
mt.println()
