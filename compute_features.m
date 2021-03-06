function features = compute_features(specmasterP, specnoisedP, copies)
    % normalized features
    i = 1;
    features = [];
    features(i,:) = normalize(mean(specmasterP(1:140,:))); i=i+1;
    features(i,:) = normalize(mean(specmasterP(141:280,:))); i=i+1;
    features(i,:) = normalize(mean(specmasterP(281:421,:))); i=i+1;
    features(i,:) = normalize(var(specmasterP(1:140,:))); i=i+1;
    features(i,:) = normalize(var(specmasterP(141:280,:))); i=i+1;
    features(i,:) = normalize(var(specmasterP(281:421,:))); i=i+1;
    features(i,:) = normalize(mode(specmasterP(1:140,:))); i=i+1;
    features(i,:) = normalize(mode(specmasterP(141:280,:))); i=i+1;
    features(i,:) = normalize(mode(specmasterP(281:421,:))); i=i+1;
    features(i,:) = normalize(median(specmasterP(1:140,:))); i=i+1;
    features(i,:) = normalize(median(specmasterP(141:280,:))); i=i+1;
    features(i,:) = normalize(median(specmasterP(281:421,:))); i=i+1;
    features(i,:) = normalize(skewness(specmasterP(1:140,:))); i=i+1;
    features(i,:) = normalize(skewness(specmasterP(141:280,:))); i=i+1;
    features(i,:) = normalize(skewness(specmasterP(281:421,:))); i=i+1;
    [maxYValue1, indexAtMaxY1] = max(specmasterP(1:140,:));
    [maxYValue2, indexAtMaxY2] = max(specmasterP(141:280,:));
    [maxYValue3, indexAtMaxY3] = max(specmasterP(281:421,:));
    features(i,:) = normalize(maxYValue1); i=i+1;
    features(i,:) = normalize(maxYValue2); i=i+1;
    features(i,:) = normalize(maxYValue3); i=i+1;
    features(i,:) = normalize(indexAtMaxY1); i=i+1;
    features(i,:) = normalize(indexAtMaxY2); i=i+1;
    features(i,:) = normalize(indexAtMaxY3); i=i+1;
    [minYValue1, indexAtMinY1] = min(specmasterP(1:140,:)); i=i+1;
    [minYValue2, indexAtMinY2] = min(specmasterP(141:280,:)); i=i+1;
    [minYValue3, indexAtMinY3] = min(specmasterP(281:421,:)); i=i+1;
    features(i,:) = normalize(minYValue1); i=i+1;
    features(i,:) = normalize(minYValue2); i=i+1;
    features(i,:) = normalize(minYValue3); i=i+1;
    features(i,:) = normalize(indexAtMinY1); i=i+1;
    features(i,:) = normalize(indexAtMinY2); i=i+1;
    features(i,:) = normalize(indexAtMinY3); i=i+1;

    features(i,:) = normalize(mean(specnoisedP(1:140,:))); i=i+1;
    features(i,:) = normalize(mean(specnoisedP(141:280,:))); i=i+1;
    features(i,:) = normalize(mean(specnoisedP(281:421,:))); i=i+1;
    features(i,:) = normalize(var(specnoisedP(1:140,:))); i=i+1;
    features(i,:) = normalize(var(specnoisedP(141:280,:))); i=i+1;
    features(i,:) = normalize(var(specnoisedP(281:421,:))); i=i+1;
    features(i,:) = normalize(mode(specnoisedP(1:140,:))); i=i+1;
    features(i,:) = normalize(mode(specnoisedP(141:280,:))); i=i+1;
    features(i,:) = normalize(mode(specnoisedP(281:421,:))); i=i+1;
    features(i,:) = normalize(median(specnoisedP(1:140,:))); i=i+1;
    features(i,:) = normalize(median(specnoisedP(141:280,:))); i=i+1;
    features(i,:) = normalize(median(specnoisedP(281:421,:))); i=i+1;
    features(i,:) = normalize(skewness(specnoisedP(1:140,:))); i=i+1;
    features(i,:) = normalize(skewness(specnoisedP(141:280,:))); i=i+1;
    features(i,:) = normalize(skewness(specnoisedP(281:421,:))); i=i+1;
    [maxYValue1, indexAtMaxY1] = max(specnoisedP(1:140,:));
    [maxYValue2, indexAtMaxY2] = max(specnoisedP(141:280,:));
    [maxYValue3, indexAtMaxY3] = max(specnoisedP(281:421,:));
    features(i,:) = normalize(maxYValue1); i=i+1;
    features(i,:) = normalize(maxYValue2); i=i+1;
    features(i,:) = normalize(maxYValue3); i=i+1;
    features(i,:) = normalize(indexAtMaxY1); i=i+1;
    features(i,:) = normalize(indexAtMaxY2); i=i+1;
    features(i,:) = normalize(indexAtMaxY3); i=i+1;
    [minYValue1, indexAtMinY1] = min(specnoisedP(1:140,:)); i=i+1;
    [minYValue2, indexAtMinY2] = min(specnoisedP(141:280,:)); i=i+1;
    [minYValue3, indexAtMinY3] = min(specnoisedP(281:421,:)); i=i+1;
    features(i,:) = normalize(minYValue1); i=i+1;
    features(i,:) = normalize(minYValue2); i=i+1;
    features(i,:) = normalize(minYValue3); i=i+1;
    features(i,:) = normalize(indexAtMinY1); i=i+1;
    features(i,:) = normalize(indexAtMinY2); i=i+1;
    features(i,:) = normalize(indexAtMinY3); i=i+1;

    % parabola dei minimi quadrati per un pezzetto dello spettro
    pmf0_master = zeros(2,1269*copies); % for performance
    pmf1_master = zeros(2,1269*copies);
    pmf2_master = zeros(2,1269*copies);
    pmf0_noised = zeros(2,1269*copies);
    pmf1_noised = zeros(2,1269*copies);
    pmf2_noised = zeros(2,1269*copies);

    for c = 1:1269*copies
        if mod(c,10) == 1 %ottimizzazione per non calcolare pi� volte la stessa cosa
            pmf0_master(:,c) = polyfit((1:1:140)',specmasterP(1:140,c),1);
            pmf1_master(:,c) = polyfit((141:1:280)',specmasterP(141:280,c),1);
            pmf2_master(:,c) = polyfit((141:1:280)',specmasterP(141:280,c),1);
        else 
            pmf0_master(:,c) = pmf0_master(:,c-1);
            pmf1_master(:,c) = pmf1_master(:,c-1);
            pmf2_master(:,c) = pmf2_master(:,c-1);
        end

        pmf0_noised(:,c) = polyfit((1:1:140)',specnoisedP(1:140,c),1);
        pmf1_noised(:,c) = polyfit((141:1:280)',specnoisedP(141:280,c),1);
        pmf2_noised(:,c) = polyfit((141:1:280)',specnoisedP(141:280,c),1);
    end
    
    %prima parte spettro
    features(i,:) = normalize(pmf0_master(1,:)); i=i+1; %primo coefficiente della parabola
    features(i,:) = normalize(pmf0_master(2,:)); i=i+1; %secondo coefficiente della parabola
    %features(i,:) = normalize(pmf0_master(3,:)); i=i+1; %terzo coefficiente della parabola
    features(i,:) = normalize(pmf0_noised(1,:)); i=i+1; %primo coefficiente della parabola
    features(i,:) = normalize(pmf0_noised(2,:)); i=i+1; %secondo coefficiente della parabola
    %features(i,:) = normalize(pmf0_noised(3,:)); i=i+1; %terzo coefficiente della parabola

    %seconda parte spettro
    features(i,:) = normalize(pmf1_master(1,:)); i=i+1; %primo coefficiente della parabola
    features(i,:) = normalize(pmf1_master(2,:)); i=i+1; %secondo coefficiente della parabola
    %features(i,:) = normalize(pmf1_master(3,:)); i=i+1; %terzo coefficiente della parabola
    features(i,:) = normalize(pmf1_noised(1,:)); i=i+1; %primo coefficiente della parabola
    features(i,:) = normalize(pmf1_noised(2,:)); i=i+1; %secondo coefficiente della parabola
    %features(i,:) = normalize(pmf1_noised(3,:)); i=i+1; %terzo coefficiente della parabola

    %terza parte spettro
    features(i,:) = normalize(pmf2_master(1,:)); i=i+1; %primo coefficiente della parabola
    features(i,:) = normalize(pmf2_master(2,:)); i=i+1; %secondo coefficiente della parabola
    %features(i,:) = normalize(pmf2_master(3,:)); i=i+1; %terzo coefficiente della parabola
    features(i,:) = normalize(pmf2_noised(1,:)); i=i+1; %primo coefficiente della parabola
    features(i,:) = normalize(pmf2_noised(2,:)); i=i+1; %secondo coefficiente della parabola
    %features(i,:) = normalize(pmf2_noised(3,:)); i=i+1; %terzo coefficiente della parabola

    features = features';
end