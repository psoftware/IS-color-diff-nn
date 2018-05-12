function [] = print_color_rgb(rgb)
%PRINT_COLOR Summary of this function goes here
%   Detailed explanation goes here
    [m,n] = size(rgb);
    if((m ~= 1) || (n ~= 3))
        error('Invalid rgb vector size!');
    end
    rgb = rgb/255;
    color = cat(3, rgb(1), rgb(2), rgb(3));
    image(color);
end

