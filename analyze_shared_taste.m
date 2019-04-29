% Do the same as Vessel et al., 2018, as described by Germine et al.

clear
close all
cd '/Volumes/GoogleDrive/My Drive/PhD/studies/OASIS/'

%% get data from both the main experiment and reapeated measures
load corrData
rmDat = readtable('repeated_measures_data_OASIS.csv');

%% get all correlations between participants,
inter_subj_correlations = zeros(size(corrData,1), size(corrData,1));

for subj = 1:size(corrData, 1)
    
    for comp_subj = 1:size(corrData,1)
        
        if subj~=comp_subj
            inter_subj_correlations(subj, comp_subj) = ...
                corr(corrData(subj,:)', corrData(comp_subj,:)',...
                'rows', 'pairwise');
        else
            inter_subj_correlations(subj, comp_subj) = NaN;
        end
        
    end
    
end
%%
mean_inter = nanmean(inter_subj_correlations(:).^2);
%% get the intra-subject correlations
intra_subj_correlations = zeros(max(rmDat.x___subjID),1);
inter_subj_correlations_rm = zeros(max(rmDat.x___subjID),max(rmDat.x___subjID));
intra_subj_SD = zeros(max(rmDat.x___subjID), length(unique(rmDat.item)));

for subj = 1:max(rmDat.x___subjID)
    
    intra_subj_correlations(subj) = ...
        corr(rmDat.beauty(rmDat.x___subjID==subj & rmDat.repetition==1),...
        rmDat.beauty(rmDat.x___subjID==subj & rmDat.repetition==2),...
        'rows', 'pairwise');
    intra_subj_SD(subj,:) = ...
        std([rmDat.beauty(rmDat.x___subjID==subj & rmDat.repetition==1)...
        rmDat.beauty(rmDat.x___subjID==subj & rmDat.repetition==2)],0,2);
    
    for comp_subj = 1:max(rmDat.x___subjID)
        
        if subj~=comp_subj
            inter_subj_correlations_rm(subj, comp_subj) = ...
                corr(rmDat.beauty(rmDat.x___subjID==subj), rmDat.beauty(rmDat.x___subjID==comp_subj),...
                'rows', 'pairwise');
        else
            inter_subj_correlations_rm(subj, comp_subj) = NaN;
        end
        
    end
end

mean_intra = nanmean(intra_subj_correlations.^2);
mean_inter_rm = nanmean(inter_subj_correlations_rm(:).^2);
%%
disp([num2str(round(mean_intra-mean_inter,2)*100) '% of variance is repeatable but not due to overlap between individuals'])
disp([num2str(round(mean_inter/mean_intra,2)*100) '% of variance is due to common preferences'])

%% within repeated measures alone
disp([num2str(round(mean_intra-mean_inter_rm,2)*100) '% of variance is repeatable but not due to overlap between individuals'])
disp([num2str(round(mean_inter_rm/mean_intra,2)*100) '% of variance is due to common preferences'])


