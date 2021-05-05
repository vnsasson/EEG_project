clc; close all; clear all;

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab; 

% Constants

SubjectsNum = 14;
TimeSize = 18;
FreqSize = 45;


% Excel matrix of dipole's order

OrdersMat = xlsread('orderMat.xlsx','AB2:A9');
OrdersMat = fliplr(OrdersMat);


%% Load datasets

EEG = pop_loadset('filename',{'11.7_paper.set','11.7_screen.set','14.7_paper.set','14.7_screen.set','15.10_paper.set','15.10_screen.set','15.7_paper.set','15.7_screen.set','17.10_paper.set','17.10_screen.set','19.8_paper.set','19.8_screen.set','21.8_paper.set','21.8_screen.set','24.12_paper.set','24.12_screen.set','24.9_paper.set','24.9_screen.set','28.7_paper.set','28.7_screen.set','4.7_paper.set','4.7_screen.set','5.12_paper.set','5.12_screen.set','5.8_paper.set','5.8_screen.set','8.12_paper.set','8.12_screen.set'},'filepath','C:\\Users\\sasso\\Desktop\\Studies\\Project\\B- Brain activity during reading\\datasets\\8\\');


%% Left Frontal -> Right Frontal

LFRFpaper = zeros(FreqSize,TimeSize,SubjectsNum);
LFRFscreen = zeros(FreqSize,TimeSize,SubjectsNum);
LF=1; RF=2; LP=3; RP=4; LO=5; RO=6; LT=7; LR=8;

for subj = 1 : SubjectsNum
    [LFRFpaper,LFRFscreen] = Fill2Mat(EEG,OrdersMat,LFRFpaper,LFRFscreen,subj);
end

%% P - test

[stats1, df1, pvals1, surrog1] = statcond(LFRFpaper, LFRFscreen, 'mode','bootstrap','naccu',10000 );
[h2, crit_p1, adj_ci_cvrg1, adj_p1]=fdr_bh(pvals1);   %fdr correction




























% %% Left Frontal -> Right Frontal for first subject (11.7)
% 
% Mat = EEG(1).CAT.Conn.dDTF08(OrdersMat(1,1),OrdersMat(2,1),:,:); 
% Mat = reshape(Mat,124,18); 
% LFRFpaper(:,:,1) = Mat(1:45,:); %takes [1,45] Hz
% 
% Mat = EEG(2).CAT.Conn.dDTF08(OrdersMat(1,2),OrdersMat(2,2),:,:); 
% Mat = reshape(Mat,124,18); 
% LFRFscreen(:,:,1) = Mat(1:45,:); %takes [1,45] Hz
% 
% %% Left Frontal -> Left Partial for first subject
% 
% Mat = EEG(1).CAT.Conn.dDTF08(OrdersMat(1,1),OrdersMat(3,1),:,:); 
% Mat = reshape(Mat,124,18); 
% LFLPpaper(:,:,1) = Mat(1:45,:); %takes [1,45] Hz
% 
% Mat = EEG(2).CAT.Conn.dDTF08(OrdersMat(1,2),OrdersMat(3,2),:,:); 
% Mat = reshape(Mat,124,18); 
% LFLPscreen(:,:,1) = Mat(1:45,:); %takes [1,45] Hz
% 
% %% Left Frontal -> Right Frontal for second subject (14.7)
% 
% Mat = EEG(3).CAT.Conn.dDTF08(OrdersMat(1,3),OrdersMat(2,3),:,:); 
% Mat = reshape(Mat,124,18); 
% LFRFpaper(:,:,2) = Mat(1:45,:); %takes [1,45] Hz
% 
% Mat = EEG(4).CAT.Conn.dDTF08(OrdersMat(1,4),OrdersMat(2,4),:,:); 
% Mat = reshape(Mat,124,18); 
% LFRFscreen(:,:,2) = Mat(1:45,:); %takes [1,45] Hz
% 
% %% Left Frontal -> Left Partial for second subject (14.7)
% 
% Mat = EEG(3).CAT.Conn.dDTF08(OrdersMat(1,3),OrdersMat(3,3),:,:); 
% Mat = reshape(Mat,124,18); 
% LFLPpaper(:,:,2) = Mat(1:45,:); %takes [1,45] Hz
% 
% Mat = EEG(4).CAT.Conn.dDTF08(OrdersMat(1,4),OrdersMat(3,4),:,:); 
% Mat = reshape(Mat,124,18); 
% LFLPscreen(:,:,2) = Mat(1:45,:); %takes [1,45] Hz


% %%  plotting
% 
% time = EEG(1).CAT.Conn.winCenterTimes;
% freq = 1:45;
% 
% figure;
% surf(time,freq,LFRFpaper(:,:,2));















% %% 
% 
% for k = 1:length(myFiles)
%   filename = myFiles(k).name;
%   filepath = myFiles(k).folder;
%   %sift_to_matrix_func(ALLEEG,filename,filepath); 
%   
%   fill_matrices(ALLEEG,filename,filepath,OrdersMat,LFRFpaper,LFRFscreen);
% end