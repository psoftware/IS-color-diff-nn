function [labmasterP, labnoiseP] = compute_lab(specmaster, specnoised, copies)    
    spec_coeff = 100;
    labmasterP = zeros(3,1269*copies); % for performance
    labnoiseP = zeros(3,1269*copies); % for performance

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
        labmasterP(:,chunkstart:chunkend) = roo2lab(specmaster(:,chunkstart:chunkend)'.*spec_coeff, 'D65/2', 380:1:800)';
        labnoiseP(:,chunkstart:chunkend) = roo2lab(specnoised(:,chunkstart:chunkend)'.*spec_coeff, 'D65/2', 380:1:800)';
        chunkstart = chunkstart + chunksize;
    end
end