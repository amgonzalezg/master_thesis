#!/bin/bash

#SBATCH --account=emm2
#SBATCH --job-name=filter_vsearch
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --output=data/logs/filter_vsearch_%A_%a.out
#SBATCH --error=data/logs/filter_vsearch_%A_%a.err
#SBATCH --array=1-24%6

# Load modules

module load vsearch

DATA_DIR='data/clean/assembly/'
SAMPLE=$(ls  ${DATA_DIR}/*/scaffolds.fasta | awk "NR == ${SLURM_ARRAY_TASK_ID}")
MIN_LEN=1000

vsearch \
 --fastx_filter ${SAMPLE} \
 --fastq_minlen ${MIN_LEN} \
 --fastaout ${SAMPLE/.fasta/_min1000bp.fasta}
