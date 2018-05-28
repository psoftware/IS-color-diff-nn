function [corrected_deltaE] = compute_corrected_deltaE(labmaster, euclid_dist)
    fis = readfis('fuzzy\deltae-correction.fis');
    lchmaster = lab2lch(labmaster);
    fis_input = lchmaster;
    fis_input(:,4) = euclid_dist;
    corrected_deltaE = evalfis(fis_input, fis);
end