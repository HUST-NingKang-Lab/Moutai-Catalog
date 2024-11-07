library(ggplot2)
library(ggprism)
library(reshape2)
library(ade4)
library(vegan)
library(ggpubr)

##figure2A: alpha diversity
data_taxa <- read.csv("test_taxa.csv", sep = ",", header = T, row.names = 1)
head(data_taxa)

data_norm = data_taxa ##row: sample col: bacteria
head(data_norm)
data_norm_shannon=diversity(data_norm, "shannon")
data_norm_shannon

data_ggplot=data.frame(data_norm_shannon)
head(data_ggplot)

data_group <- read.csv("group.csv", sep = ",", header = T, row.names = 1)
head(data_group)

dataplotB <- merge(data_ggplot, data_group, by = 'row.names', all.x = T)
head(dataplotB)

my_comparisons <- list(c("AXiasha", "AZaosha"),c("AXiasha", "Round1"), c("AXiasha", "Round2"),
                       c("AXiasha", "Round3"),c("AXiasha", "Round4"),c("AXiasha", "Round5"), 
                       c("AZaosha", "Round1"),c("AZaosha", "Round2"),c("AZaosha", "Round3"),
                       c("AZaosha", "Round4"),c("AZaosha", "Round5"), 
                       c("Round1", "Round2"),c("Round1", "Round3"),c("Round1", "Round4"),c("Round1", "Round5"), 
                       c("Round2", "Round3"),c("Round2", "Round4"),c("Round2", "Round5"), 
                       c("Round3", "Round4"),c("Round3", "Round5"),c("Round4", "Round5")
)

Figure3A <- ggplot(dataplotB, aes(x = Fermentation_stage, y = data_norm_shannon, fill = Fermentation_stage)) + 
  geom_boxplot(aes(fill = Fermentation_stage)) +
  stat_compare_means(label.y.npc = 15)+ ##global
  stat_compare_means(comparisons = my_comparisons,label = "p.signif",map_signif_level = TRUE, method = "wilcox.test")+  
  ggprism::theme_prism( base_fontface = "plain",base_size = 16)+ 
  labs(x=" Fermentation stage ", y="Shanno index")+   
  theme(axis.text.x = element_text(face = "plain",color="black", angle = 90, size= 16), # ????x????????С???Ƕȣ?????ͬ??
        axis.text.y = element_text(face = "plain",color="black", size=16), 
        axis.title.x = element_text(family = "",face = "plain", size=16), 
        axis.title.y = element_text(face = "plain", size=16),
        axis.line.x=element_line(linetype=1,color="black",size=0.4),
        axis.line.y=element_line(linetype=1,color="black",size=0.4),
        axis.ticks.x=element_line(color="black",size=0.4,lineend = 0.1),
        axis.ticks.length.x = unit(0.1,"cm"),
        axis.ticks.length.y = unit(0.1,"cm"),
        axis.ticks.y=element_line(color="black",size=0.4,lineend = 0.1),
        panel.grid=element_blank(), 
        panel.grid.minor=element_blank(), 
        panel.grid.major =element_blank(), 
        panel.background=element_blank(), 
        legend.position="none",
        legend.title = element_text(face = "plain",color="black",  size= 16),
        legend.text = element_text(face = "plain",color="black",  size= 16))
Figure3A


##figure 3B: beta diversity
dataSpe<- data_taxa
head(dataSpe)
distance <- vegdist(dataSpe, method = "jaccard") 
head(distance)
dim(distance)

pcoa <- cmdscale(distance, k = (nrow(dataSpe) - 1), eig = T)
pcoa_eig <- {pcoa$eig}[1:2]
dataplotG <- data.frame({pcoa$point})[1:2]
dataplotG$SampleID <- rownames(dataplotG)
names(dataplotG)[1:2] <- c('PCoA1', 'PCoA2')
dataEnv<- data_group
head(dataEnv)
dataplotP <- merge(dataplotG, dataEnv, by = 'row.names', all.x = T)
colnames(dataplotP)[1] = c("SampleID")
dataplotP = dataplotP[, -4]
head(dataplotP)


