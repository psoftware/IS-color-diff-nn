function [specmasterP, specnoisedP] = gen_copies(spectra, copies, seed)
    oldseed = rng(seed);
    % build two matrix: one without noise and another with noise
    specmasterP = zeros(421,1269*copies); % for performance
    specnoisedP = zeros(421,1269*copies); % for performance
    for i_spec = 1:1269
        for sampl = 1:copies
            specmasterP(:, (i_spec-1)*copies + sampl) = spectra(:, i_spec);

            % DIVIDE BY 5
            specnoisedP(1:84, (i_spec-1)*copies + sampl) = spectra(1:84, i_spec) + (rand(1,1)*2 - 1)/75;
            specnoisedP(85:168, (i_spec-1)*copies + sampl) = spectra(85:168, i_spec) + (rand(1,1)*2 - 1)/75;
            specnoisedP(169:252, (i_spec-1)*copies + sampl) = spectra(169:252, i_spec) + (rand(1,1)*2 - 1)/75;
            specnoisedP(253:336, (i_spec-1)*copies + sampl) = spectra(253:336, i_spec) + (rand(1,1)*2 - 1)/75;
            specnoisedP(337:421, (i_spec-1)*copies + sampl) = spectra(337:421, i_spec) + (rand(1,1)*2 - 1)/75;

            % DIVIDE BY 7
            %specnoisedP(1:60, (i_spec-1)*copies + sampl) = spectra(1:60, i_spec) + (rand(1,1)*2 - 1)/100;
            %specnoisedP(61:120, (i_spec-1)*copies + sampl) = spectra(61:120, i_spec) + (rand(1,1)*2 - 1)/100;
            %specnoisedP(121:180, (i_spec-1)*copies + sampl) = spectra(121:180, i_spec) + (rand(1,1)*2 - 1)/100;
            %specnoisedP(181:240, (i_spec-1)*copies + sampl) = spectra(181:240, i_spec) + (rand(1,1)*2 - 1)/100;
            %specnoisedP(241:300, (i_spec-1)*copies + sampl) = spectra(241:300, i_spec) + (rand(1,1)*2 - 1)/100;
            %specnoisedP(301:360, (i_spec-1)*copies + sampl) = spectra(301:360, i_spec) + (rand(1,1)*2 - 1)/100;
            %specnoisedP(361:421, (i_spec-1)*copies + sampl) = spectra(361:421, i_spec) + (rand(1,1)*2 - 1)/100;
        end
    end

    rng(oldseed);
end