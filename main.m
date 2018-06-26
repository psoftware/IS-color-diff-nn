% clear to avoid past workspace issues
clear();

% load spectra, coordinates from the given dataset
load('dataset\IS_dataset.mat')

% project parameters
copies = 10;
seed = 20;

% generate couples (master, noisedmaster)
[specmaster, specnoised] = gen_copies(spectra, copies, seed);

% compute lab coordinates for both sets
[labmaster, labnoise] = compute_lab(specmaster, specnoised, copies);

% compute DeltaE
distance = de(labnoise', labmaster')';
distance_adj = compute_corrected_deltaE(labmaster', distance);

% distance = sqrt( (lab2(1)-lab1(1))^2 + (lab2(2)-lab1(2))^2 + (lab2(3)-lab1(3))^2 )
[features, feature_name] = compute_features(specmaster, specnoised, copies);

% select best features using fs_net
opt = statset('display', 'iter');
%[fs, history] = sequentialfs(@fs_net, features, distance_adj, 'cv', 'none', 'opt', opt, 'nfeatures', 12);

% some experiments
%12 features - 5 range extraction (0.88 di R)
%fs = boolean([0   0   0   0   0   1   0   0   1   0   1   0   0   0   0   1   0   0   0   0   0   1   0   0   0   0   0   0   0   0   0   0 1   1   0   0   0   1   0   0   0   0   1   1   0   0   1   1   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0 0   0]);
%12 features, 10 neurons - 6 range extraction
%fs = boolean([0   0   1   0   0   1   0   0   1   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   1   0   0   0   0   0   1   1   0   0   0   0   0   0   1   0   0   0   0   0   0   0   0   0   1   0   0   0   0   1   0   1   0   0   0   1   0   0   0   0   0   0   0   0   0   0   0   0   1   0   0   0   0   0]);
%10 features, 10 neurons - 6 range extraction
%fs = boolean([0   0   1   0   0   0   0   0   1   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   1   0   0   0   0   0   1   1   0   0   0   0   0   0   1   0   0   0   0   0   0   0   0   0   1   0   0   0   0   1   0   0   0   0   0   1   0   0   0   0   0   0   0   0   0   0   0   0   1   0   0   0   0   0]);
%9 features, 10 neurons - 6 range extraction
%fs = boolean([0   0   1   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   1   0   0   0   0   0   1   1   0   0   0   0   0   0   1   0   0   0   0   0   0   0   0   0   1   0   0   0   0   1   0   0   0   0   0   1   0   0   0   0   0   0   0   0   0   0   0   0   1   0   0   0   0   0]);
%8 features, 10 neurons - 6 range extraction
%fs = boolean([0   0   1   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   1   0   0   0   0   0   1   1   0   0   0   0   0   0   1   0   0   0   0   0   0   0   0   0   1   0   0   0   0   1   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   1   0   0   0   0   0]);

% final selected features
%12 features, 10 neurons - 6 range extraction
fs = boolean([0   0   0   0   0   0   1   0   0   0   0   0   0   0   0   0   0   0   1   0   1   0   0   0   0   0   0   0   1   0   0   1 0   1   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   1   0   1   0 0   0   1   0   0   0   1   0   0   1   0   0   1   0   0   0   0   0   0   0]);

% get features selected by sequentialfs
bestfeatures = features(:, fs);
bestfeature_name = feature_name(:, fs);

% print selected feature names
disp('# Selected features:');
disp(strjoin(bestfeature_name, '\n'));
disp('');

% train a new network using selected features
[mse, net] = fs_net_final(bestfeatures, distance_adj);