#!/bin/sh

#SBATCH --account=emm2
#SBATCH --job-name=trimgalore
#SBATCH --cpus-per-task=6
#SBATCH --ntasks-per-node=1
#SBATCH --output=data/logs/trimgalore_%A_%a.out
#SBATCH --error=data/logs/trimgalore_%A_%a.err
#SBATCH --array=1-5%5

# Load module

module load cutadapt

source activate cutadapt

module load fastqc 


# Variables

DATA_PATH=data/raw/Other_SAGs

OUT_DIR=data/clean/assembly_OtherSAGs/trimgalore

SAMPLES_FILE=data/raw/Other_SAGs/samples_file.txt # file with only sample names, one per line, with no pair (forward/reverse) info

SAMPLE=$(cat ${SAMPLES_FILE} | awk "NR == ${SLURM_ARRAY_TASK_ID}")

THREADS=6

#mkdir -p ${OUT_DIR}


# Run trimgalore

/mnt/lustre/repos/bio/projects/MassanaLab/Programs/TrimGalore-0.6.6/trim_galore  \
  --paired ${DATA_PATH}/${SAMPLE}_R1.fastq.gz ${DATA_PATH}/${SAMPLE}_R2.fastq.gz \
  -o ${OUT_DIR} \
  --length 75
