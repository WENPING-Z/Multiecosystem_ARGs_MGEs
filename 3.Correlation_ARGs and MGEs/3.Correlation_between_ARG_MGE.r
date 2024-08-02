
# library
library(vegan)
library(dplyr)
library(reshape2)
library(tidyr)
library(tibble)
library(gbm)
library(ggplot2)
library(ggprism)
library(patchwork)
library(ggpubr)

# VPA --------------------------------------------------------------
load("1_ARG_MGE_combined_df.Rdata")

combination_tailings <- combination %>% filter(sampleType == "tailings")
combination_sludge <- combination %>% filter(sampleType == "Sludge")
combination_farmland <- combination %>% filter(sampleType == "farmland")
combination_forest <- combination %>% filter(sampleType == "forest")
combination_grass <- combination %>% filter(sampleType == "grass")
combination_gobi <- combination %>% filter(sampleType == "gobi")

# analysis --------------------

# 
par(mfrow = c(2, 3))

# (1) Tailings

MGE_Tailings_corrected <- combination_tailings %>% column_to_rownames("sampleName")

# 
sapply(MGE_Tailings_corrected, class) 

MGE_Tailings_corrected <- MGE_Tailings_corrected %>% select(where(is.numeric)) 

MGE_Tailings_corrected <- log1p(MGE_Tailings_corrected)

# 
mod_T <- varpart(MGE_Tailings_corrected$total.ARG.DepthPG, 
                 MGE_Tailings_corrected[,c(11:13)], 
                 MGE_Tailings_corrected[,5], 
                 MGE_Tailings_corrected[,1], 
                 MGE_Tailings_corrected[,c(2:3, 7)])

plot(mod_T, id.size = 1.1, cex = 1.2, digits = 1,alpha=130,
     Xnames = c("Plasmids",'Phage', "ICE","Unmobilizable MGE"),
     bg = c("#d55e00", "#f0e442", "#1976d2","#bcaaa4"))

# (2) Sewage

MGE_Sewage_corrected <- combination_sludge %>% column_to_rownames("sampleName")

# 

sapply(MGE_Sewage_corrected, class)

MGE_Sewage_corrected <- MGE_Sewage_corrected %>% select(where(is.numeric)) 

MGE_Sewage_corrected <- log1p(MGE_Sewage_corrected)

mod_S <- varpart(MGE_Sewage_corrected$total.ARG.DepthPG, 
                 MGE_Sewage_corrected[,c(11:13)], 
                 MGE_Sewage_corrected[,5], 
                 MGE_Sewage_corrected[,1], 
                 MGE_Sewage_corrected[,c(2:3, 7)])

plot(mod_S, id.size = 1.1, cex = 1.2, digits = 1,alpha=120,
     Xnames = c("Plasmids",'Phage', "ICE","Unmobilizable MGE"),
     bg = c("#d55e00", "#f0e442", "#1976d2","#bcaaa4"))

# (3) Farmland

MGE_Farmland_corrected <- combination_farmland %>% column_to_rownames("sampleName")

# 

sapply(MGE_Farmland_corrected, class) 

MGE_Farmland_corrected <- MGE_Farmland_corrected %>% select(where(is.numeric)) 

MGE_Farmland_corrected <- log1p(MGE_Farmland_corrected)

# 
mod_Fa <- varpart(MGE_Farmland_corrected$total.ARG.DepthPG, 
                  MGE_Farmland_corrected[,c(11:13)], 
                  MGE_Farmland_corrected[,5], 
                  MGE_Farmland_corrected[,1], 
                  MGE_Farmland_corrected[,c(2:3, 7)])

plot(mod_Fa, id.size = 1.1, cex = 1.2, digits = 1,alpha=120,
     Xnames = c("Plasmids",'Phage', "ICE","Unmobilizable MGE"),
     bg = c("#d55e00", "#f0e442", "#1976d2","#bcaaa4"))


# (4) Forest

MGE_Forest_corrected <- combination_forest %>% column_to_rownames("sampleName")

# 

sapply(MGE_Forest_corrected, class) 

MGE_Forest_corrected <- MGE_Forest_corrected %>% select(where(is.numeric)) 

