//Executables:
bt2 = "/Users/Thomas/miniconda3/bin/bowtie2"
build = "/Users/Thomas/miniconda3/bin/bowtie2-build "

//Index files:
tstfolder = "/Users/Thomas/DataManagementProject/NextFlow/bowtie"
//indexFiles = tstfolder + "/indexed"

//Genomic files:
examples = "/Users/Thomas/miniconda3/bin/example"
genome = examples + "/reference/lambda_virus.fa"
read = examples + "/reads/reads_1.fq"

//SAM files:
mapFile = tstfolder + "/map.sam"



/*
----Build index-files for our genome.
*/

indeces = "/Users/Thomas/DataManagementProject/NextFlow/bowtie/index"

process index {

	output:
	val indeces into INDEXED

	"""
	$build $genome $indeces
	"""
}


/*
----Perform the actual mapping.
*/

process align {

	input:
	val files from INDEXED

	"""
	$bt2 -x $files -U $read -S $mapFile
	"""
}
