#!/bin/sh

mkdir -p data/clean/quast_busco_tiara/all_reports

DATA_DIR=data/clean/quast_busco_tiara/busco/
OUT_FILE=data/clean/quast_busco_tiara/all_reports/busco_report.txt

HEADERS_SAMPLE=$(ls ${DATA_DIR} | grep 'P' | head -1)
HEADERS=$(cat ${DATA_DIR}/${HEADERS_SAMPLE}/short_summary.specific.eukaryota_odb10.${HEADERS_SAMPLE}.txt | grep -v '^#' | sed '/^$/d' | grep -v '%' | perl -pe 's/.*\d+\s+//' | tr '\n' '\t')

echo -e "Sample\t${HEADERS}" > ${OUT_FILE}

for SAMPLE in $(ls ${DATA_DIR} | grep P)
do
  REPORT=$(cat ${DATA_DIR}/${SAMPLE}/short_summary.specific.eukaryota_odb10.${SAMPLE}.txt | \
  grep -v '^#' | perl -pe 's/^\n//' | awk '{print $1}' | tr '\n' '\t')
  echo -e "${SAMPLE}\t${REPORT}" >> ${OUT_FILE}
done



DATA_DIR=data/clean/quast_busco_tiara/tiara/
OUT_FILE=data/clean/quast_busco_tiara/all_reports/tiara_report.txt

for SAMPLE in $(ls ${DATA_DIR} | grep '^P')
do
  cat ${DATA_DIR}/log_${SAMPLE} | \
  grep -e 'archaea' -e 'bacteria' -e 'eukarya' -e 'organelle' -e 'unknown' | \
  awk -v var=${SAMPLE} '{print var$0}' OFS='\t' \
  >> ${OUT_FILE}
done



DATA_DIR=data/clean/quast_busco_tiara/quast/
OUT_FILE=data/clean/quast_busco_tiara/all_reports/quast_report.txt

HEADERS_SAMPLE=$(ls ${DATA_DIR} | grep 'P' | head -1)
HEADERS=$(cat ${DATA_DIR}/${HEADERS_SAMPLE}/transposed_report.tsv | head -1)

echo -e "Sample\t${HEADERS}" > ${OUT_FILE}

for SAMPLE in $(ls ${DATA_DIR} | grep '^P')
do
  REPORT=$(cat ${DATA_DIR}/${SAMPLE}/transposed_report.tsv | tail -1)
  echo -e "${SAMPLE}\t${REPORT}" >> ${OUT_FILE}
done
