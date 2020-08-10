close all; clc; clear all

fs = 500;

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;  

file_name = 'reading_screen_128.2019_8.12.19.vhdr';
 

%% 1-  Loading the data (all channels)
EEG = pop_loadbv('C:\Users\sasso\Desktop\Studies\Project\B- Brain activity during reading\data\', 'reading_screen_128.2019_8.12.19.vhdr', [], []);
EEG.setname='Original';
EEG = eeg_checkset( EEG );
[ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG); % save modifications 

time = EEG.times;

% figure;
% DFT_plot(EEG.data,fs);
% sgtitle('Original');
% 
% figure;
% time_plot(time,EEG.data);
% sgtitle('Original (time domai n)');

% figure;
% pop_spectopo(EEG, 1, [], 'EEG' , 'percent', 100, 'freqrange',[0 60],'electrodes','off');



%% 2- Read channel locations

EEG=pop_chanedit(EEG, 'lookup','C:\\Users\\sasso\\Desktop\\Studies\\Project\\B- Brain activity during reading\\eeglab2020_0\\plugins\\dipfit\\standard_BESA\\standard-10-5-cap385.elp');
EEG = eeg_checkset( EEG );
[ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG); % save modifications 


%% 3- Removing baseline (reduce the DC offset) 
% useful when baseline differences between data epochs

EEG = pop_rmbase(EEG,[],[]);
EEG.setname='Bias removed';
EEG = eeg_checkset( EEG );
[ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG);

% figure;
% DFT_plot(EEG_rmbase.data,fs);
% sgtitle('FFT after remove bias');
% 
% figure;
% time_plot(time,EEG_rmbase.data);
% sgtitle('signals after remove bias');
% 
% figure;
% pop_spectopo(EEG_rmbase, 1, [0  138478], 'EEG' , 'percent', 100, 'freqrange',[0 60],'electrodes','off');
% 


%% reject artifact


% EEG = pop_rejchan(EEG, 'elec',[1:63] ,'threshold',5,'norm','on','measure','kurt');
% EEG = eeg_checkset( EEG );
% [ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG); 
% 
% EEG = pop_clean_rawdata(EEG, 'FlatlineCriterion',5,'ChannelCriterion',0.8,'LineNoiseCriterion',4,'Highpass','off','BurstCriterion',20,'WindowCriterion',0.25,'BurstRejection','on','Distance','Euclidian','WindowCriterionTolerances',[-Inf 7] );
% EEG = eeg_checkset( EEG );
% [ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG);

pop_eegplot( EEG, 1, 1, 1);
pause

%% referecence to avarage

EEG = pop_reref( EEG, []);
EEG.setname='Referenced';
EEG = eeg_checkset( EEG );
[ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG);

% figure;
% DFT_plot(EEG_referenced.data,fs);
% title('FFT referenced');
% 
% 
% figure;
% time_plot(time,EEG_referenced.data);
% title('referenced signal');



%% 4- filtering - BPF 0.3 - 45

%HP 0.3
EEG = pop_eegfiltnew(EEG, 'locutoff',0.3,'plotfreqz',1);
EEG.setname='0.3 [Hz] HPF';
EEG = eeg_checkset( EEG );
[ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG);

% figure;
% time_plot(time,EEG_rmbase.data);
% sgtitle('signals after DC offset');
% 
% figure;
% DFT_plot(EEG_DC_filt.data,fs);
% sgtitle('After 0.3 Hz HPF');


% 50 Hz notch
EEG = pop_eegfiltnew(EEG, 'locutoff',47.5,'hicutoff',52.5,'revfilt',1,'plotfreqz',1);
EEG.setname='50 [Hz] Notch';
EEG = eeg_checkset( EEG );
[ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG);

%LP 45
EEG = pop_eegfiltnew(EEG, 'hicutoff',45,'plotfreqz',1);
EEG.setname='45 [Hz] LPF';
EEG = eeg_checkset( EEG );
[ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG);


% figure;
% DFT_plot(filtered_EEG.data,fs);
% sgtitle('After 50[Hz] notch and 45[Hz] HPF');


%% reject by eye before ICA

pop_eegplot( EEG, 1, 0, 1);
pause
EEG.setname='reject by eye before ICA';
EEG = eeg_checkset( EEG );
[ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG); % save modifications 

%% ICA

EEG = pop_runica(EEG, 'icatype', 'runica', 'extended',1,'interrupt','on');
EEG.setname='After ICA';
EEG = eeg_checkset( EEG );
[ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG); % save modifications 


%% pop the gui
 
 eeglab redraw














