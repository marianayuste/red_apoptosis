### ANALISIS 1.
#   Eliminar una por una las regulaciones de cada nodo
#   Recuperar attrs y vasijas
library(BoolNet)
setwd('/Users/mariana/Dropbox/redes_alfredo/red_apoptosis/analisis_1')

net <- loadNetwork('original.txt')
#attr <- getAttractors(net)
#plotAttractors(attr)

netprueba <- loadNetwork( '2.txt')
attr_prueba <- getAttractors(netprueba)
attr_prueba

for (c in 1:59) {
  filename <- paste(c,'.txt',sep='')
  net <- loadNetwork(filename)
  attr_prueba <- getAttractors(net,method='sat.exhaustive')
  nombre <- paste('attr_',c,'.txt',sep='')
  l <- c()
  for (a in attr_prueba[2]){for (b in a){l <- c(l,b[1])}} #guardar solo los atractores
  write.table(l,nombre,row.names = F,col.names = F)
}


#obtener total de regulaciones:
total_int <- 0
for(g in net$genes){
  print(g)
  print(length(net[['interactions']][[g]][['input']]))
  total_int <- total_int+length(net[['interactions']][[g]][['input']])
}
total_int
