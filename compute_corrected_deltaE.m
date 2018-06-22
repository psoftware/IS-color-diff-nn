function [corrected_deltaE] = compute_corrected_deltaE(labmaster, euclid_dist)
    fis = readfis('fuzzy\deltae-correction-2.fis');

    lchmaster = lab2lch(labmaster);
    % C must be converted into C% because its range depends on L value
    % we use an ellipse equation to compute Cmax for the current L value
    cmaxfun = @(L) 127*sqrt(1-power((L-50),2)/50^2);
    lchmaster(:,2) = lchmaster(:,2).*100./cmaxfun(lchmaster(:,1));

    fis_input = lchmaster;
    fis_input(:,4) = euclid_dist;
    corrected_deltaE = evalfis(fis_input, fis);
end