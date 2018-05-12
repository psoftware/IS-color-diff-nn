function [] = print_diff_lab(labl,lab2)
%PRINT_COLOR Summary of this function goes here
%   Detailed explanation goes here
    print_diff_rgb(lab2rgb(labl)*255,lab2rgb(lab2)*255);
end
