function [features, feature_name] = compute_features(specmasterP, specnoisedP, copies)
    % normalized features
    i = 1;
    features = [];
    feature_name = [];
    features(i,:) = normalize(mean(specmasterP(1:70,:))); feature_name{i} = 'master -> mean(1)'; i=i+1;
    features(i,:) = normalize(mean(specmasterP(71:140,:))); feature_name{i} = 'master -> mean(2)'; i=i+1;
    features(i,:) = normalize(mean(specmasterP(141:210,:))); feature_name{i} = 'master -> mean(3)'; i=i+1;
    features(i,:) = normalize(mean(specmasterP(211:280,:))); feature_name{i} = 'master -> mean(4)'; i=i+1;
    features(i,:) = normalize(mean(specmasterP(281:350,:))); feature_name{i} = 'master -> mean(5)'; i=i+1;
    features(i,:) = normalize(mean(specmasterP(351:421,:))); feature_name{i} = 'master -> mean(6)'; i=i+1;
    
    features(i,:) = normalize(var(specmasterP(1:70,:))); feature_name{i} = 'master -> var(1)'; i=i+1;
    features(i,:) = normalize(var(specmasterP(71:140,:))); feature_name{i} = 'master -> var(2)'; i=i+1;
    features(i,:) = normalize(var(specmasterP(141:210,:))); feature_name{i} = 'master -> var(3)'; i=i+1;
    features(i,:) = normalize(var(specmasterP(211:280,:))); feature_name{i} = 'master -> var(4)'; i=i+1;
    features(i,:) = normalize(var(specmasterP(281:350,:))); feature_name{i} = 'master -> var(5)'; i=i+1;
    features(i,:) = normalize(var(specmasterP(351:421,:))); feature_name{i} = 'master -> var(6)'; i=i+1;
    
    features(i,:) = normalize(mode(specmasterP(1:70,:))); feature_name{i} = 'master -> mode(1)'; i=i+1;
    features(i,:) = normalize(mode(specmasterP(71:140,:))); feature_name{i} = 'master -> mode(2)'; i=i+1;
    features(i,:) = normalize(mode(specmasterP(141:210,:))); feature_name{i} = 'master -> mode(3)'; i=i+1;
    features(i,:) = normalize(mode(specmasterP(211:280,:))); feature_name{i} = 'master -> mode(4)'; i=i+1;
    features(i,:) = normalize(mode(specmasterP(281:350,:))); feature_name{i} = 'master -> mode(5)'; i=i+1;
    features(i,:) = normalize(mode(specmasterP(351:421,:))); feature_name{i} = 'master -> mode(6)'; i=i+1;
    
    features(i,:) = normalize(median(specmasterP(1:70,:))); feature_name{i} = 'master -> median(1)'; i=i+1;
    features(i,:) = normalize(median(specmasterP(71:140,:))); feature_name{i} = 'master -> median(2)'; i=i+1;
    features(i,:) = normalize(median(specmasterP(141:210,:))); feature_name{i} = 'master -> median(3)'; i=i+1;
    features(i,:) = normalize(median(specmasterP(211:280,:))); feature_name{i} = 'master -> median(4)'; i=i+1;
    features(i,:) = normalize(median(specmasterP(281:350,:))); feature_name{i} = 'master -> median(5)'; i=i+1;
    features(i,:) = normalize(median(specmasterP(351:421,:))); feature_name{i} = 'master -> median(6)'; i=i+1;
    
    features(i,:) = normalize(skewness(specmasterP(1:70,:))); feature_name{i} = 'master -> skewness(1)'; i=i+1;
    features(i,:) = normalize(skewness(specmasterP(71:140,:))); feature_name{i} = 'master -> skewness(2)'; i=i+1;
    features(i,:) = normalize(skewness(specmasterP(141:210,:))); feature_name{i} = 'master -> skewness(3)'; i=i+1;
    features(i,:) = normalize(skewness(specmasterP(211:280,:))); feature_name{i} = 'master -> skewness(4)'; i=i+1;
    features(i,:) = normalize(skewness(specmasterP(281:350,:))); feature_name{i} = 'master -> skewness(5)'; i=i+1;
    features(i,:) = normalize(skewness(specmasterP(351:421,:))); feature_name{i} = 'master -> skewness(6)'; i=i+1;
    
    
    [maxYValue1, indexAtMaxY1] = max(specmasterP(1:140,:));
    [maxYValue2, indexAtMaxY2] = max(specmasterP(141:280,:));
    [maxYValue3, indexAtMaxY3] = max(specmasterP(281:421,:));
    features(i,:) = normalize(maxYValue1); feature_name{i} = 'master -> maxYValue(1)'; i=i+1;
    features(i,:) = normalize(maxYValue2); feature_name{i} = 'master -> maxYValue(2)'; i=i+1;
    features(i,:) = normalize(maxYValue3); feature_name{i} = 'master -> maxYValue(3)'; i=i+1;
    features(i,:) = normalize(indexAtMaxY1); feature_name{i} = 'master -> indexAtMaxY(1)'; i=i+1;
    features(i,:) = normalize(indexAtMaxY2); feature_name{i} = 'master -> indexAtMaxY(2)'; i=i+1;
    features(i,:) = normalize(indexAtMaxY3); feature_name{i} = 'master -> indexAtMaxY(3)'; i=i+1;
    [minYValue1, indexAtMinY1] = min(specmasterP(1:140,:));
    [minYValue2, indexAtMinY2] = min(specmasterP(141:280,:));
    [minYValue3, indexAtMinY3] = min(specmasterP(281:421,:));
    features(i,:) = normalize(minYValue1); feature_name{i} = 'master -> minYValue(1)'; i=i+1;
    features(i,:) = normalize(minYValue2); feature_name{i} = 'master -> minYValue(2)'; i=i+1;
    features(i,:) = normalize(minYValue3); feature_name{i} = 'master -> minYValue(3)'; i=i+1;
    features(i,:) = normalize(indexAtMinY1); feature_name{i} = 'master -> indexAtMinY(1)'; i=i+1;
    features(i,:) = normalize(indexAtMinY2); feature_name{i} = 'master -> indexAtMinY(2)'; i=i+1;
    features(i,:) = normalize(indexAtMinY3); feature_name{i} = 'master -> indexAtMinY(3)'; i=i+1;

    features(i,:) = normalize(mean(specnoisedP(1:70,:))); feature_name{i} = 'copy -> mean(1)'; i=i+1;
    features(i,:) = normalize(mean(specnoisedP(71:140,:))); feature_name{i} = 'copy -> mean(2)'; i=i+1;
    features(i,:) = normalize(mean(specnoisedP(141:210,:))); feature_name{i} = 'copy -> mean(3)'; i=i+1;
    features(i,:) = normalize(mean(specnoisedP(211:280,:))); feature_name{i} = 'copy -> mean(4)'; i=i+1;
    features(i,:) = normalize(mean(specnoisedP(281:350,:))); feature_name{i} = 'copy -> mean(5)'; i=i+1;
    features(i,:) = normalize(mean(specnoisedP(351:421,:))); feature_name{i} = 'copy -> mean(6)'; i=i+1;
    
    features(i,:) = normalize(var(specnoisedP(1:70,:))); feature_name{i} = 'copy -> var(1)'; i=i+1;
    features(i,:) = normalize(var(specnoisedP(71:140,:))); feature_name{i} = 'copy -> var(2)'; i=i+1;
    features(i,:) = normalize(var(specnoisedP(141:210,:))); feature_name{i} = 'copy -> var(3)'; i=i+1;
    features(i,:) = normalize(var(specnoisedP(211:280,:))); feature_name{i} = 'copy -> var(4)'; i=i+1;
    features(i,:) = normalize(var(specnoisedP(281:350,:))); feature_name{i} = 'copy -> var(5)'; i=i+1;
    features(i,:) = normalize(var(specnoisedP(351:421,:))); feature_name{i} = 'copy -> var(6)'; i=i+1;
    
    features(i,:) = normalize(mode(specnoisedP(1:70,:))); feature_name{i} = 'copy -> mode(1)'; i=i+1;
    features(i,:) = normalize(mode(specnoisedP(71:140,:))); feature_name{i} = 'copy -> mode(2)'; i=i+1;
    features(i,:) = normalize(mode(specnoisedP(141:210,:))); feature_name{i} = 'copy -> mode(3)'; i=i+1;
    features(i,:) = normalize(mode(specnoisedP(211:280,:))); feature_name{i} = 'copy -> mode(4)'; i=i+1;
    features(i,:) = normalize(mode(specnoisedP(281:350,:))); feature_name{i} = 'copy -> mode(5)'; i=i+1;
    features(i,:) = normalize(mode(specnoisedP(351:421,:))); feature_name{i} = 'copy -> mode(6)'; i=i+1;
    
    features(i,:) = normalize(median(specnoisedP(1:70,:))); feature_name{i} = 'copy -> median(1)'; i=i+1;
    features(i,:) = normalize(median(specnoisedP(71:140,:))); feature_name{i} = 'copy -> median(2)'; i=i+1;
    features(i,:) = normalize(median(specnoisedP(141:210,:))); feature_name{i} = 'copy -> median(3)'; i=i+1;
    features(i,:) = normalize(median(specnoisedP(211:280,:))); feature_name{i} = 'copy -> median(4)'; i=i+1;
    features(i,:) = normalize(median(specnoisedP(281:350,:))); feature_name{i} = 'copy -> median(5)'; i=i+1;
    features(i,:) = normalize(median(specnoisedP(351:421,:))); feature_name{i} = 'copy -> median(6)'; i=i+1;
    
    features(i,:) = normalize(skewness(specnoisedP(1:70,:))); feature_name{i} = 'copy -> skewness(1)'; i=i+1;
    features(i,:) = normalize(skewness(specnoisedP(71:140,:))); feature_name{i} = 'copy -> skewness(2)'; i=i+1;
    features(i,:) = normalize(skewness(specnoisedP(141:210,:))); feature_name{i} = 'copy -> skewness(3)'; i=i+1;
    features(i,:) = normalize(skewness(specnoisedP(211:280,:))); feature_name{i} = 'copy -> skewness(4)'; i=i+1;
    features(i,:) = normalize(skewness(specnoisedP(281:350,:))); feature_name{i} = 'copy -> skewness(5)'; i=i+1;
    features(i,:) = normalize(skewness(specnoisedP(351:421,:))); feature_name{i} = 'copy -> skewness(6)'; i=i+1;
    
    [maxYValue1, indexAtMaxY1] = max(specnoisedP(1:140,:));
    [maxYValue2, indexAtMaxY2] = max(specnoisedP(141:280,:));
    [maxYValue3, indexAtMaxY3] = max(specnoisedP(281:421,:));
    features(i,:) = normalize(maxYValue1); feature_name{i} = 'copy -> maxYValue(1)'; i=i+1;
    features(i,:) = normalize(maxYValue2); feature_name{i} = 'copy -> maxYValue(2)'; i=i+1;
    features(i,:) = normalize(maxYValue3); feature_name{i} = 'copy -> maxYValue(3)'; i=i+1;
    features(i,:) = normalize(indexAtMaxY1); feature_name{i} = 'copy -> indexAtMaxY(1)'; i=i+1;
    features(i,:) = normalize(indexAtMaxY2); feature_name{i} = 'copy -> indexAtMaxY(2)'; i=i+1;
    features(i,:) = normalize(indexAtMaxY3); feature_name{i} = 'copy -> indexAtMaxY(3)'; i=i+1;
    
    [minYValue1, indexAtMinY1] = min(specnoisedP(1:140,:));
    [minYValue2, indexAtMinY2] = min(specnoisedP(141:280,:));
    [minYValue3, indexAtMinY3] = min(specnoisedP(281:421,:));
    features(i,:) = normalize(minYValue1); feature_name{i} = 'copy -> minYValue(1)'; i=i+1;
    features(i,:) = normalize(minYValue2); feature_name{i} = 'copy -> minYValue(2)'; i=i+1;
    features(i,:) = normalize(minYValue3); feature_name{i} = 'copy -> minYValue(3)'; i=i+1;
    features(i,:) = normalize(indexAtMinY1); feature_name{i} = 'copy -> indexAtMinY(1)'; i=i+1;
    features(i,:) = normalize(indexAtMinY2); feature_name{i} = 'copy -> indexAtMinY(2)'; i=i+1;
    features(i,:) = normalize(indexAtMinY3); feature_name{i} = 'copy -> indexAtMinY(3)'; i=i+1;
    
    features = features';
end