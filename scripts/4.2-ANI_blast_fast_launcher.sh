#!/bin/sh

#SBATCH --account=emm2
#SBATCH --job-name=ANI
#SBATCH --cpus-per-task=8
#SBATCH --mem=50G
#SBATCH --ntasks-per-node=1
#SBATCH --output=data/logs/ANI_%A_%a.out
#SBATCH --error=data/logs/ANI_%A_%a.err
#SBATCH --array=1-24%6
#================================================

##########VARIABLES#########
LIST=/home/ameigonz/MassanaLab/myfile/data/clean/ANI_Minorisa/list
DATA_PATH=/home/ameigonz/MassanaLab/myfile/data/clean/ANI_Minorisa
SAMPLE=$(cat /home/ameigonz/MassanaLab/myfile/data/clean/ANI_Minorisa/list | awk "NR == ${SLURM_ARRAY_TASK_ID}")

#Load modules
module load blast
module load python/3.8.5

cd ${DATA_PATH};

cat resetANI_result_files >ANI_results_${SAMPLE};

for i in $(cat ${LIST}); do blastn -query ${i}_1k.split.1Kmer.10overlap.fasta -db ${SAMPLE}_1k.split.1Kmer.10overlap.fasta  -outfmt "6 qseqid length pident sseqid qseq sseq" -max_hsps 1 -qcov_hsp_perc 70 -max_target_seqs 1 -evalue 0.00001 -num_threads 8 >blast_f_sc_${i}_to_${SAMPLE}; h=$(cut -f 2 blast_f_sc_${i}_to_${SAMPLE} | awk '{s+=$1} END {print s}'); p=$(awk ' {print $2*$3/100}' blast_f_sc_${i}_to_${SAMPLE} | awk '{s+=$1} END {print s/'"$h"'*100}'); echo "blast_f_sc_${i}_to_${SAMPLE}  $h  $p"; done >>ANI_results_${SAMPLE}
