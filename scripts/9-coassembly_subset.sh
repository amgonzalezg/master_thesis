#!/bin/sh

#SBATCH --account=emm2
#SBATCH --job-name=coassembly_spades
#SBATCH --cpus-per-task=24
#SBATCH --ntasks-per-node=1
#SBATCH --output=data/logs/coassembly_spades_%A_%a.out
#SBATCH --error=data/logs/coassembly_spades_%A_%a.err 
#SBATCH --constraint=supermicro
#SBATCH --mem=150G

#================================================

##########VARIABLES#########

# Load modules

module load spades

# Path to files

DATA_DIR='data/raw' # raw reads

SAMPLES='data/clean/coassembly_subset/samples.txt'  # list of samples to coassemble

OUT_DIR="data/clean/coassembly_subset"

mkdir -p ${OUT_DIR}

# Parameters

NUM_THREADS=24

###########SCRIPT###########

# Concatenate all read files into a single file

cat ${DATA_DIR}/*.fastq.gz > ${OUT_DIR}/combined_reads.fastq.gz

# Execute SPAdes for coassembly

spades.py \
 -s ${OUT_DIR}/combined_reads.fastq.gz \
 -t ${NUM_THREADS} \
 --sc \
 -k 21,33,55,77,99 \
 -o ${OUT_DIR}/coassembly_output