MGE_Forest_corrected <- log1p(MGE_Forest_corrected)

# 

mod_Fo <- varpart(MGE_Forest_corrected$total.ARG.DepthPG, 
                  MGE_Forest_corrected[,c(11:13)], 
                  MGE_Forest_corrected[,5], 
                  MGE_Forest_corrected[,1], 
                  MGE_Forest_corrected[,c(2:3, 7)])

plot(mod_Fo, id.size = 1.1, cex = 1.2, digits = 1,alpha=120,
     Xnames = c("Plasmids",'Phage', "ICE","Unmobilizable MGE"),
     bg = c("#d55e00", "#f0e442", "#1976d2","#bcaaa4"))


# (5) Grass

MGE_Grass_corrected <- combination_grass %>% column_to_rownames("sampleName")

# 

sapply(MGE_Grass_corrected, class) # 

MGE_Grass_corrected <- MGE_Grass_corrected %>% select(where(is.numeric)) #

MGE_Grass_corrected <- log1p(MGE_Grass_corrected)

# 

mod_Gr <- varpart(MGE_Grass_corrected$total.ARG.DepthPG, 
                  MGE_Grass_corrected[,c(11:13)], 
                  MGE_Grass_corrected[,5], 
                  MGE_Grass_corrected[,1], 
                  MGE_Grass_corrected[,c(2:3, 7)])

plot(mod_Gr, id.size = 1.1, cex = 1.2, digits = 1,alpha=120,
     Xnames = c("Plasmids",'Phage', "ICE","Unmobilizable MGE"),
     bg = c("#d55e00", "#f0e442", "#1976d2","#bcaaa4"))


# (6) Gobi

MGE_Gobi_corrected <- combination_gobi %>% column_to_rownames("sampleName")

# 

sapply(MGE_Gobi_corrected, class) #

MGE_Gobi_corrected <- MGE_Gobi_corrected %>% select(where(is.numeric)) #

MGE_Gobi_corrected <- log1p(MGE_Gobi_corrected)

mod_Go <- varpart(MGE_Gobi_corrected$total.ARG.DepthPG, 
                  MGE_Gobi_corrected[,c(11:13)], 
                  MGE_Gobi_corrected[,5], 
                  MGE_Gobi_corrected[,1], 
                  MGE_Gobi_corrected[,c(2:3, 7)])

plot(mod_Go, id.size = 1.1, cex = 1.2, digits = 1,alpha=120,
     Xnames = c("Plasmids",'Phage', "ICE","Unmobilizable MGE"),
     bg = c("#d55e00", "#f0e442", "#1976d2","#bcaaa4"))

##### 2.ABT ------------------------------------------

# load ---
load("ARG_MGE_combined_unmobilizable_df.Rdata")

load("1_ARG_MGE_combined_df.Rdata")

combination <- combination_simple %>% select(-sampleName, -Integron, -IS, -Transposon, -PC2, -PC3)

colnames(combination)[which(colnames(combination) == "PC1")] <- "Unmobilizable_MGEs"

# 分生境
ARG_MGE_Fa <- combination %>% filter(sampleType == "farmland") %>% select(-sampleType)
ARG_MGE_Fo <- combination %>% filter(sampleType == "forest") %>% select(-sampleType)
ARG_MGE_Gr <- combination %>% filter(sampleType == "grass") %>% select(-sampleType)
ARG_MGE_Go <- combination %>% filter(sampleType == "gobi") %>% select(-sampleType)
ARG_MGE_T <- combination %>% filter(sampleType == "tailings") %>% select(-sampleType)
ARG_MGE_S <- combination %>% filter(sampleType == "Sludge") %>% select(-sampleType)

# analysis
# (1) Tailings --------------

set.seed(123)
fit <- gbm(total.ARG.DepthPG~. ,data = ARG_MGE_T, n.trees = 5000 ,cv.folds = 5, shrinkage = 0.01, n.minobsinnode = 10)
par(las=1)

ABT.fit_T_df <- summary(fit) %>% as.data.frame() %>% mutate(sampleType = rep("Tailings"))

ABT.fit_T_df$var <- factor(ABT.fit_T_df$var, level = rev(ABT.fit_T_df$var))

