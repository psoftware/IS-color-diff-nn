clear();

load('dataset\IS_dataset.mat')

copies = 10;
seed = 20;

% generate couples (master, noisedmaster)
[specmaster, specnoised] = gen_copies(spectra, copies, seed);

% compute lab coordinates for both sets
[labmaster, labnoise] = compute_lab(specmaster, specnoised, copies);

% compute DeltaE
distance = de(labnoise', labmaster')';
distance_adj = compute_corrected_deltaE(labmaster', distance);

% lab1 = roo2lab(spec'.*speccoeff, 'D65/2', 380:1:800)
% lab2 = roo2lab(specnoised'.*speccoeff, 'D65/2', 380:1:800)
% subplot(1,2,2)
% print_diff_lab(lab1, lab2);

% distance = sqrt( (lab2(1)-lab1(1))^2 + (lab2(2)-lab1(2))^2 + (lab2(3)-lab1(3))^2 )
[features, feature_name] = compute_features(specmaster, specnoised, copies);

opt = statset('display', 'iter');
%[fs, history] = sequentialfs(@fs_net, features, distance_adj, 'cv', 'none', 'opt', opt, 'nfeatures', 12);


%12 features 15 neurons fuzzy, copie disturbate con rumore a media non nulla
%fs = boolean([1   0   0   0   0   1   0   0   0   1   0   0   0   0   0   0   1   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   1   0   0   0   1   0   0   0   1   0   0   1   0   0   1   0   0   0   0   0   0   0   0   0   0   0   1   1   0   1   0   0   0   0]);

%12 features 10 neurons fuzzy, copie disturbate con rumore a media nulla
%fs = boolean([0   0   0   0   0   0   0   0   0   0   1   0   0   0   0   1   1   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0 0   0   0   1   0   1   0   0   0   0   1   1   1   0   1   0   0   0   0   0   1   0   0   0   0   0   0   0   0   1   0   1]);

%12 features - 5 fasce (0.88 di R)
%fs = boolean([0   0   0   0   0   1   0   0   1   0   1   0   0   0   0   1   0   0   0   0   0   1   0   0   0   0   0   0   0   0   0   0 1   1   0   0   0   1   0   0   0   0   1   1   0   0   1   1   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0 0   0]);

%12 features - new mean added
%fs = boolean([1   0   1   1   0   0   0   0   0   0   0   1   0   0   0   0   0   0   1   0   0   0   0   1   0   0   0   0   0   1   0   0 1   0   0   0   0   0   0   0   1   0   0   0   0   1   0   1   0   0   0   0   1   0   0   0   0   0]);

%12 features - new mean/median/skewness/mode added
fs = boolean([0   1   0   0   0   0   0   0   0   0   0   0   1   0   0   0   0   0   1   1   0   0   1   0   0   0   1   0   0   0   0   1  0   0   0   0   0   0   1   0   0   0   0   1   0   0   0   1   0   0   0   0   0   0   0   0   0   0   0   1   0   0   0   1 0   0   0   0   0   0   0   0   0   0]);
%fs = boolean([0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   1   0   1   0   0   0   0   1   0   0   0   1   1 0   0   0   0   0   0   0   0   0   0   0   0   0   1   0   1   0   0   0   0   0   0   1   1   1   0   0   0   0   0   0   1  0   0   0   0   0   0   0   0   1   0]);
bestfeatures = features(:, fs);
bestfeature_name = feature_name(:, fs);

disp('# Selected features:');
disp(strjoin(bestfeature_name, '\n'));
disp('');

[mse, net] = fs_net_final(bestfeatures, distance_adj);

