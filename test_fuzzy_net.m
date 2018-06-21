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

% compute correctedDeltaE
correctedDistance = compute_corrected_deltaE(labmaster',distance)';
lchmaster = lab2lch(labmaster');
lchnoise = lab2lch(labnoise');

% interactive interface
interactive_colordiff(labmaster', labnoise', correctedDistance'); error('ignorare');

fileID = fopen('detaE.txt','w');
for s=1:1269*copies
        c_de = correctedDistance(s);
        filename = 'png/';
        filename = strcat(filename,num2str(floor(s/10)));
        filename = strcat(filename,'_');
        filename = strcat(filename,num2str(mod(s,10)));
        filename = strcat(filename,'.png');
        %disp(filename);
        %title(num2str(c_de));
        titolo = strcat('de=',num2str(distance(s)));
        titolo = strcat(titolo,' corrDe=');
        titolo = strcat(titolo,num2str(c_de));
        titolo = strcat(titolo,' L=');
        titolo = strcat(titolo,num2str(lchmaster(s,1)));
        titolo = strcat(titolo,' C=');
        titolo = strcat(titolo,num2str(lchmaster(s,2)));
        titolo = strcat(titolo,' h=');
        titolo = strcat(titolo,num2str(lchmaster(s,3)));
        print_diff_lab_to_file(labmaster(:,s)', labnoise(:,s)',titolo,filename);
       % fprintf(fileID,'Orig_deltaE=%f corr_deltaE=%f \n',distance(s+c),c_de);
end