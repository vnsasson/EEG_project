
function [] = preprocessing_63_func(ALLEEG,myDir,file_name,filepath_before,filepath_after,cap385)

    % start eeglab
    %[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;  
    
    %% 1-  Loading the data (all channels)

    EEG = pop_loadbv(myDir, file_name, [], []);
    EEG.setname='Original';
    EEG = eeg_checkset( EEG );
    [ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG); % save modifications 


    %% 2- Reading channel locations

    EEG=pop_chanedit(EEG, 'lookup',cap385);
    EEG = eeg_checkset( EEG );
    [ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG); % save modifications

    %% 3- Reject artifact manually

    pop_eegplot( EEG, 1, 1, 1);    
    pause

    %% 4- filtering - BPF [0.3 - 45 Hz]

    %HP 0.3
    EEG = pop_eegfiltnew(EEG, 'locutoff',0.3);
    EEG.setname='0.3 [Hz] HPF';
    EEG = eeg_checkset( EEG );
    [ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG);

    % 50 Hz notch ( 47.5-52.5 BSF)
    EEG = pop_eegfiltnew(EEG, 'locutoff',47.5,'hicutoff',52.5,'revfilt',1);
    EEG.setname='50 [Hz] Notch';
    EEG = eeg_checkset( EEG );
    [ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG);

    %LP 45
    EEG = pop_eegfiltnew(EEG, 'hicutoff',45);
    EEG.setname='45 [Hz] LPF';
    EEG = eeg_checkset( EEG );
    [ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG);


    %% 5- Referecence to avarage

    EEG = pop_reref( EEG, []);
    EEG.setname='Referenced';
    EEG = eeg_checkset( EEG );
    [ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG);

    %% 6- reject automatically before decompose data by ICA

    EEG = pop_rejchan(EEG, 'elec',[1:EEG.nbchan] ,'threshold',5,'norm','on','measure','prob');
    EEG.setname='after_auto_reject';
    EEG = eeg_checkset( EEG );
    [ALLEEG EEG  CURRENTSET] = eeg_store(ALLEEG, EEG);

    %% 7- decompose by ICA

    EEG = pop_runica(EEG, 'icatype', 'runica', 'extended',1,'interrupt','on');
    EEG.setname='After ICA';
    EEG = eeg_checkset( EEG );
    [ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG); % save modifications

    %% 8- saving dataset to library - optional for automatically saving the dataset 

    % saving the dataset to filepath before component removing
    EEG = pop_saveset( EEG, 'filename',file_name,'filepath',filepath_before);
    EEG = eeg_checkset( EEG );

    % labeling the ICAs automatically
    EEG = pop_iclabel(EEG, 'default');
    EEG = eeg_checkset( EEG );
    [ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG); % save modifications

    % remove ICAs with 90% precent to be eye/muscle
    EEG = pop_icflag(EEG, [NaN NaN;0.9 1;0.9 1;NaN NaN;NaN NaN;NaN NaN;NaN NaN]);
    EEG = eeg_checkset( EEG );
    [ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG); % save modifications


    % saving the dataset to filepath after component removing
    EEG = pop_saveset( EEG, 'filename',file_name,'filepath',filepath_after);
    EEG = eeg_checkset( EEG );
    EEG.setname='After component removing';
    %[ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG); % save modifications

% 
%     %% 9- pop the gui
% 
%      eeglab redraw
     
end