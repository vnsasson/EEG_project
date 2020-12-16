function new_vec = change_vec(vec,Num_elec)
%close all; clear all; clc;

% frontal  =  [1,32,33,34,35,62,63,4,37,3,36,2,61,30,60,31];
% Num_elec = 61;

len = length(vec);
count=0;

for i = 1:len
    if vec(i) <= Num_elec
        count = count+1;
    end
end

new_vec = zeros(count,1);

j=1;

for i = 1:len
    if vec(i) <= Num_elec
        new_vec(j) = vec(i);
        j=j+1;
    end
end

        

% clear all
% 
% % 
% % [Hist] = fill_regions(63);
% % 
% % writematrix(Hist,'C:\Users\sasso\Desktop\Studies\Project\B- Brain activity during reading\eeglab2020_0\excel_mat\Hist.xlsx');
% 
% frontal  =  [1,32,33,34,35,62,63,4,37,3,36,2,61,30,60,31];
% central  =  [8,41,24,57,25];
% 
% col_size = max(length(frontal),length(central));
% Mat = zeros(2,col_size);
% 
% Mat(1,:) = frontal;
% Mat(2,:) = [central,zeros(col_size-length(central)),1];
    

