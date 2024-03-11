library(BoolNet)

net <- loadNetwork('original.txt')
attr <- getAttractors(net)
plotAttractors(attr)
