#!/bin/sh

#SBATCH --account=emm2
#SBATCH --job-name=quast_busco
#SBATCH --cpus-per-task=6
#SBATCH --ntasks-per-node=1
#SBATCH --output=data/logs/quastbusco_%A_%a.out
#SBATCH --error=data/logs/quastbusco_%A_%a.err 
#SBATCH --array=1-24%6

#================================================

##########VARIABLES#########

# Path to files

DATA_DIR='data/clean/assembly/'
SAMPLE=$(ls ${DATA_DIR} | awk "NR == ${SLURM_ARRAY_TASK_ID}")

BUSCO_db=/home/ameigonz/MassanaLab/easig_sags/xabi_sags/all/data/clean/eukaryota_odb10/

NUM_THREADS=6

mkdir -p data/clean/quast_busco_tiara
mkdir -p data/clean/quast_busco_tiara/quast/
mkdir -p data/clean/quast_busco_tiara/busco/
mkdir -p data/clean/quast_busco_tiara/tiara/


module load quast

quast.py \
 --contig-thresholds 0,1000,3000,5000 \
 -o data/clean/quast_busco_tiara/quast/${SAMPLE} \
 -t ${NUM_THREADS} \
 ${DATA_DIR}/${SAMPLE}/scaffolds.fasta


module load busco/5.4.6
conda activate busco-5.4.6

cd data/clean/quast_busco_tiara/busco

export AUGUSTUS_CONFIG_PATH="../../../../data/clean/config/"

busco \
 --in ../../../../${DATA_DIR}/${SAMPLE}/scaffolds.fasta \
 -o ${SAMPLE} \
 -l ${BUSCO_db} \
 -m geno

cd ../../../..


module load tiara

tiara \
 -i ${DATA_DIR}/${SAMPLE}/scaffolds.fasta \
 -o data/clean/quast_busco_tiara/tiara/${SAMPLE}
