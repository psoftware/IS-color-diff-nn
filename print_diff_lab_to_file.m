function [] = print_diff_lab_to_file(labl,lab2,title_fig,filename)
%PRINT_COLOR Summary of this function goes here
%   Detailed explanation goes here
    print_diff_rgb_to_file(lab2rgb(labl)*255,lab2rgb(lab2)*255,title_fig,filename);
end
