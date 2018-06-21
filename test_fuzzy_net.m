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

fileID = fopen('detaE.txt','w');
for s=1:1269*copies
        c_de = compute_corrected_deltaE(labmaster(:,s)',distance(s));
        filename = 'png/';
        filename = strcat(filename,num2str(floor(s/10)));
        filename = strcat(filename,'_');
        filename = strcat(filename,num2str(mod(s,10)));
        filename = strcat(filename,'.png');
        %disp(filename);
        print_diff_lab_to_file(labmaster(:,s)', labnoise(:,s)',filename);
       % fprintf(fileID,'Orig_deltaE=%f corr_deltaE=%f \n',distance(s+c),c_de);
end