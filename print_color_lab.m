function [] = print_color_lab(lab)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    rgb=lab2rgb(lab);
    print_color_rgb(rgb);
end

