function [LFRFpaper,LFRFscreen] = Fill2Mat(EEG,OrdersMat,LFRFpaper,LFRFscreen,subj)

TimeSize = 18;
FreqSize = 45;

Mat = EEG(subj).CAT.Conn.dDTF08(OrdersMat(1,subj*2-1),OrdersMat(2,subj*2-1),:,:); 
Mat = reshape(Mat,length(Mat),TimeSize);
LFRFpaper(:,:,subj) = Mat(1:FreqSize,:); %takes [1,45] Hz

Mat = EEG(subj+1).CAT.Conn.dDTF08(OrdersMat(1,subj*2),OrdersMat(2,subj*2),:,:); 
Mat = reshape(Mat,length(Mat),TimeSize);
LFRFscreen(:,:,subj) = Mat(1:FreqSize,:); %takes [1,45] Hz




% %% Left Frontal -> Right Frontal for first subject (11.7)
% 
% Mat = EEG(1).CAT.Conn.dDTF08(OrdersMat(1,1),OrdersMat(2,1),:,:); 
% Mat = reshape(Mat,124,18); 
% LFRFpaper(:,:,1) = Mat(1:45,:); %takes [1,45] Hz
% 
% Mat = EEG(2).CAT.Conn.dDTF08(OrdersMat(1,2),OrdersMat(2,2),:,:); 
% Mat = reshape(Mat,124,18); 
% LFRFscreen(:,:,1) = Mat(1:45,:); %takes [1,45] Hz

% %% Left Frontal -> Right Frontal for second subject (14.7) subj=2
% 
%     Mat = EEG(3).CAT.Conn.dDTF08(OrdersMat(1,3),OrdersMat(2,3),:,:); 
%     Mat = reshape(Mat,124,18); 
%     LFRFpaper(:,:,2) = Mat(1:45,:); %takes [1,45] Hz
% 
%     Mat = EEG(4).CAT.Conn.dDTF08(OrdersMat(1,4),OrdersMat(2,4),:,:); 
%     Mat = reshape(Mat,124,18); 
%     LFRFscreen(:,:,2) = Mat(1:45,:); %takes [1,45] Hz

end



