close all; clc; clear all

fs = 500;

% uncomment in the first time
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;

% uncomment in the second time
%ALLEEG(2) = EEG;
%CURRENTSET = 2;



%% 1-  Loading the data (all channels)
EEG = pop_loadbv('C:\Users\sasso\Desktop\Studies\Project\B- Brain activity during reading\data\', 'Reading_paper_6.2019_31.12.19.vhdr', [], [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63]);
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
% sgtitle('Original (time domain)');
% 
% figure;
% pop_spectopo(EEG, 1, [0  138478], 'EEG' , 'percent', 100, 'freqrange',[0 60],'electrodes','off');
% 


%% 2- Read channel locations

EEG.chanlocs = pop_chanedit(EEG.chanlocs, 'lookup','C:\\Users\\sasso\\Desktop\\Studies\\Project\\B- Brain activity during reading\\eeglab2019_1\\plugins\\dipfit\\standard_BESA\\standard-10-5-cap385.elp','load',[],'eval','');


%% reject by eye

pop_eegplot( EEG, 1, 0, 1);
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
% 

%% 3- Removing baseline (reduce the offset) 
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

%% 4- filtering - BPF 0.5 - 45

%HP 0.5
EEG = pop_eegfilt( EEG, 0.5, 0);
EEG.setname='0.5 [Hz] HPF';
EEG = eeg_checkset( EEG );
[ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG);

% figure;
% time_plot(time,EEG_rmbase.data);
% sgtitle('signals after DC offset');
% 
% figure;
% DFT_plot(EEG_DC_filt.data,fs);
% sgtitle('After 0.5 Hz HPF');


% 50 Hz notch
EEG = pop_eegfiltnew( EEG, 47.5, 52.5, [], 1 );
EEG.setname='50 [Hz] Notch';
EEG = eeg_checkset( EEG );
[ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG);

%LP 45
EEG = pop_eegfilt( EEG, 0, 45);
EEG.setname='45 [Hz] LPF';
EEG = eeg_checkset( EEG );
[ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG);

% 
% figure;
% DFT_plot(filtered_EEG.data,fs);
% sgtitle('After 50[Hz] notch and 45[Hz] HPF');


%% plot spectrum

% figure;
% pop_spectopo(filtered_EEG, 1, [0  138478], 'EEG' , 'percent', 100, 'freqrange',[0 60],'electrodes','off');


%% ICA

%EEG = pop_runica(EEG, 'icatype', 'runica', 'extended',1,'interrupt','on');
%[ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG);
EEG.setname='After ICA';
EEG = eeg_checkset( EEG );

%% pop the gui
 
 eeglab redraw














