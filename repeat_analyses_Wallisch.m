% Do the same Spearman rank corr. analyses as Wallisch et al., 2017

clear
close all
cd '/Volumes/GoogleDrive/My Drive/PhD/studies/OASIS/'

load corrData_first100

% imageDat = readtable('means_per_image.csv');
% imageName=imageDat.Theme;
% theme = erase(imageName, '1');
% theme = erase(theme, '2');
% theme = erase(theme, '3');
% theme = erase(theme, '4');
% theme = erase(theme, '5');
% theme = erase(theme, '6');
% theme = erase(theme, '7');
% theme = erase(theme, '8');
% theme = erase(theme, '9');
% theme = erase(theme, '10');
% category = imageDat.Category;

%% get all correlations between thos participants rating the same images
rho = corr(corrData', 'type', 'Spearman', 'rows', 'pairwise'); %is absolutely equicalent to matching participants by hand - double-checked that
rho(rho==1) = NaN; % remove auto-correlations

%% plot and get summary stats
figure(1)
subplot(1,2,1)
histogram(rho)
nanmean(rho(:))
nanmedian(rho(:))
nanstd(rho(:))

rho_per_subj = nanmean(rho);

subplot(1,2,2)
histogram(rho_per_subj)
nanmean(rho_per_subj)
nanmedian(rho_per_subj)
nanstd(rho_per_subj)

%% some more stats
sum(rho_per_subj<0.5 & rho_per_subj>0.2)/length(rho_per_subj)
sum(rho_per_subj>0.5)/length(rho_per_subj)
sum(rho_per_subj<0.2)/length(rho_per_subj)

%% We also want to do this separately for the different image categories
data_objects = corrData;
data_objects(~strcmp(category_matrix,'Object')) = NaN;

data_animals = corrData;
data_animals(~strcmp(category_matrix,'Animal')) = NaN;

data_scenes = corrData;
data_scenes(~strcmp(category_matrix,'Scene')) = NaN;

data_people = corrData;
data_people(~strcmp(category_matrix,'Person')) = NaN;

%% repeat correlation analysis
rho_objects = corr(data_objects', 'type', 'Spearman', 'rows', 'pairwise');
rho_objects(rho_objects==1) = NaN; % remove auto-correlations

rho_animals = corr(data_animals', 'type', 'Spearman', 'rows', 'pairwise');
rho_animals(rho_animals==1) = NaN; % remove auto-correlations

rho_scenes = corr(data_scenes', 'type', 'Spearman', 'rows', 'pairwise');
rho_scenes(rho_scenes==1) = NaN; % remove auto-correlations

rho_people = corr(data_people', 'type', 'Spearman', 'rows', 'pairwise');
rho_people(rho_people==1) = NaN; % remove auto-correlations

%% Objects
figure(2)
subplot(1,2,1)
histogram(rho_objects)
M_obj = nanmean(rho_objects(:))
Md_obj = nanmedian(rho_objects(:))
Sd_obj = nanstd(rho_objects(:))

rho_per_subj_objects = nanmean(rho_objects);

subplot(1,2,2)
histogram(rho_per_subj_objects)
% nanmean(rho_per_subj_objects)
% nanmedian(rho_per_subj_objects)
% nanstd(rho_per_subj_objects)

%% animals
figure(3)
subplot(1,2,1)
histogram(rho_animals)
M_animals = nanmean(rho_animals(:))
Md_animals = nanmedian(rho_animals(:))
Sd_animals = nanstd(rho_animals(:))

rho_per_subj_animals = nanmean(rho_animals);

subplot(1,2,2)
histogram(rho_per_subj_animals)

%% scenes
figure(4)
subplot(1,2,1)
histogram(rho_scenes)
M_scenes = nanmean(rho_scenes(:))
Md_scenes = nanmedian(rho_scenes(:))
Sd_scenes = nanstd(rho_scenes(:))

rho_per_subj_scenes = nanmean(rho_scenes);

subplot(1,2,2)
histogram(rho_per_subj_scenes)

%% people
figure(5)
subplot(1,2,1)
histogram(rho_people)
M_people = nanmean(rho_people(:))
Md_people = nanmedian(rho_people(:))
Sd_people = nanstd(rho_people(:))

rho_per_subj_people = nanmean(rho_people);

subplot(1,2,2)
histogram(rho_per_subj_people)

%% Quick test: are the correlations different between the different categories?
[h,p] = ttest(rho_per_subj_objects, rho_per_subj_animals, 'alpha', 0.5/6)
[h,p] = ttest(rho_per_subj_objects, rho_per_subj_people, 'alpha', 0.5/6)
[h,p] = ttest(rho_per_subj_objects, rho_per_subj_scenes, 'alpha', 0.5/6)
[h,p] = ttest(rho_per_subj_people, rho_per_subj_animals, 'alpha', 0.5/6)
[h,p] = ttest(rho_per_subj_people, rho_per_subj_scenes, 'alpha', 0.5/6)
[h,p] = ttest(rho_per_subj_scenes, rho_per_subj_animals, 'alpha', 0.5/6)

%% correlations per THEME. Those are a lot. Exploratory.
theme_list = unique(theme);

for imageTheme = 1:length(theme_list)
   
    this_data = corrData;
    this_data(~strcmp(theme_matrix,theme_list{imageTheme})) = NaN;
    
    rho_tmp = corr(this_data', 'type', 'Spearman', 'rows', 'pairwise');
    mean_rho_per_theme(imageTheme) = nanmean(nanmean(rho_tmp));
    median_rho_per_theme(imageTheme) = nanmedian(nanmedian(rho_tmp));
    sd_rho_per_theme(imageTheme) = nanstd(nanstd(rho_tmp));
    
end


