setwd("C:/Users/yifan/Desktop/winter2021/BIOL432/432FinalProject")

data_CDS <- read.table('pim.txt', header = F, sep = "")
rnames <- data_CDS[,1]
data_CDS2 <- data.matrix(data_CDS[, 2:ncol(data_CDS)])
rownames(data_CDS2) <- rnames
colnames(data_CDS2) <- rnames

#Set the colour scheme
require(RColorBrewer)
my_palette = colorRampPalette(c("white", "blue"))(n = 11)

#Set other variables
require(gplots)

#Prepare heatmaps
my_palette = colorRampPalette(c("white","blue"))(n = 10)
heatmap.2(data_CDS2, trace = c("none"), density.info = c("none"), 
          breaks = c(90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100), col = my_palette, 
          lmat = matrix(c(4,2,3,1), nrow = 2, ncol = 2), key = T, labRow = rnames, labCol = rnames)
