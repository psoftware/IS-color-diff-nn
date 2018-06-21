clear();

load("dataset\IS_dataset.mat")

copies = 10;
seed = 27;

% generate couples (master, noisedmaster)
[specmaster, specnoised] = gen_copies(spectra, copies, seed);

% compute lab coordinates for both sets
[labmaster, labnoise] = compute_lab(specmaster, specnoised, copies);

% compute DeltaE
distance = de(labnoise', labmaster')';

for s=1:1269
    for c=0:copies-1
        c_de = compute_corrected_deltaE(labmaster(:,s+c)',distance(s+c));
        fprintf(2,'Orig_deltaE=%f corr_deltaE=%f \n',distance(s+c),c_de);
    end
end