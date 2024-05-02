library(BoolNet)
library("rlist")
setwd('/Users/tbmovies/Downloads/red_apoptosis-main')

### GUARDAR LA RED ORIGINAL----------------------
net <- loadNetwork('original.txt')


setwd('/Users/tbmovies/Downloads/red_apoptosis-main/analisis_3')

### CORRER ATRACTORES ---------------------------
start = Sys.time()
ini_total = 1000000
# en compu berni:
#1000 tarda 0.4 segs
#10,000 tarda 3 segs
#100,000 tarda 34 segs
#1,000,000 tarda 
attr <- getAttractors(net,
                      type="asynchronous",
                      method="random",
                      startStates=ini_total) #10,000,000 son 1/5 aprox del total de edos iniciales posibles
end <- Sys.time()
print(paste('duracion: ',start,'-',end,'=',end-start))

#guardar los attrs obtenidos
nombre <- paste('asyn_attrs_',toString(ini_total),'.txt', sep='')
l = c()
for (a in attr[2]){for (b in a){l <- c(l,b[1])}} #guardar solo los atractores
write.table(l,nombre,row.names = F,col.names = F)

#print(attr,activeOnly = TRUE)

