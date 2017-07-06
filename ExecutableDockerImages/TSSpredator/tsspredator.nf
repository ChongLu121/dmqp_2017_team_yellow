#!/usr/bin/env nextflow
/*
* Please notice the variables ${dataPath} and ${dataPath1}.
* If you have changed the container's folder /tss/,
* Please modify the value these two variables to make them identical.
*
* Please create a new directory 'Result' under host folder ~/tss/
*
*/

/*
* Check if config file is here.
* If it exists, do next step;
* else, run TSSpredator to set the config file.
*/ 

process checkConfig{

input:
/* If you have changed the container's folder /Tss_workflow,
*  Please modify the value of Path to make them identical.
*  'configPath': for config file of tsspredator
*  'localPath': volume connected with the container
*/

val configPath from Channel.from('/Tss_workflow/tss/Data/*.config')
val localPath from Channel.from('~/tss/')

"""
sudo docker pull dmqbyellow/tsspre_cmd
docker run -v ${localPath}:/Tss_workflow/tss/ -i dmqbyellow/tsspre_cmd $configPath
"""

}	 

