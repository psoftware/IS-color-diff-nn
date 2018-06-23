function [specmasterP, specnoisedP] = gen_copies(spectra, copies, seed)
    oldseed = rng(seed);
    % build two matrix: one without noise and another with noise
    specmasterP = zeros(421,1269*copies); % for performance
    specnoisedP = zeros(421,1269*copies); % for performance
    for i_spec = 1:1269
        for sampl = 1:copies
            specmasterP(:, (i_spec-1)*copies + sampl) = spectra(:, i_spec);

            if( sampl <= floor(copies/2) )
                %DIVIDE BY 1
                %specnoisedP(1:421, (i_spec-1)*copies + sampl) = spectra(1:421, i_spec) + (rand(1,1)*2 - 1)/75;
                specnoisedP(:, (i_spec-1)*copies + sampl) = spectra(:,i_spec) * random('unif',0.95,1.12); 
            elseif ( sampl < copies )
                %DIVIDE BY 3
                specnoisedP(1:146, (i_spec-1)*copies + sampl) = spectra(1:146, i_spec) * random('unif',0.95,1.12);
                specnoisedP(147:300, (i_spec-1)*copies + sampl) = spectra(147:300, i_spec) * random('unif',0.95,1.12);
                specnoisedP(301:421, (i_spec-1)*copies + sampl) = spectra(301:421, i_spec) * random('unif',0.95,1.12);  
            else 
                %in the last sample the noise is bigger
                specnoisedP(1:146, (i_spec-1)*copies + sampl) = spectra(1:146, i_spec) * random('unif',1,1.15);
                specnoisedP(147:300, (i_spec-1)*copies + sampl) = spectra(147:300, i_spec) * random('unif',1,1.15);
                specnoisedP(301:421, (i_spec-1)*copies + sampl) = spectra(301:421, i_spec) * random('unif',1,1.15);  
            end 
        end
    end

    rng(oldseed);
end