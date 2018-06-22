clear();

load('dataset\IS_dataset.mat')

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
%interactive_colordiff(labmaster', labnoise', correctedDistance'); error('ignorare');

labmaster = labmaster';
labnoise = labnoise';
correctedDistance = correctedDistance';

 rgbmaster = lab2rgb(labmaster)*255;
rgbcopies = lab2rgb(labnoise)*255;
lchmaster = lab2lch(labmaster);
distance = de(labmaster, labnoise);
c_perc = lchmaster(:,2).*100./compute_Cmax(lchmaster(:,1));

print_with_title = @(i) print_diff_rgb(rgbmaster(i,:), rgbcopies(i,:), {strcat('index=',num2str(i)), strcat(' de=', num2str(distance(i)), ' corrDe=', num2str(correctedDistance(i))), strcat(' L=', num2str(lchmaster(i,1)), ' C=', num2str(lchmaster(i,2)), ' C%=', num2str(c_perc(i)), ' h=', num2str(lchmaster(i,3)))});

f = figure;
print_with_title(1);

b = uicontrol('Parent',f,'Style','slider','Position',[81,54,419,23],...
          'value',1, 'min',1, 'max',12690, 'SliderStep', [1/12960 , 10/12960]);
bgcolor = f.Color;
bl1 = uicontrol('Parent',f,'Style','text','Position',[50,54,23,23],...
                'String','0','BackgroundColor',bgcolor);
bl2 = uicontrol('Parent',f,'Style','text','Position',[500,54,46,23],...
                'String','12690','BackgroundColor',bgcolor);
bl3 = uicontrol('Parent',f,'Style','text','Position',[240,25,100,23],...
                'String','index','BackgroundColor',bgcolor);

%b.Callback = @(es,ed) disp(round(es.Value));
b.Callback = @(es,ed) print_with_title(round(es.Value));