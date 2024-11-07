#????Nature?ӿ?ѧ??ͼ??ggcor???????ط???????ͼ
#### ???ذ?
library(ggplot2)
library(ggcor)
library(dplyr)

metabolites<-read.csv('test_metabolism.csv',  header = T, sep = ",", row.names = 1)
head(metabolites)

spe <- read.csv('spectest_taxa.csv',  header = T, row.names = 1, sep = ",")
head(spe)
nrow(spe)
## ?t##alpha diversity 
library(vegan)
data_norm = spe ##row: sample col: bacteria
head(data_norm)
data_norm_shannon=diversity(data_norm, "shannon")
data_norm_shannon

data_ggplot=data.frame(data_norm_shannon)
head(data_ggplot)

dataplotB <- merge(data_ggplot, spe, by = 'row.names', all.x = T)
head(dataplotB)
rownames(dataplotB) = dataplotB[, 1]
dataplotB = dataplotB[, -1]
head(dataplotB)
dim(dataplotB)


mantel_microbes <- mantel_test(dataplotB, metabolites, mantel.fun = "mantel", ##default; 
                               spec.dist.method = "bray",
                               env.dist.method = "euclidean",
                               seed = 123,
                               spec.select =list(diversity = 1, microbes = 2:ncol(dataplotB))) %>%
  mutate(rd = cut(r, breaks = c(-Inf, 0.1,0.2, 0.4, Inf), ## Mantel's r value
                  labels = c("< 0.1", "0.1 - 0.2", "0.2 - 0.4", ">= 0.4")), ## Mantel's r color
         pd = cut(p.value, breaks = c(-Inf, 0.01, 0.05, 0.1, Inf),    ##Mantel's p
                  labels = c("< 0.01", "0.01 - 0.05", "0.05 - 0.1", ">=0.1"))) ##Mantel's p label
head(mantel_microbes)

quickcor(metabolites, type = "lower", method = "pearson",  cor.test = TRUE) + 
  geom_circle2() +
  geom_mark(r = NA,sig.thres = 0.05, size = 5, colour = "red") +
  scale_fill_gradient2( high = 'orange', mid = 'white',low = 'navyblue')+  #??ɫ????
  anno_link(aes(colour = pd, size = rd), data = mantel_microbes,curvature= 0.2) +
  scale_size_manual(values = c(0.5, 1, 1.5, 2)) + 
  scale_colour_manual(values = c("#1B9E77", "#D95F02", "#A2A2A288", "orange")) + ###��????ɫ
  guides(size = guide_legend(title = "Mantel's r",
                             override.aes = list(colour = "grey35"),order = 2),
         colour = guide_legend(title = "Mantel's p",
                               override.aes = list(size = 3),order = 1),
         fill = guide_colorbar(title = "Pearson correlation", order = 3))