load("dataset\IS_dataset.mat")

copies = 10;
seed = 27;

% generate couples (master, noisedmaster)
[specmaster, specnoised] = gen_copies(spectra, copies, seed);

% compute lab coordinates for both sets
[labmaster, labnoise] = compute_lab(specmaster, specnoised, copies);

% compute DeltaE
distance = de(labnoise', labmaster')'

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
%[fs, history] = sequentialfs(@fs_net, features, distance', 'cv', 'none', 'opt', opt, 'nfeatures', 1);

% compute best network
%bestfeatures = features(:,fs);

%selected best 10 features
bestfeatures = features(:, [true false false false true false false true false false true false false false false true false false false false false false true false false false false false false false true false true false false false false false true true false false false false false false false false]);

mse = fs_net_final(bestfeatures, distance');
disp(['Mean Squared Error = ', num2str(mse)]);

clear();