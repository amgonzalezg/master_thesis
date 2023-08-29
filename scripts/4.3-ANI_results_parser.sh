#!/bin/bash

#Script that parse ANI blast results from 0_ANI_blast_launcher_fast.sh script to get the results in tabular format


#Input files
#Files must have a .fasta extension and all be located in the same folder. The folder should also contain a file with the list of names of the fasta files.

#Requirements
#Defining arguments
if [ -z "$2" ]
	then echo -e "\nERROR! You need to specify the list of fasta files and the path where you computed the 0_ANI_blast_launcher_fast.sh script. 
	
    -1st name of list file
    -2nd Path where list and 0_ANI_blast_launcher_fast.sh output files are located 
	
"
    exit
fi
echo -e "\n\n>> Hi, Let's get the results in tabular format! <<\n"

list="$1"
data_path="$2"

cd ${data_path};


while read line; do echo -e "${line}" >ANI_PER_${line}; cut -f 5 -d " " ANI_results_${line} >>ANI_PER_${line}; done <${list}
echo -e "ANI_percentage" >ANI_PER_HEADER; cat ${list} >>ANI_PER_HEADER
paste ANI_PER_* >ANI_percentage_table
rm ANI_PER_*

while read line; do echo -e "${line}" >ANI_LENGTH_${line}; cut -f 3 -d " " ANI_results_${line} >>ANI_LENGTH_${line}; done <${list}
echo -e "ANI_length" >ANI_LENGTH_HEADER; cat ${list} >>ANI_LENGTH_HEADER
paste ANI_LENGTH_* >ANI_length_table
rm ANI_LENGTH_*


echo -e "\n\n>> DONE! :=) <<\n"
