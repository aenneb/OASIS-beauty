## get the mean ratings for men and women per image separately, correlate
# also assess differences in ratings between other demographic groups

rm(list = ls(all = TRUE)) #clear workspace

## set working directory
setwd("/Volumes/GoogleDrive/My Drive/PhD/studies/OASIS/")

## load necessary packages
require(ggplot2)

# load data
load("depthData.rda")
dat = depthDat[!is.na(depthDat$beauty),]

womenMeans = aggregate(dat$beauty[dat$gender==1], list(dat$item[dat$gender==1]), mean)
menMeans = aggregate(dat$beauty[dat$gender==2], list(dat$item[dat$gender==2]), mean)

cor.test(womenMeans$x, menMeans$x)
plotDat = as.data.frame(cbind(womenMeans$x, menMeans$x))
ggplot(plotDat, aes(V1, V2)) +
  geom_point() +
  geom_smooth(method="lm")

# divide into young and old age group
youngMeans = aggregate(dat$beauty[dat$age<=median(dat$age)], list(dat$item[dat$age<=median(dat$age)]), mean)
oldMeans = aggregate(dat$beauty[dat$age>median(dat$age)], list(dat$item[dat$age>median(dat$age)]), mean)

diffMeans_age = oldMeans$x-youngMeans$x
mean(diffMeans_age, na.rm=TRUE)
t.test(diffMeans_age)
sd(diffMeans_age, na.rm=TRUE)

youngSDs = aggregate(dat$beauty[dat$age<=median(dat$age)], list(dat$item[dat$age<=median(dat$age)]), sd)
oldSDs = aggregate(dat$beauty[dat$age>median(dat$age)], list(dat$item[dat$age>median(dat$age)]), sd)

diffSDs_age = oldSDs$x - youngSDs$x
mean(diffSDs_age, na.rm=TRUE)
t.test(diffSDs_age)
sd(diffSDs_age, na.rm=TRUE)

cor.test(youngMeans$x, oldMeans$x)
plotDat = as.data.frame(cbind(youngMeans$x, oldMeans$x))
ggplot(plotDat, aes(V1, V2)) +
  geom_point() +
  geom_smooth(method="lm")


# divide into high and low income group
lowIncomeMeans = aggregate(dat$beauty[dat$income<=median(dat$income)], list(dat$item[dat$income<=median(dat$income)]), mean)
highIncomeMeans = aggregate(dat$beauty[dat$income>median(dat$income)], list(dat$item[dat$income>median(dat$income)]), mean)

diffMeans_income = lowIncomeMeans$x-highIncomeMeans$x
mean(diffMeans_income, na.rm=TRUE)
t.test(diffMeans_income)
sd(diffMeans_income, na.rm=TRUE)

cor.test(lowIncomeMeans$x, highIncomeMeans$x)
plotDat = as.data.frame(cbind(lowIncomeMeans$x, highIncomeMeans$x))
ggplot(plotDat, aes(V1, V2)) +
  geom_point() +
  geom_smooth(method="lm")

lowIncomeSDs = aggregate(dat$beauty[dat$income<=median(dat$income)], list(dat$item[dat$income<=median(dat$income)]), sd)
highIncomeSDs = aggregate(dat$beauty[dat$income>median(dat$income)], list(dat$item[dat$income>median(dat$income)]), sd)

diffSDs_income = lowIncomeSDs$x-highIncomeSDs$x
mean(diffSDs_income, na.rm=TRUE)
t.test(diffSDs_income)
sd(diffSDs_income, na.rm=TRUE)

# assess political ideology; remember that 8 = prefer not to say
liberalMeans = aggregate(dat$beauty[dat$politic<4], list(dat$item[dat$politic<4]), mean)
conservativeMeans = aggregate(dat$beauty[dat$politic>4 & dat$politic<8], list(dat$item[dat$politic>4 & dat$politic<8]), mean)

diffMeans_politic = liberalMeans$x-conservativeMeans$x
mean(diffMeans_politic, na.rm=TRUE)
t.test(diffMeans_politic)
sd(diffMeans_politic, na.rm=TRUE)

cor.test(liberalMeans$x, conservativeMeans$x)
plotDat = as.data.frame(cbind(liberalMeans$x, conservativeMeans$x))
ggplot(plotDat, aes(V1, V2)) +
  geom_point() +
  geom_smooth(method="lm")

liberalSDs = aggregate(dat$beauty[dat$politic<4], list(dat$item[dat$politic<4]), sd)
conservativeSDs = aggregate(dat$beauty[dat$politic>4 & dat$politic<8], list(dat$item[dat$politic>4 & dat$politic<8]), sd)

diffSDs_politic = liberalSDs$x-conservativeSDs$x
mean(diffSDs_politic, na.rm=TRUE)
t.test(diffSDs_politic)
sd(diffSDs_politic, na.rm=TRUE)

