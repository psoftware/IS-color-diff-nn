function [specmasterP, specnoisedP] = gen_copies(spectra, copies)
    % build two matrix: one without noise and another with noise
    specmasterP = zeros(421,1269*copies); % for performance
    specnoisedP = zeros(421,1269*copies); % for performance
    for i_spec = 1:1269
        for sampl = 1:copies
            specmasterP(:, (i_spec-1)*copies + sampl) = spectra(:, i_spec);
            specnoisedP(1:140, (i_spec-1)*copies + sampl) = spectra(1:140, i_spec) + (rand(1,1)*2 - 1)/100;
            specnoisedP(141:280, (i_spec-1)*copies + sampl) = spectra(141:280, i_spec) + (rand(1,1)*2 - 1)/100;
            specnoisedP(281:421, (i_spec-1)*copies + sampl) = spectra(281:421, i_spec) + (rand(1,1)*2 - 1)/100;
        end
    end
end