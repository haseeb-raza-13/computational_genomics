# activating packages -----
library(tidyverse)
library(ggplot2)
library(janitor)

# wrangling for  metadata ------
mod_metadata <- metadata %>% 
  dplyr::select(c(1,8,10,12)) %>% 
  rename(tissue =  characteristics_ch1) %>% 
  rename(disease = characteristics_ch1.2) %>% 
  mutate( tissue = gsub("tissue:", "", tissue) ) %>% 
  mutate( disease = gsub("disease:", "", disease) ) %>% 
  rename(cancer_type = source_name_ch1 )

# wrangling for exp_data -----

expression_data <- expression_matrix %>% 
  rename( CtL_1C = CtL_1C_L001  , 
          CtL_4C = CtL_4C_L001 , 
          CtL_5C =  CtL_5C_L001 , 
          CtL_6C = CtL_6C_L001 ,
          CtL_7C = "CtL-7C_L001" ,
          CtL_8C = CtL_8C_L001  ,
          CtL_10C = "CtL-10C_L001" ,
          CtL_12C = CtL_12C_L001 ,
          CtL_20C = CtL_20C_L001  ,
          CtL_1LM = "CtL-1LM_L001" , 
          CtL_4LM = CtL_4LM_L001 ,
          CtL_5LM = CtL_5LM_L001  ,
          CtL_6LM = CtL_6LM_L001  ,
          CtL_7LM = CtL_7LM_L001  ,
          CtL_8LM = CtL_8LM_L001  ,
          CtL_10LM = CtL_10LM_L001  ,
          CtL_12LM = CtL_12LM_L001 ,
          CtL_20LM = CtL_20LM_L001 
          ) 


# removing expression matrix 
remove(expression_matrix)

# converting expression data into the long formate 

exp_data_long <- expression_data %>% 
  rename(gene = Gene.Name) %>% 
  rename(gene_id = Gene.ID) %>% 
  gather( key = "samples" , value = "FPKM", -c(gene, gene_id)) 





# joining the metadata and exptression data -----


final_data <- left_join( exp_data_long , mod_metadata, by = c("samples" = "title"))





# mock analysis between liver metastsis and colon cancer ---- 

final_data %>% 
  filter( gene %in% c("TP53", "KRAS", "MLH1", "MSH2")) %>% 
  dplyr::select(gene, FPKM, cancer_type) %>% 
  ggplot(aes(g, FPKM , )) + geo
                                                         
  



