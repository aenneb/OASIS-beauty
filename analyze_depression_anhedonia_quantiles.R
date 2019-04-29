## assess relationship between beauty and depression/anhedonia in some more depth: What do the interactions in the linear model mean?

rm(list = ls(all = TRUE)) #clear workspace

## set working directory
setwd("/Volumes/GoogleDrive/My Drive/PhD/studies/OASIS/")

## load necessary packages
require(ggplot2)
require(AICcmodavg)

# read in data from .tx
dat =  read.table("means_per_subject.txt", fill = TRUE, header = TRUE, row.names = NULL, sep = "\t")

#### from the item-wise data, access the top and bottom quantiles
imageDat = read.table("means_per_image.txt", fill = TRUE, header = TRUE, row.names = NULL, sep = "\t")
quantiles = quantile(imageDat$beauty_mean, probs = seq(0, 1, 0.1), na.rm=TRUE)

# get items for all 10% quantiles
quant10 = imageDat$item[imageDat$beauty_mean>=5.751]
quant20 = imageDat$item[imageDat$beauty_mean<5.751 & imageDat$beauty_mean>=5.36]
quant30 = imageDat$item[imageDat$beauty_mean<5.36 & imageDat$beauty_mean>=5.033]
quant40 = imageDat$item[imageDat$beauty_mean<5.033 & imageDat$beauty_mean>=4.78]
quant50 = imageDat$item[imageDat$beauty_mean<4.78 & imageDat$beauty_mean>=4.455]
quant60 = imageDat$item[imageDat$beauty_mean<4.455 & imageDat$beauty_mean>=4.116]
quant70 = imageDat$item[imageDat$beauty_mean<4.116 & imageDat$beauty_mean>=3.76]
quant80 = imageDat$item[imageDat$beauty_mean<3.76 & imageDat$beauty_mean>=3.278]
quant90 = imageDat$item[imageDat$beauty_mean<3.278 & imageDat$beauty_mean>=2.819]
quant100 = imageDat$item[imageDat$beauty_mean<=2.819]



#### now, from the most detailed data, create two new data frames for high and low beauty images

load("depthData.rda")

quant10Data = aggregate(depthDat$beauty[is.element(depthDat$item, quant10)], list(depthDat$subjID[is.element(depthDat$item, quant10)]), mean, na.rm=TRUE)$x
quant20Data = aggregate(depthDat$beauty[is.element(depthDat$item, quant20)], list(depthDat$subjID[is.element(depthDat$item, quant20)]), mean, na.rm=TRUE)$x
quant30Data = aggregate(depthDat$beauty[is.element(depthDat$item, quant30)], list(depthDat$subjID[is.element(depthDat$item, quant30)]), mean, na.rm=TRUE)$x
quant40Data = aggregate(depthDat$beauty[is.element(depthDat$item, quant40)], list(depthDat$subjID[is.element(depthDat$item, quant40)]), mean, na.rm=TRUE)$x
quant50Data = aggregate(depthDat$beauty[is.element(depthDat$item, quant50)], list(depthDat$subjID[is.element(depthDat$item, quant50)]), mean, na.rm=TRUE)$x
quant60Data = aggregate(depthDat$beauty[is.element(depthDat$item, quant60)], list(depthDat$subjID[is.element(depthDat$item, quant60)]), mean, na.rm=TRUE)$x
quant70Data = aggregate(depthDat$beauty[is.element(depthDat$item, quant70)], list(depthDat$subjID[is.element(depthDat$item, quant70)]), mean, na.rm=TRUE)$x
quant80Data = aggregate(depthDat$beauty[is.element(depthDat$item, quant80)], list(depthDat$subjID[is.element(depthDat$item, quant80)]), mean, na.rm=TRUE)$x
quant90Data = aggregate(depthDat$beauty[is.element(depthDat$item, quant90)], list(depthDat$subjID[is.element(depthDat$item, quant90)]), mean, na.rm=TRUE)$x
quant100Data = aggregate(depthDat$beauty[is.element(depthDat$item, quant100)], list(depthDat$subjID[is.element(depthDat$item, quant100)]), mean, na.rm=TRUE)$x

quantile_means = c(mean(quant10Data), mean(quant20Data), mean(quant30Data), mean(quant40Data), mean(quant50Data), mean(quant60Data), mean(quant70Data), mean(quant80Data), mean(quant90Data), mean(quant100Data))
#### now, per gender, what is the association between depression/anhedonia/mood and the high vs. low average beauty images' beauty ratings?

