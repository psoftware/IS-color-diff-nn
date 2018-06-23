function [corrected_deltaE] = compute_corrected_deltaE(labmaster, euclid_dist)
    fis = readfis('deltae-correction.fis');

    lchmaster = lab2lch(labmaster);
    % C must be converted into C% because its range depends on L value
    % we use an ellipse equation to compute Cmax for the current L value
    lchmaster(:,2) = lchmaster(:,2).*100./compute_Cmax(lchmaster(:,1));

    fis_input = lchmaster;
    fis_input(:,4) = euclid_dist;
    corrected_deltaE = evalfis(fis_input, fis);
end