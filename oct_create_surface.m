function [hslice] = oct_create_surface (oct_volume, n)

longest_edge = max(size(oct_volume));

X_coordinates = linspace(-100,longest_edge+100,longest_edge);
Y_coordinates = linspace(-100,longest_edge+100,longest_edge);
% +-100: adding a bit more range so that when we slice through the volume 
% there are no missed datapoints

Z = zeros(longest_edge)+ longest_edge/n;
% longest_edge/n defines the height at which the volume is sliced

hslice = surf(X_coordinates, Y_coordinates, Z);