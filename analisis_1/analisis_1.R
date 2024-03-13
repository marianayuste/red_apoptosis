### ANALISIS 1.
#   Eliminar una por una las regulaciones de cada nodo
#   Recuperar attrs y vasijas
library(BoolNet)
library(foreach)
library(doMC)
registerDoMC(2) #my mac has 2 cores
setwd('/Users/mariana/Dropbox/redes_alfredo/red_apoptosis/analisis_1')

### Probar paralelización del código
setwd('/Users/mariana/Dropbox/redes_alfredo/red_apoptosis/test_parallel/')
start_time <- Sys.time()
for(c in 0:500){ #Total time: 6.6893789768219. Slow but gives each result as soon as is created
  #foreach(c=0:500) %dopar% { #Total time: 5.35348200798035. Faster but gives all the results at the end
  filename <- '0.txt'
  net <- loadNetwork(filename)
  attr_prueba <- getAttractors(net,method='sat.exhaustive')
  nombre <- paste('attr_',c,'.txt',sep='')
  l <- c()
  for (a in attr_prueba[2]){for (b in a){l <- c(l,b[1])}} #guardar solo los atractores
  write.table(l,nombre,row.names = F,col.names = F)
  print(c)
}
end_time <- Sys.time()
print(paste('Total time:',end_time-start_time))


### Correr las redes con cada modificación (en documentos .txt hechos a mano)
#foreach(c=62:65) %dopar% {
for(c in 62:117){
  start <- Sys.time()
  filename <- paste(c,'.txt',sep='')
  net <- loadNetwork(filename)
  attr_prueba <- getAttractors(net,method='sat.exhaustive')
  nombre <- paste('attr_',c,'.txt',sep='')
  l <- c()
  for (a in attr_prueba[2]){for (b in a){l <- c(l,b[1])}} #guardar solo los atractores
  write.table(l,nombre,row.names = F,col.names = F)
  end <- Sys.time()
  print(paste('Finished with ',c,' - time taked: ',end-start))
}

net <- loadNetwork('original.txt')
#attr <- getAttractors(net)
#plotAttractors(attr)

#obtener total de regulaciones:
total_int <- 0
for(g in net$genes){
  print(g)
  print(length(net[['interactions']][[g]][['input']]))
  total_int <- total_int+length(net[['interactions']][[g]][['input']])
}
total_int
