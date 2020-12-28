function Mat = fill_T_paper(Mat,Wave_Mat,k,frontal,central,post_occ,left,right,broca,wernick)


freq_regions = 5;
brain_areas = 7;
paper_T = zeros(freq_regions,brain_areas*2);


% delta

delta_frontal = mean(Wave_Mat(frontal,1));
paper_T(1,13) = delta_frontal;
delta_central = mean(Wave_Mat(central,1));
paper_T(1,11) = delta_central;
delta_left = mean(Wave_Mat(left,1));
paper_T(1,9) = delta_left;
delta_right = mean(Wave_Mat(right,1));
paper_T(1,7) = delta_right;
delta_post_occ = mean(Wave_Mat(post_occ,1));
paper_T(1,5) = delta_post_occ;
delta_broca = mean(Wave_Mat(broca,1));
paper_T(1,3) = delta_broca;
delta_wernick = mean(Wave_Mat(wernick,1));
paper_T(1,1) = delta_wernick;

% theta

theta_frontal = mean(Wave_Mat(frontal,2));
paper_T(2,13) = theta_frontal;
theta_central = mean(Wave_Mat(central,2));
paper_T(2,11) = theta_central;
theta_left = mean(Wave_Mat(left,2));
paper_T(2,9) = theta_left;
theta_right = mean(Wave_Mat(right,2));
paper_T(2,7) = theta_right;
theta_post_occ = mean(Wave_Mat(post_occ,2));
paper_T(2,5) = theta_post_occ;
theta_broca = mean(Wave_Mat(broca,2));
paper_T(2,3) = theta_broca;
theta_wernick = mean(Wave_Mat(wernick,2));
paper_T(2,1) = theta_wernick;

% alpha

alpha_frontal = mean(Wave_Mat(frontal,3));
paper_T(3,13) = alpha_frontal;
alpha_central = mean(Wave_Mat(central,3));
paper_T(3,11) = alpha_central;
alpha_left = mean(Wave_Mat(left,3));
paper_T(3,9) = alpha_left;
alpha_right = mean(Wave_Mat(right,3));
paper_T(3,7) = alpha_right;
alpha_post_occ = mean(Wave_Mat(post_occ,3));
paper_T(3,5) = alpha_post_occ;
alpha_broca = mean(Wave_Mat(broca,3));
paper_T(3,3) = alpha_broca;
alpha_wernick = mean(Wave_Mat(wernick,3));
paper_T(3,1) = alpha_wernick;

% beta

beta_frontal = mean(Wave_Mat(frontal,4));
paper_T(4,13) = beta_frontal;
beta_central = mean(Wave_Mat(central,4));
paper_T(4,11) = beta_central;
beta_left = mean(Wave_Mat(left,4));
paper_T(4,9) = beta_left;
beta_right = mean(Wave_Mat(right,4));
paper_T(4,7) = beta_right;
beta_post_occ = mean(Wave_Mat(post_occ,4));
paper_T(4,5) = beta_post_occ;
beta_broca = mean(Wave_Mat(broca,4));
paper_T(4,3) = beta_broca;
beta_wernick = mean(Wave_Mat(wernick,4));
paper_T(4,1) = beta_wernick;

% gamma

gamma_frontal = mean(Wave_Mat(frontal,5));
paper_T(5,13) = gamma_frontal;
gamma_central = mean(Wave_Mat(central,5));
paper_T(5,11) = gamma_central;
gamma_left = mean(Wave_Mat(left,5));
paper_T(5,9) = gamma_left;
gamma_right = mean(Wave_Mat(right,4));
paper_T(5,7) = gamma_right;
gamma_post_occ = mean(Wave_Mat(post_occ,5));
paper_T(5,5) = gamma_post_occ;
gamma_broca = mean(Wave_Mat(broca,5));
paper_T(5,3) = gamma_broca;
gamma_wernick = mean(Wave_Mat(wernick,5));
paper_T(5,1) = gamma_wernick;

%% insert screen_T -> Mat

if k==1
    Mat(1:5,:) = paper_T;
elseif k > 1
    i = 7*(k-1);
    Mat(i:i+4,:) = paper_T;
end


