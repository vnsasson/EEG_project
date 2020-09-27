close all; clc; clear all

fs = 500;

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;  


file_name = 'Reading_paper_6.2019_31.12.19.vhdr'; % only for 63/64 electrodes

channel_num = 2;


 

%% 1-  Loading the data (all channels)
% for 63/64 electrodes

% EEG = pop_loadbv('C:\Users\sasso\Desktop\Studies\Project\B- Brain activity during reading\data\', file_name, [], []);
% EEG.setname='Original';
% EEG = eeg_checkset( EEG );
% [ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG); % save modifications 
 
% for 16 electrodes

EEG = pop_biosig('C:\Users\sasso\Desktop\Studies\Project\B- Brain activity during reading\data\Reding_screen_14.2019_5.08.19.ahdr ');
EEG.setname='Original';
EEG = eeg_checkset( EEG );
[ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG); % save modifications 

% figure; 
% time_plot1(EEG.times,EEG.data,channel_num);
% title('Original (time domain)');
% 
% figure;
% DFT_plot1(EEG.data,channel_num,fs);
% title('Original');


%% 2- Read channel locations

% for 63
% EEG=pop_chanedit(EEG, 'lookup','C:\\Users\\sasso\\Desktop\\Studies\\Project\\B- Brain activity during reading\\eeglab2020_0\\plugins\\dipfit\\standard_BESA\\elec16.ced');
% EEG = eeg_checkset( EEG );
% [ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG); % save modifications 

% for 16
EEG=pop_chanedit(EEG, 'lookup','C:\\Users\\sasso\\Desktop\\Studies\\Project\\B- Brain activity during reading\\eeglab2020_0\\plugins\\dipfit\\standard_BESA\\standard-10-5-cap385.elp','load',{'C:\\Users\\sasso\\Desktop\\Studies\\Project\\B- Brain activity during reading\\eeglab2020_0\\plugins\\dipfit\\standard_BESA\\elec16.ced','filetype','autodetect'});
EEG = eeg_checkset( EEG );
[ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG); % save modifications 

%% 4 -  Reject artifact

% reject by eye
pop_eegplot( EEG, 1, 1, 1);
pause

%% 5- Referecence to avarage

EEG = pop_reref( EEG, []);
EEG.setname='Referenced';
EEG = eeg_checkset( EEG );
[ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG);

% figure;
% time_plot1(EEG.times,EEG.data,channel_num);
% title('referenced signal');
% 
% figure;
% DFT_plot1(EEG.data,channel_num,fs);
% title('FFT referenced');


%% 6- filtering - BPF [0.3 - 45]

%HP 0.3
EEG = pop_eegfiltnew(EEG, 'locutoff',0.3);
EEG.setname='0.3 [Hz] HPF';
EEG = eeg_checkset( EEG );
[ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG);

% figure;
% time_plot1(EEG.times,EEG.data,channel_num);
% title('0.3 [Hz] HPF (time)');
% 
% figure;
% DFT_plot1(EEG.data,channel_num,fs);
% title('0.3 [Hz] HPF (freq)');


% 50 Hz notch
EEG = pop_eegfiltnew(EEG, 'locutoff',47.5,'hicutoff',52.5,'revfilt',1);
EEG.setname='50 [Hz] Notch';
EEG = eeg_checkset( EEG );
[ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG);

%LP 45
EEG = pop_eegfiltnew(EEG, 'hicutoff',45);
EEG.setname='45 [Hz] LPF';
EEG = eeg_checkset( EEG );
[ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG);


% figure;
% time_plot1(EEG.times,EEG.data,channel_num);
% title('0.3 - 45 BPF (time)');
% 
% figure;
% DFT_plot1(EEG.data,channel_num,fs);
% title('0.3 - 45 BPF (freq)');


%% 7- reject beofre ICA

% EEG = pop_rejchan(EEG, 'elec',[1:EEG.nbchan] ,'threshold',5,'norm','on','measure','kurt');
% EEG.setname='after rejchan';
% EEG = eeg_checkset( EEG );
% [ALLEEG EEG  CURRENTSET] = eeg_store(ALLEEG, EEG); 
% %%  pop_clean_rawdata
% EEG = pop_clean_rawdata(EEG, 'FlatlineCriterion',5,'ChannelCriterion',0.8,'LineNoiseCriterion',4,'Highpass','off','BurstCriterion',20,'WindowCriterion',0.25,'BurstRejection','on','Distance','Euclidian','WindowCriterionTolerances',[-Inf 7] );
% EEG.setname='after clean_rawdata';
% EEG = eeg_checkset( EEG );
% [ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG);
%     
% %% pop_rejcont
% EEG = pop_rejcont(EEG, 'elecrange',[1:EEG.nbchan] ,'freqlimit',[0.3 45] ,'threshold',10,'epochlength',0.5,'contiguous',4,'addlength',0.25,'taper','hamming');
% EEG.setname='after pop_rejcont';
% EEG = eeg_checkset( EEG );
%[ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG);

%% reject by eye
pop_eegplot( EEG, 1, 0, 1);
pause
EEG.setname='reject by eye before ICA';
EEG = eeg_checkset( EEG );
[ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG); % save modifications

% figure;
% time_plot1(EEG.times,EEG.data,channel_num);
% title('After automatic bad channel reduction');
% 
% figure;
% DFT_plot1(EEG.data,channel_num,fs);
% title('After automatic bad channel reduction');

%% 8- ICA

EEG = pop_runica(EEG, 'icatype', 'runica', 'extended',1,'interrupt','on');
EEG.setname='After ICA';
EEG = eeg_checkset( EEG );
[ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG); % save modifications

%% 9- saving dataset to library - optional for automatic save the dataset before removing bad ICA
 
% EEG = pop_saveset( EEG, 'filename',file_name,'filepath','C:\\Users\\sasso\\Desktop\\Studies\\Project\\B- Brain activity during reading\\datasets\\before_removing\\');
% EEG = eeg_checkset( EEG );
% EEG = pop_iclabel(EEG, 'default');
% EEG = eeg_checkset( EEG );
% EEG = pop_icflag(EEG, [NaN NaN;0.9 1;0.9 1;NaN NaN;NaN NaN;NaN NaN;NaN NaN]);
% EEG = eeg_checkset( EEG );

%% 10- pop the gui
 
 eeglab redraw
 