mainData = as.data.frame(cbind(quant10Data, quant20Data, quant30Data, quant40Data, quant50Data, quant60Data, quant70Data, quant80Data, quant90Data, quant100Data, dat$PHQ, dat$mood_1, dat$TEPS_ant, dat$TEPS_con, dat$gender, dat$age))

names(mainData) = c("quant10Data","quant20Data","quant30Data","quant40Data","quant50Data","quant60Data","quant70Data","quant80Data","quant90Data","quant100Data","PHQ","mood","TEPS_ant", "TEPS_con", "gender", "age")
mainData$gender = as.factor(mainData$gender)

## correlate in a loop and store r and 95% CIs
r_TEPS_ant = c()
r_low_TEPS_ant = c()  
r_high_TEPS_ant = c() 

r_TEPS_con = c()
r_low_TEPS_con = c()  
r_high_TEPS_con = c()  

r_mood = c()
r_low_mood = c()  
r_high_mood = c() 

r_PHQ = c()
r_low_PHQ = c()  
r_high_PHQ = c() 

for(count in 1:10){
  
  r_TEPS_ant[count] = cor.test(mainData[,count], mainData$TEPS_ant)$estimate
  r_low_TEPS_ant[count] = cor.test(mainData[,count], mainData$TEPS_ant)$conf.int[1]
  r_high_TEPS_ant[count] = cor.test(mainData[,count], mainData$TEPS_ant)$conf.int[2]
  
  r_TEPS_con[count] = cor.test(mainData[,count], mainData$TEPS_con)$estimate
  r_low_TEPS_con[count] = cor.test(mainData[,count], mainData$TEPS_con)$conf.int[1]
  r_high_TEPS_con[count] = cor.test(mainData[,count], mainData$TEPS_con)$conf.int[2]
  
  r_mood[count] = cor.test(mainData[,count], mainData$mood)$estimate
  r_low_mood[count] = cor.test(mainData[,count], mainData$mood)$conf.int[1]
  r_high_mood[count] = cor.test(mainData[,count], mainData$mood)$conf.int[2]
  
  r_PHQ[count] = cor.test(mainData[,count], mainData$PHQ)$estimate
  r_low_PHQ[count] = cor.test(mainData[,count], mainData$PHQ)$conf.int[1]
  r_high_PHQ[count] = cor.test(mainData[,count], mainData$PHQ)$conf.int[2]
}

plot_TEPS_ant = as.data.frame(cbind(r_TEPS_ant, r_low_TEPS_ant, r_high_TEPS_ant))
ggplot(data=plot_TEPS_ant, aes(x = quantile_means, r_TEPS_ant)) + 
  geom_errorbar(aes(ymax = r_high_TEPS_ant, ymin=r_low_TEPS_ant))

plot_TEPS_con = as.data.frame(cbind(r_TEPS_con, r_low_TEPS_con, r_high_TEPS_con))
ggplot(data=plot_TEPS_con, aes(x =  quantile_means, r_TEPS_con)) + 
  geom_errorbar(aes(ymax = r_high_TEPS_con, ymin=r_low_TEPS_con))

plot_mood = as.data.frame(cbind(r_mood, r_low_mood, r_high_mood))
ggplot(data=plot_mood, aes(x = quantile_means, r_mood)) + 
  geom_errorbar(aes(ymax = r_high_mood, ymin=r_low_mood))

plot_PHQ = as.data.frame(cbind(r_PHQ, r_low_PHQ, r_high_PHQ))
ggplot(data=plot_PHQ, aes(x = quantile_means, r_PHQ)) + 
  geom_errorbar(aes(ymax = r_high_PHQ, ymin=r_low_PHQ))

# plot the correlations for the most extreme quantiles
ggplot(data=mainData, aes(x=TEPS_ant, quant10Data)) +
  geom_point() +
  geom_smooth(method=lm)

ggplot(data=mainData, aes(x=TEPS_ant, quant100Data)) +
  geom_point() +
  geom_smooth(method=lm)

ggplot(data=mainData, aes(x=TEPS_con, quant10Data)) +
  geom_point() +
  geom_smooth(method=lm)

ggplot(data=mainData, aes(x=TEPS_con, quant100Data)) +
  geom_point() +
  geom_smooth(method=lm)

ggplot(data=mainData, aes(x=PHQ, quant10Data)) +
  geom_point() +
  geom_smooth(method=lm)

ggplot(data=mainData, aes(x=PHQ, quant100Data)) +
  geom_point() +
  geom_smooth(method=lm)

ggplot(data=mainData, aes(x=mood, quant10Data)) +
  geom_point() +
  geom_smooth(method=lm)

ggplot(data=mainData, aes(x=mood, quant100Data)) +
  geom_point() +
  geom_smooth(method=lm)

