library(BoolNet)
setwd('/Users/mariana/Dropbox/redes_alfredo/red_apoptosis/analisis_2/perturbaciones')

# NODOS Y TOTAL DE SUS PERTURBACIONES----------
nodes = c('ICL','FAcore','FANCD2I','Nuc1','RNF4','Nuc2','ADD','DSB','TLS','FAhrr','HRR2','NHEJ','TNFa','p38MAPK','ATR','ATM','p53','MDM2','p53a','p21','p53aRE','p53k','p53kRE','CASP3','IAP','Wip1','CDK1_AurA','Plk1','CDC25','CycB_CDK1')
total_per = c(3, 6, 3, 3, 2, 8, 4, 10, 2, 13, 5, 12, 5, 2, 6, 7, 6, 3, 6, 2, 4, 35, 5, 3, 1, 2, 6, 8, 7, 6)

#CARGAR CADA RED PERTURBADA Y OBTENER ATRACTORES
#las redes perturbadas se generaron en python documento bitflip.ipynb
#elegir sólo 150 redes a analizar sus attrs 
#(y guardar cuáles de ellas ya se eligieron pa no repetirñas)
elegidas <- matrix(nrow=150, ncol=2, byrow=TRUE)
per = 1
while(per<150){ #250 redes elegidas al azar
  #seleccionar un gen al azar
  n <- sample(length(nodes),1) #numero del nodo elegido al azar
  #del gen seleccionado, elegir una perturbacion al azar
  p <- sample(total_per[n],1)
  
  #guardar la perturbacion hecha
  elegida <- c(elegida,c(n,p))
  archivo <- paste(nodes[n],'_',p,'.txt', sep='')


pru <- matrix(nrow=9,ncol=2,byrow=TRUE)
let <- c('a','b','c')
num <- c(1,2,3)
i <- 1
for (l in let){
  for (n in num){
    pru[i,] <- c(l,n)
    i <- i+1
  }
}

d<- c('c',3)
if (is.element(d, pru)){
  print(7)
}


for (n in 1:length(nodes)){ #para cada nodo
  for (p in 0:(total_per[n]-1)){ #para cada perturbacion
    archivo <- paste(nodes[n],'_',p,'.txt', sep='')
    net <- loadNetwork(archivo)
    attr <- getAttractors(net,method='sat.exhaustive') #sat.exhaustive solo da attrs, no indica vasijas
    nombre <- paste(nodes[n],'_',p,'_attrs.txt', sep='')
    l = c()
    for (a in attr[2]){for (b in a){l <- c(l,b[1])}} #guardar solo los atractores
    write.table(l,nombre,row.names = F,col.names = F)
  }
}
