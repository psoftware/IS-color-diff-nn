function [] = print_color_rgb(red,green,blue)
%PRINT_COLOR Summary of this function goes here
%   Detailed explanation goes here
    r = red/255;
    g = green/255;
    b = blue/255;
    color = cat(3,r,g,b);
    image(color);
end

