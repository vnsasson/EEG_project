function [new_frontal,new_central,new_post_occ,new_left,new_right,new_broca,new_wernick] = fill_regions(Num_elec)

if (Num_elec <=64 ) && (Num_elec > 50) 
    frontal  =  [1,32,33,34,35,62,63,4,37,3,36,2,61,30,60,31];
    central  =  [8,41,24,57,25];
    post_occ =  [15,46,14,45,13,53,19,52,20,47,48,49,50,51,16,17,18];
    left     =  [1,33,34,3,4,36,37,5,6,7,38,39,8,9,41,42,10,11,12,43,44,14,15,45,46,16,47,48];
    right    =  [18,19,20,21,22,23,25,26,27,28,29,30,31,32,50,51,52,53,54,55,56,57,58,59,60,61,62,63];
    broca    =  [3,4,6,8,37,39];
    wernick  =  [9,11,14,15,43,46];
end

if (Num_elec <=16) 
    frontal = [1,2,3,15,16];
    central = [5];
    post_occ = [6,7,8,9,10,11,12,13];
    left = [1,3,4,7,8,9];
    right = [16,15,14,13,12,11];
    broca = [3];
    wernick = [4,7,8];
end

new_frontal = change_vec(frontal,Num_elec);
new_central = change_vec(central,Num_elec);
new_post_occ = change_vec(post_occ,Num_elec);
new_left = change_vec(left,Num_elec);
new_right = change_vec(right,Num_elec);
new_broca = change_vec(broca,Num_elec);
new_wernick = change_vec(wernick,Num_elec);



        


