#!/bin/bash

### Salmon: criação de um arquivo index para quantificação de reads baseada em transcritos ###

# Confirmando que estamos na pasta _h

cd /home/marte/fogo/victortoledo/TBCK_iPSC_project/Salmon/_h

# Criando o index

echo "Construindo o arquivo de index com o transcriptoma e genoma de referência"

grep "^>" <(gunzip -c GRCh38.primary_assembly.genome.fa.gz) | cut -d " " -f 1 > decoys.txt
sed -i.bak -e 's/>//g' decoys.txt

cat gencode.v40.transcripts.fa.gz GRCh38.primary_assembly.genome.fa.gz > gentrome.fa.gz

salmon index -t gentrome.fa.gz -d decoys.txt -p 12 -i salmon_index --gencode

echo "Finalizado a construção do arquivo index"
