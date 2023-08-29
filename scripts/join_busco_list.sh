#!/bin/bash

# Input file with the file paths
FILE_PATHS="file_paths.txt"

# output file
OUTPUT_FILE="search_list_joined.txt"

# Read the file paths from the file file_paths.txt
FILES=$(cat $FILE_PATHS)

# Merge the files into a temporary file
paste $FILES > temp_merged.txt

# Generate the final file with the 25
awk 'BEGIN {FS="\t"; OFS="\t"} {
     print $1, $2, $4, $6, $8, $10, $12, $14, $16, $18, $20, $22, $24, $26, $28, $30, $32, $34, $36, $38, $40, $42, $44, $46, $48
}' temp_merged.txt > $OUTPUT_FILE

# delete the temporary file
rm temp_merged.txt