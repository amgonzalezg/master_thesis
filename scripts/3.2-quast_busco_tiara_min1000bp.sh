#!/bin/sh

#SBATCH --account=emm2
#SBATCH --job-name=quast_busco
#SBATCH --cpus-per-task=6
#SBATCH --ntasks-per-node=1
#SBATCH --output=data/logs/quastbusco_1000bp_%A_%a.out
#SBATCH --error=data/logs/quastbusco_1000bp_%A_%a.err 
#SBATCH --array=1-24%6

#================================================

##########VARIABLES#########

# Path to files

DATA_DIR='data/clean/assembly'
SAMPLE=$(ls ${DATA_DIR} | awk "NR == ${SLURM_ARRAY_TASK_ID}")

BUSCO_db=/home/ameigonz/MassanaLab/easig_sags/xabi_sags/all/data/clean/eukaryota_odb10/

NUM_THREADS=6

module load quast

quast.py \
 -o data/clean/quast_busco_tiara/quast/min1000bp/${SAMPLE}_min1000bp \
 -t ${NUM_THREADS} \
 ${DATA_DIR}/${SAMPLE}/scaffolds_min1000bp.fasta


module load busco/5.4.6
conda activate busco-5.4.6

cd data/clean/quast_busco_tiara/busco/min1000bp

export AUGUSTUS_CONFIG_PATH="../../../../../data/clean/config/"

busco \
 --in ../../../../../${DATA_DIR}/${SAMPLE}/scaffolds_min1000bp.fasta \
 -o ${SAMPLE}_min1000bp \
 -l ${BUSCO_db} \
 -m geno

cd ../../../../..


module load tiara

tiara \
 -i ${DATA_DIR}/${SAMPLE}/scaffolds_min1000bp.fasta \
 -o data/clean/quast_busco_tiara/tiara/min1000bp/${SAMPLE}_min1000bp
