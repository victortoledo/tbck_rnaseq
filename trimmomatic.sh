#!/bin/bash

### Passo de controle de qualidade que trimma adaptadores e sequências de má qualidade ###

## Confirmando que estamos na pasta _h

cd /home/marte/fogo/victortoledo/TBCK_iPSC_project/Trimmomatic/_h

## Criando a pasta de resultados

mkdir -p /home/marte/fogo/victortoledo/TBCK_iPSC_project/Trimmomatic/_m

## Criando aliases para as pastas

INPUT_FOLDER=/home/venus/rio/ngs/dados/novaseq/220303_A01123_0049_BHN7WYDRXY/Data/Intensities/BaseCalls/RNASeq-005
OUTPUT_FOLDER=/home/marte/fogo/victortoledo/TBCK_iPSC_project/Trimmomatic/_m

## Rodando o  Trimmomatic em cada uma das lanes das amostras (entra R1 e R2)

for i in $(cat files_list.txt); do

echo "Iniciando amostra $i"

time java -jar /usr/local/Trimmomatic-0.39/trimmomatic-0.39.jar PE -threads 16 ${INPUT_FOLDER}/${i}_R1_001.fastq.gz ${INPUT_FOLDER}/${i}_R2_001.fastq.gz ${OUTPUT_FOLDER}/${i}_R1_001_paired.fq.gz ${OUTPUT_FOLDER}/${i}_R1_001_unpaired.fq.gz ${OUTPUT_FOLDER}/${i}_R2_001_paired.fq.gz ${OUTPUT_FOLDER}/${i}_R1_001_unpaired.fq.gz LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36

echo "Trimmomatic rodado para amostra $i"

done
