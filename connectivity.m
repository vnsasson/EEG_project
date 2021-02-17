clc; clear all; close all;

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;  

%% 1 - Loading the dataset

% EEG = pop_loadset('filename','Reading_screen_6.2019_31.12.19.set','filepath','C:\\Users\\sasso\\Desktop\\Studies\\Project\\B- Brain activity during reading\\eeglab2020_0\\plugins\\SIFT\\Data\\test\\');
% EEG = eeg_checkset( EEG );

pause

%% 2 - determine the dipole model

EEG = pop_dipfit_settings( EEG, 'hdmfile','C:\\Users\\sasso\\Desktop\\Studies\\Project\\B- Brain activity during reading\\eeglab2020_0\\plugins\\dipfit\\standard_BESA\\standard_BESA.mat','coordformat','Spherical','mrifile','C:\\Users\\sasso\\Desktop\\Studies\\Project\\B- Brain activity during reading\\eeglab2020_0\\plugins\\dipfit\\standard_BESA\\avg152t1.mat','chanfile','C:\\Users\\sasso\\Desktop\\Studies\\Project\\B- Brain activity during reading\\eeglab2020_0\\plugins\\dipfit\\standard_BESA\\standard-10-5-cap385.elp','chansel',[1:63] );
EEG = eeg_checkset( EEG );
EEG = pop_dipfit_gridsearch(EEG, [1:EEG.nbchan] ,[-85     -77.6087     -70.2174     -62.8261     -55.4348     -48.0435     -40.6522     -33.2609     -25.8696     -18.4783      -11.087     -3.69565      3.69565       11.087      18.4783      25.8696      33.2609      40.6522      48.0435      55.4348      62.8261      70.2174      77.6087           85] ,[-85     -77.6087     -70.2174     -62.8261     -55.4348     -48.0435     -40.6522     -33.2609     -25.8696     -18.4783      -11.087     -3.69565      3.69565       11.087      18.4783      25.8696      33.2609      40.6522      48.0435      55.4348      62.8261      70.2174      77.6087           85] ,[0      7.72727      15.4545      23.1818      30.9091      38.6364      46.3636      54.0909      61.8182      69.5455      77.2727           85] ,0.4);
EEG = eeg_checkset( EEG );


%% 3 - Choosing the brain ICs - change it to manually select the brain ICs 

EEG = pop_iclabel(EEG, 'default');
EEG = eeg_checkset( EEG );

% % choosing the brain's ICs ( not showing here )
% EEG = pop_subcomp( EEG, [1   4   5   6   8  10  11  12  13  14  15  18  19  20  21  24  25  26  27  28  30  31  33  34  35  36  37  38  39  40  41  42  43  44  45  46  47  48  49  50  51  52  53  54  55  56  57  58  59  60  61  62  63], 0);
% EEG = eeg_checkset( EEG );

pause

%% 4 - Divide the time series to epochs of 1 sec

EEG=eeg_regepochs(EEG);
EEG=eeg_checkset(EEG);
eeglab redraw

%% 5 - saving the periods of [-0.5 0.5] sec periods of before and after event

EEG = pop_select( EEG, 'time',[-0.5 0.5] );
EEG = eeg_checkset( EEG );

%% 6 - preprocessing the dataset (normalization)

EEG = pop_pre_prepData(EEG);
EEG = eeg_checkset( EEG );

%% 7 - estimating the model order

EEG = pop_est_selModelOrder(EEG,0);
EEG = eeg_checkset( EEG );

%% 8 - estimating the model's matrixes using that order

EEG = pop_est_fitMVAR(EEG,0);
EEG = eeg_checkset( EEG );

%% 9 - checking whiteness

EEG = pop_est_validateMVAR(EEG,0);
EEG = eeg_checkset( EEG );

%% 10 - calculate connectivity

EEG = pop_est_mvarConnectivity(EEG);
EEG = eeg_checkset( EEG );

%% 11 - plotting matrix of ICA's time-freq connectivity

EEG = pop_vis_TimeFreqGrid(EEG);
EEG = eeg_checkset( EEG );


%% 12 - potting 3D movie of connectivity

pop_vis_causalBrainMovie3D(EEG);