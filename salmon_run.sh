#!/bin/bash

### Salmon: quantificação de reads baseada em transcritos ###

# Confirmando que estamos na pasta _h

cd /home/marte/fogo/victortoledo/TBCK_iPSC_project/Salmon/_h

# Criando a pasta de resultados

mkdir -p /home/marte/fogo/victortoledo/TBCK_iPSC_project/Salmon/_m

INPUT_FOLDER=/home/marte/fogo/victortoledo/TBCK_iPSC_project/Trimmomatic/_m
OUTPUT_FOLDER=/home/marte/fogo/victortoledo/TBCK_iPSC_project/Salmon/_m

## Rodando o Salmon, que junta as lanes automaticamente se definido
# -1 é a primeira lane, -2 é a segunda, e assim por diante
# o segundo número diz se é o R1 ou R2

# os argumentos foram sugeridos pelo paper do TCF4 do Fabio Papes
# PESQUISAR MELHOR OS ARGUMENTOS ESCOLHIDOS

echo "Iniciando o alinhamento e quantificação da amostra"

for i in $(cat salmon_files_list.txt); do

salmon quant -p 8 -i salmon_index -l A -1 ${INPUT_FOLDER}/${i}_L001_R1_001_paired.fq.gz ${INPUT_FOLDER}/${i}_L002_R1_001_paired.fq.gz -2 ${INPUT_FOLDER}/${i}_L001_R2_001_paired.fq.gz ${INPUT_FOLDER}/${i}_L002_R2_001_paired.fq.gz --validateMappings --seqBias --gcBias --posBias -o ${OUTPUT_FOLDER}/${i}_quantified

done

echo "Finalizado o alinhamento e quantificação da amostra"
