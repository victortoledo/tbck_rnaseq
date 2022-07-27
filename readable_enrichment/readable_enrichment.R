### Gene symbol annotation
setwd("~/Downloads/temp_results/exp_diff")
library(biomaRt)
library(tidyr)
library(forcats)
library(clusterProfiler)
library(org.Hs.eg.db)
library(ReactomePA)

## Neurons
formated_res1 = read.table("~/Downloads/temp_results/exp_diff/neuron_TBCK_iPSC_diff_genes_v2.txt",
                          header = TRUE)

#mart <- useMart(biomart = "ensembl", dataset = "hsapiens_gene_ensembl")
#gene_list=unique(sort(formated_res$gene))
#test=getBM(attributes = c("entrezgene_id", "hgnc_symbol"), filters = "entrezgene_id", values = gene_list, bmHeader = T, mart = mart)
#colnames(test)=c("entrezgene_id","hgnc_symbol")
#test$entrezgene_id=as.character(test$entrezgene_id)
#formated_res_symbol <- merge(formated_res,test,by.x = "gene",by.y = "entrezgene_id")
#sig <- subset(formated_res_symbol, significative == "yes")

sig1 <- subset(formated_res1, significative == "yes")

# Enriquecimento
universe1 <- as.character(formated_res1$gene)
x1 <- as.character(sig1$gene)
egoNeuron <- enrichGO(gene     = x1, #Biological Process
                   universe      = universe1,
                   OrgDb         = org.Hs.eg.db,
                   ont           = "BP",
                   keyType       = 'ENTREZID',
                   pAdjustMethod = "fdr",
                   pvalueCutoff  = 0.05,
                   qvalueCutoff = 0.05,
                   minGSSize=5)

goNeuron <- setReadable(egoNeuron, OrgDb = org.Hs.eg.db)

kkNeuron <- enrichKEGG(gene         = x1,
                    organism     = 'hsa',
                    universe = universe1,
                    pAdjustMethod = "fdr",
                    pvalueCutoff  = 0.05)

keggNeuron <- setReadable(kkNeuron, OrgDb = org.Hs.eg.db, keyType="ENTREZID")

reactNeuron <- enrichPathway(gene= x1,
                          organism = "human",
                          universe = universe1,
                          pAdjustMethod = "fdr",
                          pvalueCutoff=0.05)

reactomeNeuron <- setReadable(reactNeuron, OrgDb = org.Hs.eg.db, keyType="ENTREZID")


## NSC
formated_res = read.table("~/Downloads/temp_results/exp_diff/NSC_TBCK_iPSC_diff_genes_v2.txt",
                          header = TRUE)

#mart <- useMart(biomart = "ensembl", dataset = "hsapiens_gene_ensembl")
#gene_list=unique(sort(formated_res$gene))
#test=getBM(attributes = c("entrezgene_id", "hgnc_symbol"), filters = "entrezgene_id", values = gene_list, bmHeader = T, mart = mart)
#colnames(test)=c("entrezgene_id","hgnc_symbol")
#test$entrezgene_id=as.character(test$entrezgene_id)
#formated_res_symbol <- merge(formated_res,test,by.x = "gene",by.y = "entrezgene_id")
#sig <- subset(formated_res_symbol, significative == "yes")

sig <- subset(formated_res, significative == "yes")

# Enriquecimento
universe <- as.character(formated_res$gene)
x <- as.character(sig$gene)
egoNSC <- enrichGO(gene     = x, #Biological Process
                   universe      = universe,
                   OrgDb         = org.Hs.eg.db,
                   ont           = "BP",
                   keyType       = 'ENTREZID',
                   pAdjustMethod = "fdr",
                   pvalueCutoff  = 0.05,
                   qvalueCutoff = 0.05,
                   minGSSize=5)

goNSC <- setReadable(egoNSC, OrgDb = org.Hs.eg.db)

kkNSC <- enrichKEGG(gene         = x,
                 organism     = 'hsa',
                 universe = universe,
                 pAdjustMethod = "fdr",
                 pvalueCutoff  = 0.05)

keggNSC <- setReadable(kkNSC, OrgDb = org.Hs.eg.db, keyType="ENTREZID")

reactNSC <- enrichPathway(gene= x,
                          organism = "human",
                          universe = universe,
                          pAdjustMethod = "fdr",
                          pvalueCutoff=0.05)

reactomeNSC <- setReadable(reactNSC, OrgDb = org.Hs.eg.db, keyType="ENTREZID")

# Write all:
files <- c(goNeuron,keggNeuron,reactomeNeuron,goNSC,keggNSC,reactomeNSC)
names(files) <- c("goNeuron","keggNeuron","reactomeNeuron","goNSC","keggNSC","reactomeNSC")

for (i in 1:6){
  write.table(files[[i]], file = paste0(names(files)[i],"_enrichment.txt"), quote = FALSE,
              sep = "\t")
}
