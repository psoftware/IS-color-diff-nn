function[c_max] = compute_Cmax(L)
    c_max = 127*sqrt(1-power((L-50),2)/50^2);
end
