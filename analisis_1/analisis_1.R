### ANALISIS 1.
#   Eliminar una por una las regulaciones de cada nodo
#   Recuperar attrs y vasijas
library(BoolNet)
setwd('/Users/mariana/Dropbox/redes_alfredo/red_apoptosis/analisis_1')

#################################
### Correr las redes con cada modificación (en documentos .txt hechos a mano)
#foreach(c=62:65) %dopar% { #de esta forma se podía paralelizar en diferentes núcleos, pero no funcionó bien aquí
print('empezó:',str(Sys.time()))
for(c in c(1)){
  start <- Sys.time()
  filename <- paste(c,'.txt',sep='')
  net <- loadNetwork(filename)
  attr <- getAttractors(net,method='sat.exhaustive')
  nombre <- paste('attr_',c,'.txt',sep='')
  l <- c()
  for (a in attr[2]){for (b in a){l <- c(l,b[1])}} #guardar solo los atractores
  write.table(l,nombre,row.names = F,col.names = F)
  attr <- 0
  end <- Sys.time()
  print(paste('Finished with ',c,' - began:',start,', end:', end,', time taked:',end-start))
}

# NOTAS:
# me salté el numero 144 al crear las redes perturbadas
#   pero todas las perturbaciones sí están en los txt
# repetir el 1 (corregir la red perturbada)
# falta del 20 al 59
# del 60 al 64 se repitieron los de HRR2, no tomarlos en cuenta


#####################################
### Probar paralelización del código
setwd('/Users/mariana/Dropbox/redes_alfredo/red_apoptosis/pruebas')
start_time <- Sys.time()
for(c in 0:500){ #Total time: 6.6893789768219. Slow but gives each result as soon as is created
  #foreach(c=0:500) %dopar% { #Total time: 5.35348200798035. Faster but gives all the results at the end
  filename <- 'test.txt'
  net <- loadNetwork(filename)
  attr_prueba <- getAttractors(net,method='sat.exhaustive')
  nombre <- paste('attr_',c,'.txt',sep='')
  l <- c()
  for (a in attr_prueba[2]){for (b in a){l <- c(l,b[1])}} #guardar solo los atractores
  write.table(l,nombre,row.names = F,col.names = F)
  #attr_prueba <- 0
  print(c)
}
end_time <- Sys.time()
print(paste('Total time:',end_time-start_time))


#obtener total de regulaciones:
total_int <- 0
for(g in net$genes){
  print(g)
  print(length(net[['interactions']][[g]][['input']]))
  total_int <- total_int+length(net[['interactions']][[g]][['input']])
}
total_int
