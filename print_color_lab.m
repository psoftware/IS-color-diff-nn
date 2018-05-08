function [] = print_color_lab(l,a,b)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    rgb=lab2rgb([l,a,b]);
    print_color_rgb(rgb(1),rgb(2),rgb(2));
end

