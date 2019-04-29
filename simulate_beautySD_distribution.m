% model the SD distribution in our data

clear
close all
cd '/Volumes/GoogleDrive/My Drive/PhD/studies/OASIS/'

load OASISdata

%% first we need mean beauty per image
for im = 1:length(unique(item))
    
   avgImageBeauty(im) = nanmean(beauty(item==im));
   sdImageBeauty(im) = nanstd(beauty(item==im));
    % then we simulate ratings per image
    sim_rating(im,:) = normrnd(avgImageBeauty(im), 1.7, 1, round(757/4)); %about the # of participants
   
end

%% now we clip the simulated ratings
sim_rating = round(sim_rating);
sim_rating(sim_rating<1) = 1;
sim_rating(sim_rating>7) = 7;
% and from there we can calculate the sd
sim_sd = std(sim_rating, 0, 2);

%% plot it
figure(1); clf; box off; hold on;
plot(avgImageBeauty, sim_sd, '.')
plot(avgImageBeauty, sdImageBeauty, 'o')

