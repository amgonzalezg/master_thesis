#!/bin/sh

#SBATCH --account=emm2
#SBATCH --job-name=ANI
#SBATCH --mem=50G
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task 8
#SBATCH --array=1-24%6
#SBATCH --output=data/logs/ANI_%A_%a.out
#SBATCH --error=data/logs/ANI_%A_%a.err
#================================================

##########VARIABLES#########
LIST=/home/ameigonz/MassanaLab/myfile/data/clean/ANI_Minorisa/list
DATA_PATH=/home/ameigonz/MassanaLab/myfile/data/clean/ANI_Minorisa
SAMPLE=$(cat /home/ameigonz/MassanaLab/myfile/data/clean/ANI_Minorisa/list | awk "NR == ${SLURM_ARRAY_TASK_ID}") 

#Load modules
module load blast
module load python/3.8.5
module load seqkit

cd ${DATA_PATH}

seqkit seq -m 1000 ${SAMPLE}.fasta > ${SAMPLE}_1k.fasta 

pyfasta split -k 1000 -o 10 ${SAMPLE}_1k.fasta -n 1

makeblastdb -in ${SAMPLE}_1k.split.1Kmer.10overlap.fasta -dbtype nucl
