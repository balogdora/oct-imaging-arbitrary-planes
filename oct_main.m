close all % closes all figures
clear all % deletes variables in workspace
clc % clears command window

%import volume
[handle, oct_volume] = oct_load_volume('testdata.oct');

%%
cmap = pink(256);
orthosliceViewer(oct_volume,'Colormap',cmap);

%%

%create surface
n = 2; % height for cutting through the z-axis
hslice = oct_create_surface(oct_volume,n);

%%

% rotate surface
theta = 60;
x = 1;
y = 0;
z = 0;
[xd, yd,zd] = oct_rotate_surface(hslice, theta, x, y, z, oct_volume);

%% 

%plot surface
h = oct_plot_surface(oct_volume, xd,yd, zd);
xlabel('x-axis')
ylabel('y-axis')
zlabel('z-axis')

%%

%scale bar
[horizontal, vertical] = oct_scalebar(h, theta, handle);

hold on
% horizontal scale bar
plot3([horizontal(1,1),horizontal(1,2)],[horizontal(2,1),horizontal(2,2)],[horizontal(3,1), horizontal(3,2)],'k', 'LineWidth', 1);

% vertical scale bar
plot3([vertical(1,2),vertical(1,1)], [vertical(2,1),vertical(2,2)], [vertical(3,1),vertical(3,2)], 'k', 'LineWidth', 1);

text(vertical(1,1), vertical(2,1)-10, vertical(3,1), '500 um', 'HorizontalAlignment','center');
%hold off

xlabel('x-axis')
ylabel('y-axis')
zlabel('z-axis')

view(0,90)
axis tight 

xlim([0, size(h.XData,1)])
ylim([0, size(h.YData,1)])