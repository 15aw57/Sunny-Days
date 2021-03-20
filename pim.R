data_CDS <- read.table('./input/pim.txt', header = F, sep = "")
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
my_palette = colorRampPalette(c("white", "dark blue"))(n = 5)
heatmap.2(data_CDS2, trace = c("none"), density.info = c("none"), 
          breaks = c(90, 92, 94, 96, 98, 100), col = my_palette, 
          lmat = matrix(c(4,2,3,1), nrow = 2, ncol = 2), key = T, labRow = rnames, labCol = rnames)
