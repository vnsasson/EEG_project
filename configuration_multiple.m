function [myDir,filepath_before,filepath_after,cap385,cap16,fs] = configuration_multiple()

% data directory

myDir = 'C:\\Users\\sasso\\Desktop\\Studies\\Project\\B- Brain activity during reading\\data'; 
%myDir = 'C:\\Users\sasso\\Desktop\\Studies\\Project\\B- Brain activity during reading\\data_test';



% filepaths for saving the preprocessed datasets

% directory for saving datasets before component removing

filepath_before = 'C:\\Users\\sasso\\Desktop\\Studies\\Project\\B- Brain activity during reading\\datasets\\before_try\\';

% directory for saving datasets after component removing

filepath_after = 'C:\\Users\\sasso\\Desktop\\Studies\\Project\\B- Brain activity during reading\\datasets\\after_try\\';



% full channel location's file name

cap385 = 'C:\Users\sasso\Desktop\Studies\Project\B- Brain activity during reading\eeglab2020_0\channel_loc\standard-10-5-cap385.elp';
cap16 = 'C:\Users\sasso\Desktop\Studies\Project\B- Brain activity during reading\eeglab2020_0\channel_loc\elec16.ced';

% recorder sampling rate
fs = 500;