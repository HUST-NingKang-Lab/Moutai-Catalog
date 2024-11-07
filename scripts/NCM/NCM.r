library(Hmisc)
library(minpack.lm)
library(stats4)
library(ggplot2)

species <-read.csv('test_taxa_count.csv',head=T,stringsAsFactors=F,row.names=1,sep = ",")
head(species)


getwd()
group<-read.csv("group.csv",head=T,stringsAsFactors=F,row.names=1,sep = ",")
head(group)

spp_group = merge(group, species, by = "row.names", all.x = T)
head(spp_group)

Xiasha = subset(spp_group,spp_group$Fermentation_stage == "AXiasha")
rownames(Xiasha) = Xiasha[, 1]
Xiasha = Xiasha[, -1]
Xiasha = Xiasha[, -1]
#head(Xiasha)

Zaosha = subset(spp_group,spp_group$Fermentation_stage == "AZaosha")
rownames(Zaosha) = Zaosha[, 1]
Zaosha = Zaosha[, -1]
Zaosha = Zaosha[, -1]
#head(Zaosha)

Round1 = subset(spp_group,spp_group$Fermentation_stage == "Round1")
rownames(Round1) = Round1[, 1]
Round1 = Round1[, -1]
Round1 = Round1[, -1]

Round2 = subset(spp_group,spp_group$Fermentation_stage == "Round2")
rownames(Round2) = Round2[, 1]
Round2 = Round2[, -1]
Round2 = Round2[, -1]
head(Round2)

Round3 = subset(spp_group,spp_group$Fermentation_stage == "Round3")
rownames(Round3) = Round3[, 1]
Round3 = Round3[, -1]
Round3 = Round3[, -1]
head(Round3)

Round4 = subset(spp_group,spp_group$Fermentation_stage == "Round4")
rownames(Round4) = Round4[, 1]
Round4 = Round4[, -1]
Round4 = Round4[, -1]
head(Round4)

Round5 = subset(spp_group,spp_group$Fermentation_stage == "Round5")
rownames(Round5) = Round5[, 1]
Round5 = Round5[, -1]
Round5 = Round5[, -1]
head(Round5)


ncm_taxa = spp_group
rownames(ncm_taxa) = ncm_taxa[, 1]
ncm_taxa = ncm_taxa[, -1]
ncm_taxa = ncm_taxa[, -1]
head(ncm_taxa)


spp = ncm_taxa  ##NCM for different fermentation stages
N <- mean(apply(spp, 1, sum)) 
p.m <- apply(spp, 2, mean) 

p.m <- p.m[p.m != 0]
p <- p.m/N
spp.bi <- 1*(spp>0)
freq <- apply(spp.bi, 2, mean)
freq <- freq[freq != 0]
C <- merge(p, freq, by=0) 
C <- C[order(C[,2]),]
C <- as.data.frame(C)
C.0 <- C[!(apply(C, 1, function(y) any(y == 0))),]
p <- C.0[,2]
freq <- C.0[,3]
names(p) <- C.0[,1]
names(freq) <- C.0[,1]
d = 1/N
m.fit <- nlsLM(freq ~ pbeta(d, N*m*p, N*m*(1 -p), lower.tail=FALSE),start=list(m=0.1))
m.fit  #??ȡ m ֵ
m.ci <- confint(m.fit, 'm', level=0.95)
freq.pred <- pbeta(d, N*coef(m.fit)*p, N*coef(m.fit)*(1 -p), lower.tail=FALSE)
pred.ci <- binconf(freq.pred*nrow(spp), nrow(spp), alpha=0.05, method="wilson", return.df=TRUE)
Rsqr <- 1 - (sum((freq - freq.pred)^2))/(sum((freq - mean(freq))^2))
Rsqr

bacnlsALL <-data.frame(p,freq,freq.pred,pred.ci[,2:3])
inter.col<-rep('black',nrow(bacnlsALL))
inter.col[bacnlsALL$freq <= bacnlsALL$Lower]<-'#A52A2A'
inter.col[bacnlsALL$freq >= bacnlsALL$Upper]<-'#29A6A6'
length(bacnlsALL$Upper)
length(bacnlsALL$Lower)


library(grid)
grid.newpage()
pushViewport(viewport(h=0.6,w=0.6))
pushViewport(dataViewport(xData=range(log10(bacnlsALL$p)), yData=c(0,1.02),extension=c(0.02,0)))
grid.rect()
grid.points(log10(bacnlsALL$p), bacnlsALL$freq,pch=20,gp=gpar(col=inter.col,cex=0.7))
grid.yaxis()
grid.xaxis()
grid.lines(log10(bacnlsALL$p),bacnlsALL$freq.pred,gp=gpar(col='blue',lwd=2),default='native')

grid.lines(log10(bacnlsALL$p),bacnlsALL$Lower ,gp=gpar(col='blue',lwd=2,lty=2),default='native') 
grid.lines(log10(bacnlsALL$p),bacnlsALL$Upper,gp=gpar(col='blue',lwd=2,lty=2),default='native')  
grid.text(y=unit(0,'npc')-unit(2.5,'lines'),label='Mean Relative Abundance (log10)', gp=gpar(fontface=2)) ## x-title
grid.text(x=unit(0,'npc')-unit(3,'lines'),label='Frequency of Occurance',gp=gpar(fontface=2),rot=90) 
grid.text(x=unit(0,'npc')-unit(-1,'lines'), y=unit(0,'npc')-unit(-15,'lines'),label='Mean Relative Abundance (log)', gp=gpar(fontface=2))
grid.text(round(coef(m.fit)*N),x=unit(0,'npc')-unit(-5,'lines'), y=unit(0,'npc')-unit(-15,'lines'),gp=gpar(fontface=2))
grid.text(label = "Nm=",x=unit(0,'npc')-unit(-3,'lines'), y=unit(0,'npc')-unit(-15,'lines'),gp=gpar(fontface=2))
grid.text(round(Rsqr,2),x=unit(0,'npc')-unit(-5,'lines'), y=unit(0,'npc')-unit(-16,'lines'),gp=gpar(fontface=2))
grid.text(label = "Rsqr=",x=unit(0,'npc')-unit(-3,'lines'), y=unit(0,'npc')-unit(-16,'lines'),gp=gpar(fontface=2))
draw.text <- function(just, i, j) {
  grid.text(paste("Rsqr=",round(Rsqr,3),"\n","Nm=",round(coef(m.fit)*N)), x=x[j], y=y[i], just=just)
  # grid.text(deparse(substitute(just)), x=x[j], y=y[i] + unit(2, "lines"),
  #          gp=gpar(col="red", fontsize=8))
}
x <- unit(1:4/5, "npc")
y <- unit(1:4/5, "npc")
draw.text(c("centre", "bottom"), 4, 1)