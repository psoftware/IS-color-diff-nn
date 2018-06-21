function [] = print_diff_rgb_to_file(rgb1,rgb2,filename)
%PRINT_COLOR Summary of this function goes here
%   Detailed explanation goes here
    [m1,n1] = size(rgb1);
    [m2,n2] = size(rgb2);
    if((m1 ~= 1) || (n1 ~= 3) || (m2 ~= 1) || (n2 ~= 3))
        error('Invalid rgb vector size!');
    end
    rgb1 = rgb1/255;
    rgb2 = rgb2/255;
    color(1,1,:) = cat(3, rgb1(1), rgb1(2), rgb1(3));
    color(1,2,:) = cat(3, rgb2(1), rgb2(2), rgb2(3));
    f1=figure('visible','off');
    im = image(color);
    
    saveas(f1,filename,'png')
    %imwrite(im,filename);
    %hgexport(im,filename)
end