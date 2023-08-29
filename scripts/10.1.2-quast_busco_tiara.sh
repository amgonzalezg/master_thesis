#!/bin/sh

#SBATCH --account=emm2
#SBATCH --job-name=quast_busco
#SBATCH --cpus-per-task=6
#SBATCH --ntasks-per-node=1
#SBATCH --output=data/logs/quastbusco_%A_%a.out
#SBATCH --error=data/logs/quastbusco_%A_%a.err 

#================================================

##########VARIABLES#########

# Path to files

DATA_DIR='data/clean/coassembly_subset/coassembly_output'

BUSCO_db=/home/ameigonz/MassanaLab/easig_sags/xabi_sags/all/data/clean/eukaryota_odb10/

NUM_THREADS=6

mkdir -p data/clean/qbt_subset1
mkdir -p data/clean/qbt_subset1/quast/quast_output
mkdir -p data/clean/qbt_subset1/busco/
mkdir -p data/clean/qbt_subset1/tiara/tiara_out


module load quast

quast.py \
 --contig-thresholds 0,1000,3000,5000 \
 -o data/clean/qbt_subset1/quast/quast_output \
 -t ${NUM_THREADS} \
 ${DATA_DIR}/scaffolds_filtered.fasta


module load busco/5.4.6
source activate busco-5.4.6

cd data/clean/qbt_subset1/busco

export AUGUSTUS_CONFIG_PATH="../../../../data/clean/config/"

busco \
 --in ../../../../${DATA_DIR}/scaffolds_filtered.fasta \
 -o busco_output \
 -l ${BUSCO_db} \
 -m geno

cd ../../../..


module load tiara
source activate tiara

tiara \
 -i ${DATA_DIR}/scaffolds_filtered.fasta \
 -o data/clean/qbt_subset1/tiara/tiara_out/tiara_output
