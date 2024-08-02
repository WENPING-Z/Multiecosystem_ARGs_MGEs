
# library
library(dplyr)
library(ggplot2)
library(ggpubr)
library(gg.gap) 
library(ggbreak)
library(reshape2)

# 1. ARG-carrying MGEs composition --------------------------------
# load
ARG_MGE_percentage_yes_df <- read.csv("1_ARG_MGE_percentage_yes_df.csv")

# plot 
plotData <- ARG_MGE_percentage_yes_df
plotData <- plotData[-4,] 
plotData$MGE_type_final <- factor(plotData$MGE_type_final, levels = plotData$MGE_type_final) 

p1 <- ggplot(plotData) +
  aes(x = MGE_type_final, y = Number, fill = MGE_type_final ,color = MGE_type_final) +
  geom_bar(alpha = 0.95 ,width = 0.8, stat = "identity") +
  scale_fill_manual(values = c("#1976d2","#dce775", "#2e7d32" ,"#f1e54c","#d0c0a5","#d7660d")) +
  scale_color_manual(values = c("#1976d2","#dce775","#2e7d32" ,"#f1e54c","#d0c0a5","#d7660d")) +
  #scale_y_discrete(expand = c(0, 0))+
  expand_limits(y=c(0,90000))+
  theme_test(base_size = 14)+ 
  theme(axis.title = element_text(size = 12),
        axis.text.x = element_text(colour = "black"),
        axis.text.y = element_text(colour = "black"),
        panel.background = element_rect(fill = "white"),
        legend.position = "NULL") +
  labs(x = "", y = "No.of MGE-carrying-ARGs") +
  theme(axis.title = element_text(size = 14,
                                  vjust = 1)) + theme(axis.text.x = element_text(vjust = 1,hjust = 1))  #+ coord_flip()

p1

p2 <- p1 + coord_flip() +  scale_y_break(c(900,10000), scales = 0.4, space = 0.1,) 

p2

# 
plotData$MGE_type_final <- factor(plotData$MGE_type_final, levels = plotData$MGE_type_final) 

ARG_MGE_Number_percentage <- ggdonutchart(plotData[,c(2,3)], "Number",
                                          label = "MGE_type_final",                               
                                          fill = "MGE_type_final",                            
                                          color = "white",   size = 0,                           
                                          palette = c("#1976d2","#dce775", "#2e7d32" ,"#f1e54c","#d0c0a5","#d7660d"),
                                          ggtheme = theme_pubr()) + # #bbded6
  theme(axis.text.x = element_blank(), legend.position = "NULL")

ARG_MGE_Number_percentage

# 2. MGE composition ---------------

drug_depth_df <- fread("drug_depth.txt")

drug_depth_df$sampleType <- factor(drug_depth_df$sampleType, levels = c("Gobi", "Grass", "Forest", "Farmland","Sludge", "Tailings"))

drug_depth_df$MGE_type_final <- factor(drug_depth_df$MGE_type_final, 
                                       levels = c("Plasmids","Transposon", "ICE","Phage", "IS","Integron"))

p_ARG_MGE <- ggplot(drug_depth_df, aes(x = sampleType, y = drug_percent, fill= MGE_type_final))  + geom_col(width = 0.7) +  
  scale_fill_manual(values = c("#d7660d","#2e7d32" ,"#1976d2","#dce775","#d0c0a5", "#f1e54c")) + 
  theme(axis.text.x = element_text(hjust = 0.5, vjust = 0.5)) + 
  theme_test(base_size = 14) +
  scale_y_continuous(expand = c(0.0001, 0.015)) +
  scale_x_discrete(expand = c(0.12, 0.02)) +
  xlab("") + ylab("Composition of MGE types in MGE-carrying ARGs") + #+ guides(fill = guide_legend(nrow=2)) 
  theme(legend.position="right") +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.background = element_blank()) + 
  theme(axis.ticks = element_line(colour = "black"), axis.text = element_text(colour = "black")) + 
  theme(axis.text.x = element_text(angle = 0, hjust = 0.5, vjust = 0.5)) +
  scale_x_discrete(labels = c("tailings" = "Tailings", "Sludge" = "Sewage", "farmland" = "Farmland", 
                              "forest" = "Forest","grass" = "Grassland","gobi" = "Gobi desert"))# + coord_flip() +

