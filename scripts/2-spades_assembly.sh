#!/bin/sh

#SBATCH --account=emm2
#SBATCH --job-name=spades
#SBATCH --cpus-per-task=24
#SBATCH --ntasks-per-node=1
#SBATCH --output=data/logs/spades_%A_%a.out
#SBATCH --error=data/logs/spades_%A_%a.err 
#SBATCH --array=1-24%6
#SBATCH --constraint=supermicro
#SBATCH --mem=100G

#================================================

##########VARIABLES#########

# Load modules

module load spades

# Path to files

DATA_DIR='data/raw' #raw reads

SAMPLE=$(ls ${DATA_DIR} | cut -f1,2,3,4 -d'_' | sort -u | awk "NR == ${SLURM_ARRAY_TASK_ID}")

OUT_DIR="data/clean/assembly/${SAMPLE}"

mkdir ${OUT_DIR}

# Parameters

NUM_THREADS=24

###########SCRIPT###########

spades.py \
 -1 ${DATA_DIR}/${SAMPLE}_R1_001.fastq.gz \
 -2 ${DATA_DIR}/${SAMPLE}_R2_001.fastq.gz \
 -t ${NUM_THREADS} \
 --sc \
 -k 21,33,55,77,99 \
 -o ${OUT_DIR}