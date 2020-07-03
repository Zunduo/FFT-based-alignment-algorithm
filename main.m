%dependencies: compute_shift.m, find_boundaries.m, find_error.m
clc;
close all;
clear all;

plot_flags = 1; %0 to supress plot output, if 1 will generate ~30 plots of windowed phase signal and linear fit

image_set = {'img11.jpg','img22.jpg'};
% error_avg_z = zeros(1,factorial(length(image_set))/(2*factorial(length(image_set)-2)));
% error_avg_y = zeros(1,factorial(length(image_set))/(2*factorial(length(image_set)-2)));
% counter = 1;
for j = 1:length(image_set)-1
    for k = j+1:length(image_set)
        [~,~]=compute_shift(image_set{j},image_set{k},plot_flags);

    end
end