PCoA_taxa <- ggplot(dataplotP, aes(PCoA1, PCoA2, col = Fermentation_stage)) +
  theme(panel.grid =element_blank(), panel.background = element_rect(color = 'black', fill = 'transparent'),
        legend.key = element_rect(fill = 'transparent'))+ 
  geom_vline(xintercept = 0, color = 'black', size = 0.4, linetype=2) + ##x = 0 
  geom_hline(yintercept = 0, color = 'black', size = 0.4, linetype=2) + ##y = 0
  geom_point( size = 2.8, alpha = 0.9) + 
  guides(fill = guide_legend(order = 1), shape = guide_legend(order = 3), 
         color = guide_legend(order = 2)) +
  theme(axis.title.y =element_text(vjust = 0.5))+
  labs(x = paste('PCoA1: ', round(pcoa_eig[1], 2), '%'), 
       y = paste('PCoA2: ', round(pcoa_eig[2], 2), '%'))+
  theme(#legend.title=element_blank(),
    legend.position="none",
    legend.title = element_text(size=14),
    legend.text = element_text(size=14),
    axis.line.x=element_line(linetype=1,color="black",size=0.4),
    axis.line.y=element_line(linetype=1,color="black",size=0.4),
    panel.border=element_rect(fill=NA),
    panel.grid.minor=element_blank(), 
    panel.background=element_blank(), 
    axis.text.x=element_text(size=16, colour="black"),
    axis.text.y=element_text(size=16, colour="black", angle = 90),
    axis.title.x=element_text(size=16, colour="black", angle = 0))
PCoA_taxa


head(dataplotP)
PCoA1_taxa <- ggplot(dataplotP, aes(x = Fermentation_stage, y = PCoA1 , fill = Fermentation_stage)) + 
  geom_boxplot(aes(fill = Fermentation_stage)) +
  stat_compare_means()+ 
  stat_compare_means(comparisons = my_comparisons,label = "p.signif", method = "wilcox.test")+   
  ggprism::theme_prism(base_fontface = "plain",base_size = 16)+ 
  coord_flip() +
  labs(y="PCoA1")+ 
  theme(axis.text.x = element_text( face = 'plain',color='black', angle = 0, size= 16), 
        axis.text.y = element_text(face = "plain",color="black", size=16), 
        axis.title.x = element_text(family = "",face = "plain", size=16), 
        axis.title.y = element_text(family = "Arial",face = "plain", size=16),
        axis.line.x=element_line(linetype=1,color="black",size=0.4),
        axis.line.y=element_line(linetype=1,color="black",size=0.4),
        axis.ticks.x=element_line(color="black",size=0.4,lineend = 0.1),
        axis.ticks.length.x = unit(0.1,"cm"),
        axis.ticks.length.y = unit(0.1,"cm"),
        axis.ticks.y=element_line(color="black",size=0.4,lineend = 0.1),
        panel.grid=element_blank(),
        panel.grid.minor=element_blank(), 
        panel.grid.major =element_blank(),
        panel.background=element_blank(), 
        legend.position="none",
        legend.title = element_text(face = "plain",color="black",  size= 16),
        legend.text = element_text(face = "plain",color="black",  size= 16))
PCoA1_taxa

PCoA2_taxa <- ggplot(dataplotP, aes(x = Fermentation_stage, y = PCoA2, fill = Fermentation_stage)) + 
  geom_boxplot(aes(fill = Fermentation_stage)) +
  stat_compare_means()+ 
  stat_compare_means(comparisons = my_comparisons,label = "p.signif", method = "wilcox.test")+   
  ggprism::theme_prism(base_fontface = "plain",base_size = 16)+ 
  #coord_flip() +
  labs(y="PCoA2", x="Fermentation stage")+   
  theme(axis.text.x = element_text( face = 'plain',color='black', angle = 90, size= 16), 
        axis.text.y = element_text(face = "plain",color="black", angle = 0, size=16), 
        axis.title.x = element_text(family = "",face = "plain", size=16), 
        axis.title.y = element_text(family = "Arial",face = "plain", size=16),
        axis.line.x=element_line(linetype=1,color="black",size=0.4),
        axis.line.y=element_line(linetype=1,color="black",size=0.4),
        axis.ticks.x=element_line(color="black",size=0.4,lineend = 0.1),
        axis.ticks.length.x = unit(0.1,"cm"),
        axis.ticks.length.y = unit(0.1,"cm"),
        axis.ticks.y=element_line(color="black",size=0.4,lineend = 0.1),
        panel.grid=element_blank(),
        panel.grid.minor=element_blank(), 
        panel.grid.major =element_blank(),
        panel.background=element_blank(), 
        legend.position="none",
        legend.title = element_text(face = "plain",color="black",  size= 16),
        legend.text = element_text(face = "plain",color="black",  size= 16))
PCoA2_taxa

Figure3B <- grid.arrange(PCoA_taxa, PCoA2_taxa, PCoA1_taxa,
                                  nrow=2, ncol=2, widths=c(6,2),heights=c(6, 2))
Figure3B



diversity <- grid.arrange(Figure3A, Figure3B,
                                   nrow=1, ncol=2, widths=c(2,6),heights=c(5.5))
diversity


##Figure 3C


