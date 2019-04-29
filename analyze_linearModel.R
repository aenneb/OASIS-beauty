## set up simple linear models to "predict" individual beauty ratings

rm(list = ls(all = TRUE)) #clear workspace

## set working directory
setwd("/Volumes/GoogleDrive/My Drive/PhD/studies/OASIS/")

## load necessary packages
require(jtools)
# load data
load("first100Dat.rda")

# add mean beauty per image to that data
imageDat = read.table("means_per_image_first100Trials.txt", fill = TRUE, header = TRUE, row.names = NULL, sep = "\t")
depthDat$meanImageBeauty = NaN
for (ii in 1:nrow(imageDat)) {
  depthDat$meanImageBeauty[depthDat$item==ii] = imageDat$beauty_mean[imageDat$item==ii]
}

# add variable mean per subject - accounting for response bias
depthDat$meanSubjRating = NA
for (subj in 1:max(depthDat$subjID)){
  depthDat$meanSubjRating[depthDat$subjID==subj] = mean(depthDat$beauty[depthDat$subjID==subj], na.rm=T)
}

#alternative: z-score the ratings per participant
depthDat$beauty_z = NA
for (subj in 1:max(depthDat$subjID)){
  depthDat$beauty_z[depthDat$subjID==subj] = scale(depthDat$beauty[depthDat$subjID==subj], center=T, scale=T)
}

# create factors
# depthDat = depthDat[depthDat$gender!=3,]
depthDat$subjID = as.factor(depthDat$subjID)
depthDat$gender = as.factor(depthDat$gender)

##--- simple linear models ---##

# for all images
simple_model = lm(beauty ~ meanImageBeauty, data = depthDat[!is.na(depthDat$TEPS_ant) & !is.na(depthDat$PHQ),])
summary(simple_model)

bias_model = lm(beauty ~ meanImageBeauty + meanSubjRating, data = depthDat[!is.na(depthDat$TEPS_ant) & !is.na(depthDat$PHQ),])
summary(bias_model)

bias_only_model =  lm(beauty ~ meanSubjRating, data = depthDat[!is.na(depthDat$TEPS_ant) & !is.na(depthDat$PHQ),])
summary(bias_only_model)

##--- with full interaction ---##
model_full = lm(beauty ~ meanImageBeauty*(PHQ + TEPS_ant + TEPS_con + mood_1) + meanSubjRating, data =depthDat)
summary(model_full)

anova(simple_model, model_full)
anova(bias_model, model_full)

# visualize interaction
interact_plot(model_full, pred = "meanImageBeauty", modx = "mood_1", interval = TRUE,
              int.width = 0.95)
interact_plot(model_full, pred = "meanImageBeauty", modx = "PHQ", interval = TRUE,
              int.width = 0.95)
interact_plot(model_full, pred = "meanImageBeauty", modx = "TEPS_ant", interval = TRUE,
              int.width = 0.95)
interact_plot(model_full, pred = "meanImageBeauty", modx = "TEPS_con", interval = TRUE,
              int.width = 0.95)


##--- linear models with z-scored data---##

# for all images
simple_model = lm(beauty_z ~ meanImageBeauty, data = depthDat[!is.na(depthDat$TEPS_ant) & !is.na(depthDat$PHQ),])
summary(simple_model)


# with full interaction
model_full = lm(beauty_z ~ meanImageBeauty*(PHQ + TEPS_ant + TEPS_con + mood_1), data =depthDat)
summary(model_full)

anova(simple_model, model_full)

# visualize interaction
interact_plot(model_full, pred = "meanImageBeauty", modx = "mood_1", interval = TRUE,
              int.width = 0.95)
interact_plot(model_full, pred = "meanImageBeauty", modx = "PHQ", interval = TRUE,
              int.width = 0.95)
interact_plot(model_full, pred = "meanImageBeauty", modx = "TEPS_ant", interval = TRUE,
              int.width = 0.95)
interact_plot(model_full, pred = "meanImageBeauty", modx = "TEPS_con", interval = TRUE,
              int.width = 0.95)
