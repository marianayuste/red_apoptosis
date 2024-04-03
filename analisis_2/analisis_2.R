library(BoolNet)
setwd('/Users/mariana/Dropbox/redes_alfredo/red_apoptosis/analisis_2/perturbaciones')

nodes = c('ICL','FAcore','FANCD2I','Nuc1','RNF4','Nuc2','ADD','DSB','TLS','FAhrr','HRR2','NHEJ','TNFa','p38MAPK','ATR','ATM','p530','MDM2','p53a0','p21','p53aRE','p53k0','p53kRE','CASP3','IAP','Wip1','CDK1_AurA','Plk1','CDC25','CycB_CDK1')

#CARGAR CADA RED PERTURBADA Y OBTENER ATRACTORES
#las redes perturbadas elegidas se generaron en python documento bitflip.ipynb
data <- read.csv('elegidas.txt', header = F,sep = ';')
elegidas <- data[-length(data)]

#OBTENER LOS ATTRS DE CADA PERTURBACION
for (p in elegidas){ #para cada perturbación
  nodo <- strsplit(p, split=',')[1] #nodo de la perturbación
  per <- strsplit(p, split=',')[2] #numero de perturbación
  archivo <- paste(nodo,'_',per,'.txt',sep='')
  net <- loadNetwork(archivo)
  attr <- getAttractors(net,method='sat.exhaustive') #sat.exhaustive solo da attrs, no indica vasijas
  nombre <- paste(nodo,'_',per,'_attrs.txt', sep='')
  l = c()
  for (a in attr[2]){for (b in a){l <- c(l,b[1])}} #guardar solo los atractores
  write.table(l,nombre,row.names = F,col.names = F)
  rm(list = ls())
}

