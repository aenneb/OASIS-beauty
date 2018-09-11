# OASIS-beauty
Data and analyses files for Brielmann &amp; Pelli (in prep.) Beauty and pleasure: Intensity of beauty in relation to valence, arousal, depression, and anhedonia

## Contents
### Data files
1) depthDat.csv - complete raw data for the rmain study cleaned and formatted in long format.
2) repeated_measures_data_OASIS.csv - complete raw data for the repeated measures follow-up study cleaned and formatted in long format.
3) means_per_image.csv - mean, SD, and N per image from the main study (also includes mean arousal and valence ratings from Kurdi et al. (2017) as well as beauty means per gender)
4) OASISdata.mat - for convenience: MATLAB matrix containing the main study data.
5) depthData.rda - for convenience: depth data in R format.

### Analysis scripts
1) analyze_means_per_image.r - Perform all analyses on the distribution of beauty means, SDs per image and their relation to valence and arousal ratings
2) simulate_beautySD_distribution.m - Simulate the proposed process from which the distribution of beauty SDs per image stem.
3) analyze_reliability - Perform split-half reliability analyses as in Kurdi et al. (2017)
4) repeat_analyses_Wallisch - Perfom inter-subject correlations as in Wallisch & Whrithner, 2017. 