p_Tailings <- ggplot(ABT.fit_T_df) +
  aes(x = var, weight = rel.inf) +
  geom_bar(fill = "#EA5C15" ,color = 'black',alpha = 0.9 ,width = 0.8) +
  scale_y_continuous(expand = c(0, 0))+
  expand_limits(y=c(0,38))+ 
  theme_pubr(base_size = 16)+ 
  theme(axis.title = element_text(size = 12),
        axis.text.x = element_text(colour = "black"),
        axis.text.y = element_text(colour = "black"),
        panel.background = element_rect(fill = "ghostwhite")) +labs(x = "", y = "Relative influence (%)")+
  #labs(subtitle = "Method Genizi") +
  labs(title = "Tailings") +
  theme(axis.title = element_text(size = 20,
                                  vjust = 1)) + theme(axis.text.x = element_text(vjust = 1,hjust = 1)) +labs(x = '') + coord_flip()
p_Tailings


# (2) Gobi --------------

set.seed(123)
fit <- gbm(total.ARG.DepthPG~. ,data = ARG_MGE_Go,n.trees = 5000 ,cv.folds = 5, shrinkage = 0.001, n.minobsinnode = 1)
par(las=1)

ABT.fit_Go_df <- summary(fit) %>% as.data.frame() %>% mutate(sampleType = rep("Gobi"))

ABT.fit_Go_df$var <- factor(ABT.fit_Go_df$var, level = rev(ABT.fit_Go_df$var))

p_Go <- ggplot(ABT.fit_Go_df) +
  aes(x = var, weight = rel.inf) +
  geom_bar(fill = "#bdbdbd" ,color = 'black',alpha = 0.9 ,width = 0.8) +
  scale_y_continuous(expand = c(0, 0))+
  expand_limits(y=c(0,50))+ 
  theme_pubr(base_size = 16)+ 
  theme(axis.title = element_text(size = 12),
        axis.text.x = element_text(colour = "black"),
        axis.text.y = element_text(colour = "black"),
        panel.background = element_rect(fill = "ghostwhite")) +labs(x = "", y = "Relative influence (%)")+
  #labs(subtitle = "Method Genizi") +
  labs(title = "Gobi") +
  theme(axis.title = element_text(size = 20,
                                  vjust = 1)) + theme(axis.text.x = element_text(vjust = 1,hjust = 1)) +labs(x = '') + coord_flip()
p_Go


# sewage

set.seed(123)
fit <- gbm(total.ARG.DepthPG~. ,data = ARG_MGE_S,n.trees = 5000 ,cv.folds = 5, shrinkage = 0.01, n.minobsinnode = 5)
par(las=1)

ABT.fit_S_df <- summary(fit) %>% as.data.frame() %>% mutate(sampleType = rep("Sewage"))

ABT.fit_S_df$var <- factor(ABT.fit_S_df$var, level = rev(ABT.fit_S_df$var))

p_Sewage <- ggplot(ABT.fit_S_df) +
  aes(x = var, weight = rel.inf) +
  geom_bar(fill = "#7986cb" ,color = 'black',alpha = 0.9 ,width = 0.8) +
  scale_y_continuous(expand = c(0, 0))+
  expand_limits(y=c(0,40))+ 
  theme_pubr(base_size = 16)+ 
  theme(axis.title = element_text(size = 12),
        axis.text.x = element_text(colour = "black"),
        axis.text.y = element_text(colour = "black"),
        panel.background = element_rect(fill = "ghostwhite")) +labs(x = "", y = "Relative influence (%)")+
  #labs(subtitle = "Method Genizi") +
  labs(title = "Sewage") +
  theme(axis.title = element_text(size = 20,
                                  vjust = 1)) + theme(axis.text.x = element_text(vjust = 1,hjust = 1)) +labs(x = '') + coord_flip()
p_Sewage


# (4) Grass --------------

set.seed(123)
fit <- gbm(total.ARG.DepthPG~. ,data = ARG_MGE_Gr,n.trees = 5000 ,cv.folds = 5, shrinkage = 0.01, n.minobsinnode = 3)
par(las=1)

