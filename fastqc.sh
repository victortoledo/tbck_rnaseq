#!/bin/bash

#### Quality control RNAseq (FastQC) ####

## Access folder with raw data

cd /home/venus/rio/ngs/dados/novaseq/220303_A01123_0049_BHN7WYDRXY/Data/Intensities/BaseCalls/RNASeq-005

## Creating the results folder:

mkdir -p /home/venus/mar/alunos/victortoledo/TBCK_iPSC_project/FastQC/_m/FastQC_results # -p avoids the error if folder already exists

# Running:

for i in $(ls); do
if [[ $i = *.gz ]]
then
fastqc $i -o /home/venus/mar/alunos/victortoledo/TBCK_iPSC_project/FastQC/_m/ &
fi #fi closes the if
done

wait

# To run, make the file executable with chmod -x FILENAME.sh and then run with ./FILENAME.sh
