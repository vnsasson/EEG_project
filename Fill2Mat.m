function [Paper,Screen] = Fill2Mat(EEG,OrdersMat,Paper,Screen,subj,from,to)

    TimeSize = 18;
    FreqSize = 45;

    Mat = EEG(subj).CAT.Conn.dDTF08(OrdersMat(from,subj*2-1),OrdersMat(to,subj*2-1),:,:); 
    Mat = reshape(Mat,length(Mat),TimeSize); % change matrix dimension
    Paper(:,:,subj) = Mat(1:FreqSize,:); %takes [1,45] Hz

    Mat = EEG(subj+1).CAT.Conn.dDTF08(OrdersMat(from,subj*2),OrdersMat(to,subj*2),:,:); 
    Mat = reshape(Mat,length(Mat),TimeSize);
    Screen(:,:,subj) = Mat(1:FreqSize,:); 

end



