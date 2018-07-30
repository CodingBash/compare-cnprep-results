# 
# View the relationship between the segment count in NA12878 reference and hN31 reference
#

setwd("~/Git-Projects/Git-Research-Projects/compare-cnprep-results/") # Set working directory to where the scripts are located at
source("compareCNprepResultsLibrary.R")

selected_model_specs <- c(1,16)
models <- all_model_specs[selected_model_specs,]

print(all_model_specs)
loaded_samples <- load_samples(classes = c("T"), sampleList = "./resources/sampleList.csv")


NA12878_X <- list()
hN31_Y <- list()
list.index <- 1
for(sample in loaded_samples){
  print(sample)
  print(paste0("segClusteringResults/", models[1, ]$dir, "/", sample))
  try({
  segtableX <- retrieveSegtable(sample , dir = paste0("segClusteringResults/", models[1, ]$dir, "/"))
  segtableY <- retrieveSegtable(sample , dir = paste0("segClusteringResults/", models[2, ]$dir, "/"))
  NA12878_X[list.index] <- nrow(segtableX)
  hN31_Y[list.index] <- nrow(segtableY)
  list.index <- list.index + 1
  }, silent = TRUE)
}
NA12878_X <- unlist(NA12878_X)
hN31_Y <- unlist(hN31_Y)
  
plot(NA12878_X, hN31_Y)
abline(lm(I(hN31_Y) ~ 0 + NA12878_X), col = "red")
abline(1,1, col = "blue")
dev.off()
