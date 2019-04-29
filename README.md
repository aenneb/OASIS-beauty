# OASIS-beauty
Data and analyses files for Brielmann &amp; Pelli (submitted, PLOS ONE) Beauty and pleasure: Intensity of beauty in relation to valence, arousal, depression, and anhedonia.

For convenience, data is provided in multiple formats (.csv, .mat, and .rda) and sorted in a way that is best suited for the corresponding software. Analyses were performed in MATLAB 2018a and R 3.4.2 "Short Summer".

## Contents
### Data files
1) depthDat.csv - complete raw data for the rmain study cleaned and formatted in long format.
2) repeated_measures_data_OASIS.csv - complete raw data for the repeated measures follow-up study cleaned and formatted in long format.
3) means_per_image.csv - mean, SD, and N per image from the main study (also includes mean arousal and valence ratings from Kurdi et al. (2017) as well as beauty means per gender)
4) OASISdata.mat - for convenience: MATLAB matrix containing the main study data.
5) depthData.rda - for convenience: depth data in R format.
6) corrData.mat - for convenience: MATLAB matrix containing the re-sorted beauty ratings in a participant x image format.
7) means_per_subject.txt - for convenience: means per participant in .txt format for easier import
8) means_per_image.txt - for convenience: means per image in .txt format for easier import

### Analysis scripts
1) analyze_means_per_image.R - Perform all analyses on the distribution of beauty means, SDs per image and their relation to valence and arousal ratings
2) simulate_beautySD_distribution.m - Simulate the proposed process from which the distribution of beauty SDs per image stem.
3) analyze_reliability.R - Perform split-half reliability analyses as in Kurdi et al. (2017)
4) repeat_analyses_Wallisch.m - Perfom inter-subject correlations as in Wallisch & Whrithner, 2017. 
5) analyze_shared_taste.m - Perform the same analyses as Vessel et al., 2018, as described by Germine et al.
6) analyze_differences_means_demographics.R - Perform correlations between mean beauty ratings given by sub-groups of participants as defined by different demographic variables.
7) analyze_linearModel.R - Create and assess different linear models with and without interactions to account for individual beauty ratings.
8) analyze_depression_anhedonia_quantiles.R - Perform relation between beauty and mood, anhedonia, depression in depth per beauty quantile
9) predict_corr_per_quantile.R - Based on the model established in 8), predict ratings and then re-do the quantile-wise correlations 
