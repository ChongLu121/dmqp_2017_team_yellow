# !!!!!   Attention   !!!!!
# 
# 1. Please check the Tss_workfolw.config before use, 
#    and place your data as it mentioned.

# 2. Then specify your Tsspredator's config file, which should be /tss/Data/*.config.
#
#
#    The path of .wig files should be ${outputfolder}/wigFiles/*.wig
#    ${outputfolder} is setted by yourself in Tss_workflow.config.
#
#
#    Please make sure the .wig files' name in this config is identical to your fastq file,
#    which will be used as input of this workflow.


# 3. Open the folder, where this README is, in your terminal. 
#    Run workflow with command:
#     $ nextflow run Tss_nextflow -c Tss_workflow.config

# Used docker images are following:
#
# dmqbyello/bowtie2, dmqbyellow/samtools, dmqbyellow/tsstools, dmqbyellow/tsspredator
#
# After finish your work with this workflow, you can delete them from your host.
#   To delete pulled docker images:
#    $ docker rmi -f IMAGE_ID