p_ARG_MGE +labs(fill="MGE types") + coord_flip()

# 3. Abundance of ARG-carrying MGEs ----------------------------------------------
ARG_MGE_total_abundance <- fread("ARG_MGE_total_abundance.txt")

ARG_MGE_total_abundance$sampleType <- factor(ARG_MGE_total_abundance$sampleType, 
                                             levels= c("Tailings", "Sludge", "Farmland","Forest","Grass","Gobi"))

#
p3 <- ggboxplot(data = ARG_MGE_total_abundance, 
                
                x="sampleType", y="DepthPG", fill  = "sampleType", alpha=0.7, width = 0.6, size = 0.5, alpha=0.4,
                
                color="lightslategray",outlier.shape = NA) +
  
  geom_jitter(aes(x=sampleType, y=DepthPG, color = sampleType), width = 0.2, size=3, alpha=0.5) + 
  
  scale_fill_manual(values = c('#EA5C15','#7986cb',"#addd8e" , "#7fcdbb","#2c7fb8","#bdbdbd")) +
  
  scale_color_manual(values = c('#EA5C15','#7986cb',"#addd8e" , "#7fcdbb","#2c7fb8","#bdbdbd")) + 
  
  theme_test() + 
  
  theme(axis.text.x = element_text(angle = 45, hjust = 0.5, vjust = 0.5)) +
  
  ylab("The abundance of MGE-carrying \n -ARGs (coverage, x/Gb)") + xlab("") + 
  
  #ylim(50, 4100) +
  
  theme(axis.ticks = element_line(colour = "black"), axis.text = element_text(colour = "black")) + 
  
  scale_x_discrete(labels=c("Tailings", "Sewage","Farmland","Forest", "Grass","Gobi")) +
  
  theme(legend.position = "none", panel.grid = element_blank())

p3


# 4. Abundance of ARG-carrying MGEs in different habitats ------------------------------------------------
ARG_MGE_abundance_type <- fread("ARG_MGE_abundance_type.txt")

#
ARG_MGE_abundance_type$sampleType <- factor(ARG_MGE_abundance_type$sampleType, levels= c("Tailings", "Sludge", "Farmland","Forest","Grass","Gobi"))
ARG_MGE_abundance_type$MGE_type_final <- factor(ARG_MGE_abundance_type$MGE_type_final, levels = c("Plasmids", "Phage", "ICE", "Transposon", "IS", "Integron"))

p_type_abundance <- ggboxplot(data = ARG_MGE_abundance_type, 
                              
                              x="sampleType", y="DepthPG", alpha=0.7, width = 0.8, size = 0.45, alpha=0.4,
                              
                              color="black",outlier.shape = NA) +
  facet_wrap(.~MGE_type_final, scales = "free", nrow = 2, ncol = 3) +
  
  geom_jitter(aes(x=sampleType, y=DepthPG, color = sampleType), width = 0.2, size=3, alpha=0.5) + 
  
  scale_fill_manual(values = c('#EA5C15','#7986cb',"#addd8e" , "#7fcdbb","#2c7fb8","#bdbdbd")) +
  
  scale_color_manual(values = c('#EA5C15','#7986cb',"#addd8e" , "#7fcdbb","#2c7fb8","#bdbdbd")) + 
  
  theme_cleveland() + 
  
  theme(axis.text.x = element_text(angle = 45, hjust = 0.5, vjust = 0.5)) +
  
  ylab("The abundance of MGE carrying ARG (coverage, x/Gb)") + xlab("") + 
  
  #ylim(50, 4100) +
  
  theme(axis.ticks = element_line(colour = "black"), axis.text = element_text(colour = "black")) + 
  
  scale_x_discrete(labels=c("Tailings", "Sewage","Farmland","Forest", "Grass","Gobi")) +
  
  theme(legend.position = "none", panel.grid = element_blank())

p_type_abundance



