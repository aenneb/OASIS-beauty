## based on the model reported in the ms, predict ratings and then re-do the quantile-wise correlation 

rm(list = ls(all = TRUE)) #clear workspace

## set working directory
setwd("/Volumes/GoogleDrive/My Drive/PhD/studies/OASIS/")

## load necessary packages
require(ggplot2)
# load data
load("depthData.rda")

# add mean beauty per image to that data
imageDat = read.table("means_per_image.txt", fill = TRUE, header = TRUE, row.names = NULL, sep = "\t")
depthDat$meanImageBeauty = NaN
for (ii in 1:nrow(imageDat)) {
  depthDat$meanImageBeauty[depthDat$item==ii] = imageDat$beauty_mean[imageDat$item==ii]
}

# add variable mean per subject - accounting for response bias
depthDat$meanSubjRating = NA
for (subj in 1:max(depthDat$subjID)){
  depthDat$meanSubjRating[depthDat$subjID==subj] = mean(depthDat$beauty[depthDat$subjID==subj], na.rm=T)
}

# create factors
# depthDat = depthDat[depthDat$gender!=3,]
depthDat$subjID = as.factor(depthDat$subjID)
depthDat$gender = as.factor(depthDat$gender)

# create lm
model_full = lm(beauty ~ meanImageBeauty*(PHQ + TEPS_ant + TEPS_con + mood_1) + meanSubjRating, data =depthDat)

#predict
predicted_beauty <- predict(model_full)

modelPredictions = as.data.frame(predicted_beauty)
modelPredictions$item = depthDat$item[!is.na(depthDat$PHQ) & !is.na(depthDat$TEPS_ant)]
modelPredictions$subjID = depthDat$subjID[!is.na(depthDat$PHQ) & !is.na(depthDat$TEPS_ant)]

# also write those predictions to a .txt file so we can read it in easily in MATLAB
write.table(file="lm_full_model_predictions.txt", modelPredictions)

# we also need the PHQ, mood, and TEPS scores per included participant
PHQ_included = aggregate(depthDat$PHQ[!is.na(depthDat$PHQ) & !is.na(depthDat$TEPS_ant)], list(depthDat$subjID[!is.na(depthDat$PHQ) & !is.na(depthDat$TEPS_ant)]), mean, na.rm=TRUE)$x
mood_included = aggregate(depthDat$mood_1[!is.na(depthDat$PHQ) & !is.na(depthDat$TEPS_ant)], list(depthDat$subjID[!is.na(depthDat$PHQ) & !is.na(depthDat$TEPS_ant)]), mean, na.rm=TRUE)$x
TEPS_ant_included = aggregate(depthDat$TEPS_ant[!is.na(depthDat$PHQ) & !is.na(depthDat$TEPS_ant)], list(depthDat$subjID[!is.na(depthDat$PHQ) & !is.na(depthDat$TEPS_ant)]), mean, na.rm=TRUE)$x
TEPS_con_included = aggregate(depthDat$TEPS_con[!is.na(depthDat$PHQ) & !is.na(depthDat$TEPS_ant)], list(depthDat$subjID[!is.na(depthDat$PHQ) & !is.na(depthDat$TEPS_ant)]), mean, na.rm=TRUE)$x

#### from the item-wise data, access the top and bottom quantiles
imageDat = read.table("means_per_image.txt", fill = TRUE, header = TRUE, row.names = NULL, sep = "\t")
quantiles = quantile(imageDat$beauty_mean, probs = seq(0, 1, 0.1), na.rm=TRUE)
imageDat$item = as.character(imageDat$item)

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

quant10Data = aggregate(modelPredictions$predicted_beauty[is.element(modelPredictions$item, quant10)], list(modelPredictions$subjID[is.element(modelPredictions$item, quant10)]), mean, na.rm=TRUE)$x
quant20Data = aggregate(modelPredictions$predicted_beauty[is.element(modelPredictions$item, quant20)], list(modelPredictions$subjID[is.element(modelPredictions$item, quant20)]), mean, na.rm=TRUE)$x
quant30Data = aggregate(modelPredictions$predicted_beauty[is.element(modelPredictions$item, quant30)], list(modelPredictions$subjID[is.element(modelPredictions$item, quant30)]), mean, na.rm=TRUE)$x
quant40Data = aggregate(modelPredictions$predicted_beauty[is.element(modelPredictions$item, quant40)], list(modelPredictions$subjID[is.element(modelPredictions$item, quant40)]), mean, na.rm=TRUE)$x
quant50Data = aggregate(modelPredictions$predicted_beauty[is.element(modelPredictions$item, quant50)], list(modelPredictions$subjID[is.element(modelPredictions$item, quant50)]), mean, na.rm=TRUE)$x
quant60Data = aggregate(modelPredictions$predicted_beauty[is.element(modelPredictions$item, quant60)], list(modelPredictions$subjID[is.element(modelPredictions$item, quant60)]), mean, na.rm=TRUE)$x
quant70Data = aggregate(modelPredictions$predicted_beauty[is.element(modelPredictions$item, quant70)], list(modelPredictions$subjID[is.element(modelPredictions$item, quant70)]), mean, na.rm=TRUE)$x
quant80Data = aggregate(modelPredictions$predicted_beauty[is.element(modelPredictions$item, quant80)], list(modelPredictions$subjID[is.element(modelPredictions$item, quant80)]), mean, na.rm=TRUE)$x
quant90Data = aggregate(modelPredictions$predicted_beauty[is.element(modelPredictions$item, quant90)], list(modelPredictions$subjID[is.element(modelPredictions$item, quant90)]), mean, na.rm=TRUE)$x
quant100Data = aggregate(modelPredictions$predicted_beauty[is.element(modelPredictions$item, quant100)], list(modelPredictions$subjID[is.element(modelPredictions$item, quant100)]), mean, na.rm=TRUE)$x

quantile_means = c(mean(quant10Data), mean(quant20Data), mean(quant30Data), mean(quant40Data), mean(quant50Data), mean(quant60Data), mean(quant70Data), mean(quant80Data), mean(quant90Data), mean(quant100Data))

#### now, what is the association between depression/anhedonia/mood and the high vs. low average beauty images' beauty ratings?

mainData = as.data.frame(cbind(quant10Data, quant20Data, quant30Data, quant40Data, quant50Data, quant60Data, quant70Data, quant80Data, quant90Data, quant100Data, PHQ_included, mood_included, TEPS_ant_included, TEPS_con_included))

names(mainData) = c("quant10Data","quant20Data","quant30Data","quant40Data","quant50Data","quant60Data","quant70Data","quant80Data","quant90Data","quant100Data","PHQ","mood","TEPS_ant", "TEPS_con")

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

