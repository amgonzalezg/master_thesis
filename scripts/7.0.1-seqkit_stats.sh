#!/bin/sh

#SBATCH --account=emm2
#SBATCH --job-name=seqkit
#SBATCH --cpus-per-task=24
#SBATCH --ntasks-per-node=1
#SBATCH --output=data/logs/seqkit_%J.out
#SBATCH --error=data/logs/seqkit_%J.err

DATA=data/raw/Other_SAGs/*.fastq.gz # change to your filepath

THREADS=24

OUT=data/clean/assembly_OtherSAGs/seqkit_raw.txt

module load seqkit

seqkit stats \
  ${DATA} \
  -j ${THREADS} > ${OUT}
