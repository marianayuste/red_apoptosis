library(BoolNet)
library("rlist")
setwd('/Users/mariana/Dropbox/redes_alfredo/red_apoptosis')

### GUARDAR LA RED ORIGINAL----------------------
net <- loadNetwork('original.txt')



### CORRER ATRACTORES ---------------------------
start = Sys.time()
attr <- getAttractors(net,
                      type="asynchronous",
                      method="random",
                      startStates=10000000) #10,000,000 son 1/5 aprox del total de edos iniciales posibles
end <- Sys.time()
print(paste('duracion: ',start,'-',end,'=',end-start))

print(attr,activeOnly = TRUE)

