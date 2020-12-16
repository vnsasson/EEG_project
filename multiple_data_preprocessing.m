clc; close all; clear all;

%% configuration

[myDir,filepath_before,filepath_after,cap385,cap16,fs] = configuration_multiple();

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;  


%% preprocessing

% preprocessing 63/64 electrodes files
myFiles_63 = dir(fullfile(myDir,'*.vhdr')); %gets all vhdr files in struct
for k = 1:length(myFiles_63)
  baseFileName = myFiles_63(k).name;
  preprocessing_63_func(ALLEEG,myDir,baseFileName,filepath_before,filepath_after,cap385);  
end

% preprocessing 16 electrodes files
myFiles_16 = dir(fullfile(myDir,'*.ahdr')); % gets all ahdr files in struct
for k = 1:length(myFiles_16)
  baseFileName = myFiles_16(k).name;
  fullFileName = fullfile(myDir, baseFileName);
  preprocessing_16_func(baseFileName,fullFileName,filepath_before,filepath_after,cap385,cap16);  
end


