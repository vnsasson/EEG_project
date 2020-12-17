
function [Mat] = spectral_analysis_func(ALLEEG,filename,filepath,Mat,k)

fs = 500;

EEG = pop_loadset('filename',filename,'filepath',filepath);

 %% calculate PSD using Welch
 
 mat_dim = size(EEG.data); % (number of electrodes,data length)
 Num_elec = mat_dim(1); % number of electrodes
 
 Psd_length = length(pwelch(EEG.data(1,:),fs)); % length of PSD
 
 PSD_Mat = zeros(Num_elec,Psd_length); % produce empty matrix
 
 
%figure;
 
 for i = 1:Num_elec
       
    [Psd,theta] = pwelch(EEG.data(i,:),fs);
    f = (theta*fs)/(2*pi);
    PSD_Mat(i,:) = Psd';
    PSD_Mat(i,:) = log10(PSD_Mat(i,:));
 
%     plot(f,PSD_Mat(i,:));
%     xlim([0 45]);
%     title('Power Spectral Density');
%     xlabel('Frequency [Hz]');
%     ylabel('Amplitude ( log_{10} )');
%     hold on
  
 end
 
 %hold off

 
 %% calculate wave values for each patient: 
 % 1-delta (0.5-3.5 Hz), 2-theta (3.5-7.4 Hz), 3-alpha (7.4-12.4 Hz),
 % 4-beta (12.4-30 Hz), 5-gamma (30-45 Hz)
 
 freq_regions = 5;
  
 Wave_Mat = zeros(Num_elec,freq_regions); 

 % calculate PSD integral for each wave range for each electrode
 for i = 1:Num_elec 
     
     Wave_Mat(i,1) = sum(PSD_Mat(i,find(f<3.5))) - sum(PSD_Mat(i,find(f<0.5)));
     Wave_Mat(i,2) = sum(PSD_Mat(i,find(f<7.4))) - sum(PSD_Mat(i,find(f<3.6)));
     Wave_Mat(i,3) = sum(PSD_Mat(i,find(f<12.4))) - sum(PSD_Mat(i,find(f<7.4)));
     Wave_Mat(i,4) = sum(PSD_Mat(i,find(f<30))) - sum(PSD_Mat(i,find(f<12.4)));
     Wave_Mat(i,5) = sum(PSD_Mat(i,find(f<45))) - sum(PSD_Mat(i,find(f<30)));

end
 

%% transform to number labeling for each area

[frontal,central,post_occ,left,right,broca,wernick] = fill_regions(Num_elec);

%% calculate the values for this subject

% produce the matrix to export
brain_areas = 7;
export_T = zeros(freq_regions,brain_areas*2);

% delta

delta_frontal = mean(Wave_Mat(frontal,1));
export_T(1,7) = delta_frontal;
delta_central = mean(Wave_Mat(central,1));
export_T(1,6) = delta_central;
delta_left = mean(Wave_Mat(left,1));
export_T(1,5) = delta_left;
delta_right = mean(Wave_Mat(right,1));
export_T(1,4) = delta_right;
delta_post_occ = mean(Wave_Mat(post_occ,1));
export_T(1,3) = delta_post_occ;
delta_broca = mean(Wave_Mat(broca,1));
export_T(1,2) = delta_broca;
delta_wernick = mean(Wave_Mat(wernick,1));
export_T(1,1) = delta_wernick;

% theta

theta_frontal = mean(Wave_Mat(frontal,2));
export_T(2,7) = theta_frontal;
theta_central = mean(Wave_Mat(central,2));
export_T(2,6) = theta_central;
theta_left = mean(Wave_Mat(left,2));
export_T(2,5) = theta_left;
theta_right = mean(Wave_Mat(right,2));
export_T(2,4) = theta_right;
theta_post_occ = mean(Wave_Mat(post_occ,2));
export_T(2,3) = theta_post_occ;
theta_broca = mean(Wave_Mat(broca,2));
export_T(2,2) = theta_broca;
theta_wernick = mean(Wave_Mat(wernick,2));
export_T(2,1) = theta_wernick;

% alpha

alpha_frontal = mean(Wave_Mat(frontal,3));
export_T(3,7) = alpha_frontal;
alpha_central = mean(Wave_Mat(central,3));
export_T(3,6) = alpha_central;
alpha_left = mean(Wave_Mat(left,3));
export_T(3,5) = alpha_left;
alpha_right = mean(Wave_Mat(right,3));
export_T(3,4) = alpha_right;
alpha_post_occ = mean(Wave_Mat(post_occ,3));
export_T(3,3) = alpha_post_occ;
alpha_broca = mean(Wave_Mat(broca,3));
export_T(3,2) = alpha_broca;
alpha_wernick = mean(Wave_Mat(wernick,3));
export_T(3,1) = alpha_wernick;

% beta

beta_frontal = mean(Wave_Mat(frontal,4));
export_T(4,7) = beta_frontal;
beta_central = mean(Wave_Mat(central,4));
export_T(4,6) = beta_central;
beta_left = mean(Wave_Mat(left,4));
export_T(4,5) = beta_left;
beta_right = mean(Wave_Mat(right,4));
export_T(4,4) = beta_right;
beta_post_occ = mean(Wave_Mat(post_occ,4));
export_T(4,3) = beta_post_occ;
beta_broca = mean(Wave_Mat(broca,4));
export_T(4,2) = beta_broca;
beta_wernick = mean(Wave_Mat(wernick,4));
export_T(4,1) = beta_wernick;

% gamma

gamma_frontal = mean(Wave_Mat(frontal,5));
export_T(5,7) = gamma_frontal;
gamma_central = mean(Wave_Mat(central,5));
export_T(5,6) = gamma_central;
gamma_left = mean(Wave_Mat(left,5));
export_T(5,5) = gamma_left;
gamma_right = mean(Wave_Mat(right,4));
export_T(5,4) = gamma_right;
gamma_post_occ = mean(Wave_Mat(post_occ,5));
export_T(5,3) = gamma_post_occ;
gamma_broca = mean(Wave_Mat(broca,5));
export_T(5,2) = gamma_broca;
gamma_wernick = mean(Wave_Mat(wernick,5));
export_T(5,1) = gamma_wernick;

%%
% i = k*5 + 2;
% Mat(i:i+4,:) = export_T;
if k==1
    Mat(1:5,:) = export_T;
elseif k > 1
    i = 7*(k-1);
    Mat(i:i+4,:) = export_T;
end


%%  create table to export

%writematrix(export_T,'C:\Users\sasso\Desktop\Studies\Project\B- Brain activity during reading\eeglab2020_0\excel_mat\tryall.xlsx');


%%



% for 63
% frontal = [1,32,33,34,35,62,63,4,37,3,36,2,61,30,60,31];
% central = [8,41,24,57,25];
% post_occ = [15,46,14,45,13,53,19,52,20,47,48,49,50,51,16,17,18];
% left = [1,33,34,3,4,36,37,5,6,7,38,39,8,9,41,42,10,11,12,43,44,14,15,45,46,16,47,48];
% right = [18,19,20,21,22,23,25,26,27,28,29,30,31,32,50,51,52,53,54,55,56,57,58,59,60,61,62,63];
% broca = [3,4,6,8,37,39];
% wernick = [9,11,14,15,43,46];



% % for 16
% frontal = [1,2,3,15,16];
% central = [5];
% post_occ = [6,7,8,9,10,11,12,13];
% left = [1,3,4,7,8,9];
% right = [16,15,14,13,12,11];
% broca = [3];
% wernick = [4,7,8];

