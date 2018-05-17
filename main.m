load("dataset\IS_dataset.mat")

% build two matrix: one without noise and another with noise
copies = 10;
specmaster = zeros(421,1269*copies); % for performance
specnoised = zeros(421,1269*copies); % for performance
for i_spec = 1:1269
    for sampl = 1:copies
        specmaster(:, (i_spec-1)*copies + sampl) = spectra(:, i_spec);
        specnoised(1:140, (i_spec-1)*copies + sampl) = spectra(1:140, i_spec) + (rand(1,1)*2 - 1)/100;
        specnoised(141:280, (i_spec-1)*copies + sampl) = spectra(141:280, i_spec) + (rand(1,1)*2 - 1)/100;
        specnoised(281:421, (i_spec-1)*copies + sampl) = spectra(281:421, i_spec) + (rand(1,1)*2 - 1)/100;
    end
end

spec_coeff = 100;
labmaster = zeros(3,1269*copies); % for performance
labnoise = zeros(3,1269*copies); % for performance

chunksize = 2500;
chunkstart = 1;
chunkend = 1;
chunkstop = false;
while not(chunkstop)
    if(chunkstart + chunksize > 1269*copies)
        chunkend = chunkstart+ 1269*copies - chunkstart;
        chunkstop = true;
    else
        chunkend = chunkstart + chunksize;
    end
    labmaster(:,chunkstart:chunkend) = roo2lab(specmaster(:,chunkstart:chunkend)'.*spec_coeff, 'D65/2', 380:1:800)';
    labnoise(:,chunkstart:chunkend) = roo2lab(specnoised(:,chunkstart:chunkend)'.*spec_coeff, 'D65/2', 380:1:800)';
    chunkstart = chunkstart + chunksize;
end

% distance = sqrt( power(labnoise(1,:)-labmaster(1,:),2) + power(labnoise(2,:)-labmaster(2,:),2) + power(labnoise(3,:)-labmaster(3,:),2) )
distance = de(labnoise', labmaster')'

% figure('Position', [100, 100, 1000, 400]);
% subplot(1,2,1)
% plot(spec)
% yyaxis right
% plot(specnoised)

% speccoeff = illuminant('d65/2', 380:1:800)


% lab1 = roo2lab(spec'.*speccoeff, 'D65/2', 380:1:800)
% lab2 = roo2lab(specnoised'.*speccoeff, 'D65/2', 380:1:800)
% subplot(1,2,2)
% print_diff_lab(lab1, lab2);

% distance = sqrt( (lab2(1)-lab1(1))^2 + (lab2(2)-lab1(2))^2 + (lab2(3)-lab1(3))^2 )
% recalculated_lab = roo2lab(spectra'.*speccoeff, 'D65/2', 380:1:800)'

% normalized features
[maxYValue, indexAtMaxY] = max(specmaster);
i = 1;
features = [];
features(i,:) = normalize(mean(specmaster(1:140,:))); i=i+1;
features(i,:) = normalize(mean(specmaster(141:280,:))); i=i+1;
features(i,:) = normalize(mean(specmaster(281:421,:))); i=i+1;
features(i,:) = normalize(var(specmaster(1:140,:))); i=i+1;
features(i,:) = normalize(var(specmaster(141:280,:))); i=i+1;
features(i,:) = normalize(var(specmaster(281:421,:))); i=i+1;
features(i,:) = normalize(min(specmaster(1:140,:))); i=i+1;
features(i,:) = normalize(min(specmaster(141:280,:))); i=i+1;
features(i,:) = normalize(min(specmaster(281:421,:))); i=i+1;
[maxYValue1, indexAtMaxY1] = max(specmaster(1:140,:));
[maxYValue2, indexAtMaxY2] = max(specmaster(141:280,:));
[maxYValue3, indexAtMaxY3] = max(specmaster(281:421,:));
features(i,:) = normalize(maxYValue1); i=i+1;
features(i,:) = normalize(maxYValue2); i=i+1;
features(i,:) = normalize(maxYValue3); i=i+1;
features(i,:) = normalize(indexAtMaxY1); i=i+1;
features(i,:) = normalize(indexAtMaxY2); i=i+1;
features(i,:) = normalize(indexAtMaxY3); i=i+1;

features(i,:) = normalize(mean(specnoised(1:140,:))); i=i+1;
features(i,:) = normalize(mean(specnoised(141:280,:))); i=i+1;
features(i,:) = normalize(mean(specnoised(281:421,:))); i=i+1;
features(i,:) = normalize(var(specnoised(1:140,:))); i=i+1;
features(i,:) = normalize(var(specnoised(141:280,:))); i=i+1;
features(i,:) = normalize(var(specnoised(281:421,:))); i=i+1;
features(i,:) = normalize(min(specnoised(1:140,:))); i=i+1;
features(i,:) = normalize(min(specnoised(141:280,:))); i=i+1;
features(i,:) = normalize(min(specnoised(281:421,:))); i=i+1;
[maxYValue1, indexAtMaxY1] = max(specnoised(1:140,:));
[maxYValue2, indexAtMaxY2] = max(specnoised(141:280,:));
[maxYValue3, indexAtMaxY3] = max(specnoised(281:421,:));
features(i,:) = normalize(maxYValue1); i=i+1;
features(i,:) = normalize(maxYValue2); i=i+1;
features(i,:) = normalize(maxYValue3); i=i+1;
features(i,:) = normalize(indexAtMaxY1); i=i+1;
features(i,:) = normalize(indexAtMaxY2); i=i+1;
features(i,:) = normalize(indexAtMaxY3); i=i+1;

% parabola dei minimi quadrati per un pezzetto dello spettro
pmf0_master = zeros(3,1269*copies); % for performance
pmf1_master = zeros(3,1269*copies);
pmf2_master = zeros(3,1269*copies);
pmf0_noised = zeros(3,1269*copies);
pmf1_noised = zeros(3,1269*copies);
pmf2_noised = zeros(3,1269*copies);

for c = 1:1269*copies
    if mod(c,10) == 1 %ottimizzazione per non calcolare più volte la stessa cosa
        pmf0_master(:,c) = polyfit((1:1:140)',specmaster(1:140,c),2);
        pmf1_master(:,c) = polyfit((141:1:280)',specmaster(141:280,c),2);
        pmf2_master(:,c) = polyfit((141:1:280)',specmaster(141:280,c),2);
    else
        pmf0_master(:,c) = pmf0_master(:,c-1);
        pmf1_master(:,c) = pmf1_master(:,c-1);
        pmf2_master(:,c) = pmf2_master(:,c-1);
    end
    
    pmf0_noised(:,c) = polyfit((1:1:140)',specnoised(1:140,c),2);
    pmf1_noised(:,c) = polyfit((141:1:280)',specnoised(141:280,c),2);
    pmf2_noised(:,c) = polyfit((141:1:280)',specnoised(141:280,c),2);
end
%prima parte spettro
features(i,:) = pmf0_master(1,:); i=i+1; %primo coefficiente della parabola
features(i,:) = pmf0_master(2,:); i=i+1; %secondo coefficiente della parabola
features(i,:) = pmf0_master(3,:); i=i+1; %terzo coefficiente della parabola
features(i,:) = pmf0_noised(1,:); i=i+1; %primo coefficiente della parabola
features(i,:) = pmf0_noised(2,:); i=i+1; %secondo coefficiente della parabola
features(i,:) = pmf0_noised(3,:); i=i+1; %terzo coefficiente della parabola

%seconda parte spettro
features(i,:) = pmf1_master(1,:); i=i+1; %primo coefficiente della parabola
features(i,:) = pmf1_master(2,:); i=i+1; %secondo coefficiente della parabola
features(i,:) = pmf1_master(3,:); i=i+1; %terzo coefficiente della parabola
features(i,:) = pmf1_noised(1,:); i=i+1; %primo coefficiente della parabola
features(i,:) = pmf1_noised(2,:); i=i+1; %secondo coefficiente della parabola
features(i,:) = pmf1_noised(3,:); i=i+1; %terzo coefficiente della parabola

%terza parte spettro
features(i,:) = pmf2_master(1,:); i=i+1; %primo coefficiente della parabola
features(i,:) = pmf2_master(2,:); i=i+1; %secondo coefficiente della parabola
features(i,:) = pmf2_master(3,:); i=i+1; %terzo coefficiente della parabola
features(i,:) = pmf2_noised(1,:); i=i+1; %primo coefficiente della parabola
features(i,:) = pmf2_noised(2,:); i=i+1; %secondo coefficiente della parabola
features(i,:) = pmf2_noised(3,:); i=i+1; %terzo coefficiente della parabola

features = features';

% spectra, features
% x = randn(1261,5);
% color diff results
% t = randn(1261,1);

opt = statset('display', 'iter');
%[fs, history] = sequentialfs(@fs_net, features, distance', 'cv', 'none', 'opt', opt, 'nfeatures', 8);

% compute best network
%bestfeatures = features(:,fs);

bestfeatures = features(:,[true false false false false false false true false false false false false false false true false false false false false true true false false true false false false false false false false false false true false false false false false false false false true false false false]);


mse = fs_net_final(bestfeatures, distance');
disp(['Mean Squared Error = ', num2str(mse)]);