# working with cancer gene expression dataset 
setRepositories()
library(tidyverse)
library(ggplot2)
library(janitor)

if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install(version = "3.18")

# installation GEOquery package
library(BiocManager)
install.packages("GEOquery", dependencies = TRUE)
BiocManager::install("GEOquery")
library(GEOquery)

# importing data into the environment ----
expression_matrix <- read_tsv(file = "GSE245351_ctl_salmon_stringtie_FPKM.tsv")


# importing metadata ----
gse <- getGEO(GEO = "GSE245351", GSEMatrix = TRUE)

metadata <- pData(phenoData(gse[[1]]))




