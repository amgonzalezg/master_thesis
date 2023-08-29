#!/bin/sh

#SBATCH --account=emm2
#SBATCH --job-name=seqkit_post
#SBATCH --cpus-per-task=24
#SBATCH --ntasks-per-node=1
#SBATCH --output=data/logs/seqkit_clean_%J.out
#SBATCH --error=data/logs/seqkit_clean_%J.err

DATA=data/clean/assembly_OtherSAGs/trimgalore/*.gz # change to your filepath

THREADS=24

OUT=data/clean/assembly_OtherSAGs/seqkit_clean.txt

module load seqkit

seqkit stats \
  ${DATA} \
  -j ${THREADS} > ${OUT}
