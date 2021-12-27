function [h] = oct_plot_surface(oct_volume, xd, yd, zd)

colormap(turbo)
% colormap(flipud(turbo(24))) %change for blue
h = slice(oct_volume,xd,yd,zd);
h.FaceColor = 'interp';
h.EdgeColor = 'none';
h.DiffuseStrength = 0.8;