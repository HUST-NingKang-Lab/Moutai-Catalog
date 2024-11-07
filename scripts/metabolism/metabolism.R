
library(reshape2)
library(gridExtra) 
library(magrittr)  
library(vegan)
#install.packages('ggpubr')
library(ggridges) 
library(ggplot2)
library(ggprism)
library(ggpubr) ## stat_compare_means

data_metabolites <- read.csv("test_metabolism.csv", sep = ",", header = T, row.names = 1)
head(data_metabolites)

data_group  <- read.csv("group.csv", sep = ",", header = T, row.names = 1)
head(data_group)

data_metabolites_group = merge(data_group, data_metabolites, by = "row.names", all.x = T)
colnames(data_metabolites_group)[1] = c("SampleID")
head(data_metabolites_group)


dataplot = melt(data_metabolites_group, id.vars = list("SampleID", "Fermentation_stage"))
head(dataplot)

##density plot
density_metabolites<- ggplot(dataplot, aes(x = value, y = Fermentation_stage, fill = Fermentation_stage)) +
  geom_density_ridges( alpha=0.7)+
  theme_ridges() +
  facet_wrap(.~variable, scales = "free", ncol = 4)+
  ggprism::theme_prism( base_fontface = "plain", base_size = 20)+ ##边框变成 x-y axis
  labs(x="Fermentation time", y="Metabolites")+
  theme(axis.text.x = element_text( face = "plain",color="black", angle = 0, size= 18), # 设置x轴字体大小，角度，以下同理
        axis.text.y = element_text( face = "plain",color="black", size=18), 
        axis.title.x = element_text(family = "",face = "plain", size=18), 
        axis.title.y = element_text(face = "plain", size=18),
        axis.line.x=element_line(linetype=1,color="black", size = 0.4),
        axis.line.y=element_line(linetype=1,color="black", size = 0.4),
        axis.ticks.x=element_line(color="black",size=0.4,lineend = 0.1),
        axis.ticks.length.x = unit(0.1,"cm"),
        axis.ticks.length.y = unit(0.1,"cm"),
        axis.ticks.y=element_line(color="black",size=0.4,lineend = 0.1),
        panel.grid=element_blank(), 
        panel.grid.minor=element_blank(), 
        panel.grid.major =element_blank(), 
        panel.background=element_blank(), 
        legend.position="right",
        legend.title = element_text( face = "plain",color="black",  size= 18),
        legend.text = element_text( face = "plain",color="black",  size= 18))
density_metabolites


##pcoa:
head(data_metabolites)
dataSpe<- data_metabolites ## row: samples, col: taxa
head(dataSpe)
distance <- vegdist(dataSpe, method = "jaccard") ##bray
head(distance)

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


PCoA_metabolites <- ggplot(dataplotP, aes(PCoA1, PCoA2, col = Fermentation_stage  )) +
  theme(panel.grid =element_blank(), panel.background = element_rect(color = 'black', fill = 'transparent'),
        legend.key = element_rect(fill = 'transparent'))+ #去掉背景框
  geom_vline(xintercept = 0, color = 'black', size = 0.4, linetype=2) + ##x = 0 
  geom_hline(yintercept = 0, color = 'black', size = 0.4, linetype=2) + ##y = 0
  # stat_ellipse(level = 0.8,lwd=0,aes(x = PCoA1, y = PCoA2, fill = Group  ), geom = "polygon",alpha = 1/4,show.legend = F)+
  # stat_ellipse(level = 0.9,aes(color = Group ),lwd=1, linetype=2)+ #绘制90%置信圈
  geom_point( size = 2.8, alpha = 0.9) + #可在这里修改点的透明度、大小
  #scale_shape_manual(values = c(15:26)) + #可在这里修改点的形状，特征有几个，values的值，对应的也要增加。#shape order Soil,Rhizospher,Soil,Rhizospher,Unknown,Unknown
  guides(fill = guide_legend(order = 1), shape = guide_legend(order = 3), color = guide_legend(order = 2)) +#设置图例展示顺序
  theme(axis.title.y =element_text(vjust = 0.5))+
  labs(x = paste('PCoA1: ', round(pcoa_eig[1], 2), '%'), y = paste('PCoA2: ', round(pcoa_eig[2], 2), '%'))+#dune_adonis) +
  #geom_text_repel(label= data_Cohort1[, 1])+
  theme(#legend.title=element_blank(),
    legend.position="right",
    legend.title = element_text(size=14),
    legend.text = element_text(size=14),
    axis.line.x=element_line(linetype=1,color="black",size=0.4),
    axis.line.y=element_line(linetype=1,color="black",size=0.4),
    panel.border=element_rect(fill=NA),##边框
    panel.grid.minor=element_blank(), ##减少横向网格线
    panel.background=element_blank(), ##背景设置成空白
    axis.text.x=element_text(size=16,colour="black"),##设置字体颜色
    axis.text.y=element_text(size=16,colour="black"),
    axis.title.x=element_text(size=16, colour="black", angle = 0),##设置标题字体大小
    axis.title.y=element_text(size=16, colour="black", angle = 90))
PCoA_metabolites
