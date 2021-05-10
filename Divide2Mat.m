clc; close all; clear all;

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab; 

% Dataset's directory
% old setDir = 'C:\\Users\\sasso\\Desktop\\Studies\\Project\\B- Brain activity during reading\\datasets\\8\\';
setDir = 'C:\\Users\\Sasson\\Desktop\\Studies\\EEG_project\\datasets\\8\\';
% Excel matrix of dipole's order
OrdersMat = fliplr(xlsread('orderMat.xlsx','AB2:A9'));

% Constants

SubjectsNum = 14;
TimeSize = 18;
FreqSize = 45;
BrainRegNum = 8;
ConnectNum = 64;
p_val = 0.05;

%% set regions

Regions = cell(1,BrainRegNum);
% Regions{1} = 'Left Frontal'; Regions{2} = 'Right Frontal'; Regions{3} = 'Left Partial'; 
% Regions{4} = 'Right Partial'; Regions{5} = 'Left Occipital'; Regions{6} = 'Right Occipital';
% Regions{7} = 'Left Temporal'; Regions{8} = 'Right Temporal';

Regions{1} = 'LF'; Regions{2} = 'RF'; Regions{3} = 'LP'; 
Regions{4} = 'RP'; Regions{5} = 'LO'; Regions{6} = 'RO';
Regions{7} = 'LT'; Regions{8} = 'RT';

%% Load datasets

EEG = pop_loadset('filename',{'11.7_paper.set','11.7_screen.set','14.7_paper.set','14.7_screen.set','15.10_paper.set','15.10_screen.set','15.7_paper.set','15.7_screen.set','17.10_paper.set','17.10_screen.set','19.8_paper.set','19.8_screen.set','21.8_paper.set','21.8_screen.set','24.12_paper.set','24.12_screen.set','24.9_paper.set','24.9_screen.set','28.7_paper.set','28.7_screen.set','4.7_paper.set','4.7_screen.set','5.12_paper.set','5.12_screen.set','5.8_paper.set','5.8_screen.set','8.12_paper.set','8.12_screen.set'},'filepath',setDir);


%% Fill 2 Matrices (Paper,Screen) for all brain areas
% The Big matrices includes:
%                             The first dimension represent the whole
%                             connections between two brain regions.
% For every connection has a 3-D matrix of time*freq for each subject                            

BigPaper = zeros(ConnectNum,FreqSize,TimeSize,SubjectsNum);
BigScreen = zeros(ConnectNum,FreqSize,TimeSize,SubjectsNum);

for from = 1 : BrainRegNum
    for to = 1 : BrainRegNum

        Paper = zeros(FreqSize,TimeSize,SubjectsNum);
        Screen = zeros(FreqSize,TimeSize,SubjectsNum);

        for subj = 1 : SubjectsNum
            [Paper,Screen] = Fill2Mat(EEG,OrdersMat,Paper,Screen,subj,from,to);
        end
        BigPaper((from-1)*BrainRegNum+to,:,:,:) = Paper;
        BigScreen((from-1)*BrainRegNum+to,:,:,:) = Screen;
    end
end


%%

Adj_P1 = zeros(FreqSize,TimeSize,ConnectNum);

for i = 1 : ConnectNum
    
    Single_paper = single(BigPaper(i,:,:,:));
    Single_screen = single(BigScreen(i,:,:,:));
    Res_cell = cell(1,2);
    Res_cell{1} = Single_paper;
    Res_cell{2} = Single_screen;
    
    [stats1, df1, pvals1, surrog1] = statcond(Res_cell, 'mode','bootstrap','naccu',10000 );
    [h2, crit_p1, adj_ci_cvrg1, adj_p1]=fdr_bh(pvals1);   %fdr correction

    Adj_P1(:,:,i) = adj_p1;
    
end


%% Transform the p_val matrix to (1/0) matrix
% 1 = for p-val < 0.05
% 0 = for p_val > 0.05

ZeroOne = zeros(FreqSize,TimeSize,ConnectNum);

for i = 1 : FreqSize
    for j = 1 : TimeSize
        for k = 1 : ConnectNum
            if Adj_P1(i,j,k) <= p_val
                ZeroOne(i,j,k) = 1;
            end
        end
    end
end


%% plotting all connectivity matrices

time = EEG(1).CAT.Conn.winCenterTimes;
freq = 1:FreqSize;

k=1;
figure;
for i = 1 : ConnectNum
    
    from = fix(i/BrainRegNum)+1;
    to = mod(i,BrainRegNum);
    
    if mod(i,BrainRegNum)==0
        from = from-1;
        to = BrainRegNum;
    end
    
    if from == to
        continue;
    end
    
    subplot(8,7,k);
    imagesc(time,freq,ZeroOne(:,:,i));
    title(['From ' Regions{from} ' to ' Regions{to}]);
    k=k+1;

end
