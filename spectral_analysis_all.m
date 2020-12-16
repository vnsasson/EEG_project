clc; close all; clear all;

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;  

setDir = 'C:\\Users\\sasso\\Desktop\\Studies\\Project\\B- Brain activity during reading\\datasets\\after_removing'; 

myFiles = dir(fullfile(setDir,'*.set')); %gets all set files in struct

freqReg = 5; % alpha, beta,...
brainReg = 7; % frontal, left, right,...

Mat = zeros(freqReg*size(myFiles),brainReg);

for k = 1:length(myFiles)
  filename = myFiles(k).name;
  filepath = myFiles(k).folder;
  Mat = spectral_analysis_func(ALLEEG,filename,filepath);  
end