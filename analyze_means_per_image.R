## assess the picture space: analyze mean beauty ratings, their distribution, their SDs, and their relation to valence and arousal ratings as provided by Kurdi et al. (2017)

rm(list = ls(all = TRUE)) #clear workspace

## set working directory
setwd("/Volumes/GoogleDrive/My Drive/PhD/studies/OASIS/")

## load necessary packages
require(ggplot2)
require(e1071)
require(AICcmodavg)
require(sn)

# read in data from .tx
dat =  read.table("means_per_image_first100Trials.txt", fill = TRUE, header = TRUE, row.names = NULL, sep = "\t")

# minimal stats
min(dat$beauty_mean)
max(dat$beauty_mean)
# fit to a normal distribution, then to a skewed normal distribution
ks.test(dat$beauty_mean, "pnorm")
shapiro.test(dat$beauty_mean)
skewness(dat$beauty_mean)

skewNormFit = selm(dat$beauty_mean ~ 1, family = "SN")
plot(skewNormFit, which=2:3)
summary(skewNormFit, param.type="DP")

### to also repeat these analyses for the different categories, uncomment the line below and insert the category to be looked at
# dat = dat[dat$Category=="Object",]

ggplot(dat, aes(beauty_mean)) + geom_histogram(binwidth = 0.25)
ggplot(dat, aes(beauty_SD)) + geom_histogram(binwidth = 0.075)

# assess relationship between means and SDs
linModel = lm(data=dat, beauty_SD ~ beauty_mean)
summary(linModel)

quadraticModel = lm(data=dat, beauty_SD ~ poly(beauty_mean,2))
summary(quadraticModel)

AICc(linModel)
AICc(quadraticModel)

ggplot(dat, aes(beauty_mean, beauty_SD)) +
  geom_point() +
  geom_smooth()


# same assessments for relation between beauty and arousal/valence

linModel = lm(data=dat, beauty_mean ~ Valence_mean)
summary(linModel)
cor.test(dat$beauty_mean, dat$Valence_mean)

quadraticModel = lm(data=dat, beauty_mean ~ poly(Valence_mean,2))
summary(quadraticModel)
ggplot(dat, aes(Valence_mean, beauty_mean)) +
  geom_point() +
  geom_smooth(method="lm")

AICc(linModel)
AICc(quadraticModel)


linModel = lm(data=dat, beauty_mean ~ Arousal_mean)
summary(linModel)
cor.test(dat$beauty_mean, dat$Arousal_mean)

quadraticModel = lm(data=dat, beauty_mean ~ poly(Arousal_mean,2))
summary(quadraticModel)
ggplot(dat, aes(Arousal_mean, beauty_mean)) +
  geom_point() +
  geom_smooth(method="lm")

AICc(linModel)
AICc(quadraticModel)


# plot with different symbold for the different image categories
ggplot(dat, aes(Valence_mean, beauty_mean, shape=Category, color=Category)) +
  geom_point() +
  geom_smooth()

ggplot(dat, aes(Arousal_mean, beauty_mean, shape=Category, color=Category)) +
  geom_point() +
  geom_smooth()
