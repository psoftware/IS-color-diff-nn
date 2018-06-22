clear();

load('dataset\IS_dataset.mat')

copies = 10;
seed = 27;

% generate couples (master, noisedmaster)
[specmaster, specnoised] = gen_copies(spectra, copies, seed);

% compute lab coordinates for both sets
[labmaster, labnoise] = compute_lab(specmaster, specnoised, copies);

% compute DeltaE
distance = de(labnoise', labmaster')';
distance_adj = compute_corrected_deltaE(labmaster', distance);

% figure('Position', [100, 100, 1000, 400]);
% subplot(1,2,1)
% plot(spec)
% yyaxis right
% plot(specnoised)

% lab1 = roo2lab(spec'.*speccoeff, 'D65/2', 380:1:800)
% lab2 = roo2lab(specnoised'.*speccoeff, 'D65/2', 380:1:800)
% subplot(1,2,2)
% print_diff_lab(lab1, lab2);

% distance = sqrt( (lab2(1)-lab1(1))^2 + (lab2(2)-lab1(2))^2 + (lab2(3)-lab1(3))^2 )

features = compute_features(specmaster, specnoised, copies);

opt = statset('display', 'iter');
%[fs, history] = sequentialfs(@fs_net, features, distance', 'cv', 'none', 'opt', opt, 'nfeatures', 5);
[fs, history] = sequentialfs(@fs_net, features, distance_adj, 'cv', 'none', 'opt', opt, 'nfeatures', 12);

% compute best network
bestfeatures = features(:,fs);

% 10 features, 10 neurons (0.84)
%bestfeatures = features(:, boolean([0   0   0   0   0   0   1   1   0   0   0   0   0   1   0   0   1   0   0   0   0   0   0   0   0   0   0   1   1   0   0  0  0   0   1   0   0   1   0   1   0   1]));
% 12 features, 10 neurons (0.93) (others,skewness,sum,NO regression)
%bestfeatures = features(:, boolean([1   0   0   0   0   0   1   1   1   0   1   0   0   0   0   1   0   0   0   0   0   0   0   0   0   0   0   1   1   0   0   1   0   0   1   0   1   0   0   1   0   0]));
% 12 features, 10 neurons (0.963, 0.135) (others,skewness,sum,regression)
%bestfeatures = features(:, boolean([0   1   0   0   0   0   1   1   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   1   1   0   0   0   1   0   0   0   0   0   0   1   0   0   1   0   1   0   1   0   0   1   0   0   1   0]));

%10 best - 10 neurons - deAdju
%bestfeatures = features(:,[true true false false false false false false false false false false false false false false false false false false false false false false true false false true false false true true false false false false false false false false false false false false false false false false false false false false false false true false false false false false false false false false false false false true true true false false]);
%bestfeatures = features(:, [false false false false false false false false false false false false false false false false false false false false false false false false false true false false false false false false false false false false false false false false false false false false false false false false false false false false false false false true false true false false false false false false false true true false false false false false]);

% 12 features, 10 neurons (0.86)
%bestfeatures = features(:, boolean([1   0   0   0   0   0   0   0   0   1   0   0   0   0   0   0   1   0   0   0   0   0   0   0   0   0   0   0   0   0   1   1   1   0   0   0   0   0   0   1   0   0   0   0   0   0   0   0   0   1   0   0   0   0   0   0   0   0   0   0   0   0   0   0   1   1   0   0   1   0   0   1]));

%mse = fs_net_final(bestfeatures, distance');
mse = fs_net_final(bestfeatures, distance_adj);
disp(['Mean Squared Error = ', num2str(mse)]);