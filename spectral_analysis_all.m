clc; close all; clear all;

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;  

% import set
setDir = 'C:\\Users\\sasso\\Desktop\\Studies\\Project\\B- Brain activity during reading\\datasets\\after_removing'; 

myFiles = dir(fullfile(setDir,'*.set')); %gets all set files in struct

freqReg = 5; % alpha, beta,... (number of frequency regions)
brainReg = 7; % frontal, left, right,... (number of brain regions)
filesNum = size(myFiles);
filesNum = filesNum(1);

Mat = zeros(freqReg*filesNum,brainReg);

for k = 1:length(myFiles)
  filename = myFiles(k).name;
  filepath = myFiles(k).folder;
  Mat = spectral_analysis_func(ALLEEG,filename,filepath,Mat,k);  
end



