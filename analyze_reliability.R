## randomly split data in half 1,000 times and calculate correlation between means; take the average correlation as measure for reliability.

rm(list = ls(all = TRUE)) #clear workspace

## set working directory
setwd("/Users/aennebrielmann/Google Drive/PhD/studies/OASIS/")

## load necessary packages

# load data
load("depthData.rda")
depthDat = depthDat[!is.na(depthDat$beauty),]

nRatings = length(depthDat$beauty)
r= c()

# loop
for (counter in 1:1000) {
  # shuffle data
  dat = depthDat[sample(1:nRatings, nRatings),]
  #split
  firstHalf = dat[1:(nRatings/2),]
  secondHalf = dat[(nRatings/2+1):nRatings,]
  #calculate new means
  means1 = aggregate(firstHalf$beauty, list(firstHalf$item), mean, na.rm=TRUE)
  means2 = aggregate(secondHalf$beauty, list(secondHalf$item), mean, na.rm=TRUE)
  # correlate
  r[counter] = cor.test(means1$x, means2$x)$estimate
  
}

# summary stats
mean(as.numeric(r))
min(as.numeric(r))
max(as.numeric(r))