ABT.fit_Gr_df <- summary(fit) %>% as.data.frame() %>% mutate(sampleType = rep("Grass"))

ABT.fit_Gr_df$var <- factor(ABT.fit_Gr_df$var, level = rev(ABT.fit_Gr_df$var))

p_Grass <- ggplot(ABT.fit_Gr_df) +
  aes(x = var, weight = rel.inf) +
  geom_bar(fill = "#2c7fb8" ,color = 'black',alpha = 0.9 ,width = 0.8) +
  scale_y_continuous(expand = c(0, 0))+
  expand_limits(y=c(0,50))+ 
  theme_pubr(base_size = 16)+ 
  theme(axis.title = element_text(size = 12),
        axis.text.x = element_text(colour = "black"),
        axis.text.y = element_text(colour = "black"),
        panel.background = element_rect(fill = "ghostwhite")) +labs(x = "", y = "Relative influence (%)")+
  #labs(subtitle = "Method Genizi") +
  labs(title = "Grass") +
  theme(axis.title = element_text(size = 20,
                                  vjust = 1)) + theme(axis.text.x = element_text(vjust = 1,hjust = 1)) +labs(x = '') + coord_flip()
p_Grass

# (5) Farmland --------------

set.seed(123)

fit <- gbm(total.ARG.DepthPG~. ,data = ARG_MGE_Fa,n.trees = 5000 ,cv.folds = 5, shrinkage = 0.01, n.minobsinnode = 10)
par(las=1)

ABT.fit_Fa_df <- summary(fit) %>% as.data.frame() %>% mutate(sampleType = rep("Farmland"))

ABT.fit_Fa_df$var <- factor(ABT.fit_Fa_df$var, level = rev(ABT.fit_Fa_df$var))

p_Farmland <- ggplot(ABT.fit_Fa_df) +
  aes(x = var, weight = rel.inf) +
  geom_bar(fill = "#addd8e" ,color = 'black',alpha = 0.9 ,width = 0.8) +
  scale_y_continuous(expand = c(0, 0))+
  expand_limits(y=c(0,30))+ 
  theme_pubr(base_size = 16)+ 
  theme(axis.title = element_text(size = 12),
        axis.text.x = element_text(colour = "black"),
        axis.text.y = element_text(colour = "black"),
        panel.background = element_rect(fill = "ghostwhite")) +labs(x = "", y = "Relative influence (%)")+
  #labs(subtitle = "Method Genizi") +
  labs(title = "Farmland") +
  theme(axis.title = element_text(size = 20,
                                  vjust = 1)) + theme(axis.text.x = element_text(vjust = 1,hjust = 1)) +labs(x = '') + coord_flip()
p_Farmland

# (6) Forest --------------

set.seed(123)

fit <- gbm(total.ARG.DepthPG~. ,data = ARG_MGE_Fo,n.trees = 5000 ,cv.folds = 5, shrinkage = 0.01, n.minobsinnode = 10)
par(las=1)
ABT.fit_Fo_df <- summary(fit) %>% as.data.frame() %>% mutate(sampleType = rep("Forest"))

ABT.fit_Fo_df$var <- factor(ABT.fit_Fo_df$var, level = rev(ABT.fit_Fo_df$var))

p_Forest <- ggplot(ABT.fit_Fo_df) +
  aes(x = var, weight = rel.inf) +
  geom_bar(fill = "#7fcdbb" ,color = 'black',alpha = 0.9 ,width = 0.8) +
  scale_y_continuous(expand = c(0, 0))+
  expand_limits(y=c(0,40))+ 
  theme_pubr(base_size = 16)+ 
  theme(axis.title = element_text(size = 12),
        axis.text.x = element_text(colour = "black"),
        axis.text.y = element_text(colour = "black"),
        panel.background = element_rect(fill = "ghostwhite")) +labs(x = "", y = "Relative influence (%)")+
  #labs(subtitle = "Method Genizi") +
  labs(title = "Forest") +
  theme(axis.title = element_text(size = 20,
                                  vjust = 1)) + theme(axis.text.x = element_text(vjust = 1,hjust = 1)) +labs(x = '') + coord_flip()
p_Forest


library(patchwork)

layout <- "
ABC
DEF"






