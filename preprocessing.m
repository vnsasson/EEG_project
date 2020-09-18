close all; clc; clear all

fs = 500;

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;  

file_name = 'Reading_paper_6.2019_31.12.19.vhdr';

channel_num = 50;


 

%% 1-  Loading the data (all channels)
%for 63/64 electrodes
EEG = pop_loadbv('C:\Users\sasso\Desktop\Studies\Project\B- Brain activity during reading\data\', file_name, [], []);
EEG.setname='Original';
EEG = eeg_checkset( EEG );
[ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG); % save modifications 

% for 16 electrodes

% EEG = pop_biosig('C:\Users\sasso\Desktop\Studies\Project\B- Brain activity during reading\data\Reading_paper_104.2019_15.07.19.ahdr');
% EEG.setname='Original';
% EEG = eeg_checkset( EEG );
% [ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG); % save modifications 

% figure;
% time_plot1(EEG.times,EEG.data,channel_num);
% sgtitle('Original (time domain)');
% 
% figure;
% DFT_plot1(EEG.data,channel_num,fs);
% sgtitle('Original');


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
% time_plot1(EEG.times,EEG.data,channel_num);
% sgtitle('signals after remove bias');
% 
% figure;
% DFT_plot1(EEG.data,channel_num,fs);
% sgtitle('FFT after remove bias');

% figure;
% pop_spectopo(EEG, 1, [], 'EEG' , 'percent', 100, 'freqrange',[0 60],'electrodes','off');


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
% sgtitle('0.3 [Hz] HPF (time)');
% 
% figure;
% DFT_plot1(EEG.data,channel_num,fs);
% sgtitle('0.3 [Hz] HPF (freq)');


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
% sgtitle('0.3 - 45 BPF (time)');
% 
% figure;
% DFT_plot1(EEG.data,channel_num,fs);
% sgtitle('0.3 - 45 BPF (freq)');


%% 7- reject beofre ICA

EEG = pop_rejchan(EEG, 'elec',[1:EEG.nbchan] ,'threshold',5,'norm','on','measure','kurt');

EEG = eeg_checkset( EEG );
[ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG); 
% 
% EEG = pop_clean_rawdata(EEG, 'FlatlineCriterion',5,'ChannelCriterion',0.8,'LineNoiseCriterion',4,'Highpass','off','BurstCriterion',20,'WindowCriterion',0.25,'BurstRejection','on','Distance','Euclidian','WindowCriterionTolerances',[-Inf 7] );
% EEG = eeg_checkset( EEG );
% [ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG);

% EEG = pop_rejcont(EEG, 'elecrange',[1:63] ,'freqlimit',[0.3 45] ,'threshold',10,'epochlength',0.5,'contiguous',4,'addlength',0.25,'taper','hamming');
% EEG.setname='automated_rej';
% EEG = eeg_checkset( EEG );

% pop_eegplot( EEG, 1, 0, 1);
% pause
% EEG.setname='reject by eye before ICA';
% EEG = eeg_checkset( EEG );
% [ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG); % save modifications 

%% 8- ICA

% EEG = pop_runica(EEG, 'icatype', 'runica', 'extended',1,'interrupt','on');
% EEG.setname='After ICA';
% EEG = eeg_checkset( EEG );
% [ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG); % save modifications

%% 9- saving dataset to library - optional for automatic save the dataset before removing bad ICA
 
% EEG = pop_saveset( EEG, 'filename',file_name,'filepath','C:\\Users\\sasso\\Desktop\\Studies\\Project\\B- Brain activity during reading\\datasets\\before_removing\\');
% EEG = eeg_checkset( EEG );
% EEG = pop_iclabel(EEG, 'default');
% EEG = eeg_checkset( EEG );
% EEG = pop_icflag(EEG, [NaN NaN;0.9 1;0.9 1;NaN NaN;NaN NaN;NaN NaN;NaN NaN]);
% EEG = eeg_checkset( EEG );

%% 10- pop the gui
 
 eeglab redraw
 

 

    
    
    
 

 

 
 


 
 
 

 
 
 
 
 
 
 
 




 
 
 
 














