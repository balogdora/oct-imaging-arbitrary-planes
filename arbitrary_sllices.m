close all % closes all figures
clear all % deletes variables in workspace
clc % clears command window

% importing data in the handle structure as in Thorlabs test.m
handle = OCTFileOpen('testdata.oct');

% importing the 3D image intensity values in decibel (dB)
oct_volume = OCTFileGetIntensity(handle);

%%

longest_edge = max(size(oct_volume));

X_coordinates = linspace(-100,longest_edge+100,longest_edge);
Y_coordinates = linspace(-100,longest_edge+100,longest_edge);
% +-100: adding a bit more range so that when we slice through the volume 
% there are no missed datapoints

Z = zeros(longest_edge)+ longest_edge/2;
% longest_edge/n defines the height at which the volume is sliced

hslice = surf(X_coordinates, Y_coordinates, Z);

theta = 45;
rotate(hslice,[1,0,0],theta)
xd = get(hslice,'XData');
yd = get(hslice,'YData');
zd = get(hslice,'ZData');

% deleting the black surface
delete(hslice)

%colormap(turbo)
% colormap(flipud(turbo(24))) %change for blue
h = slice(oct_volume,xd,yd,zd);
h.FaceColor = 'interp';
h.EdgeColor = 'none';
h.DiffuseStrength = 0.8;

xlabel('x-axis')
ylabel('y-axis')
zlabel('z-axis')

%%

% diagonal
x = h.XData(~isnan(h.CData));
y = h.YData(~isnan(h.CData));
z = h.ZData(~isnan(h.CData));

x1 = min(x); x2 = max(x); x3 = x2-x1;
y1 = min(y); y2 = max(y); y3 = y2-y1;
z1 = min(z); z2 = max(z); z3 = z2-z1;

k = sqrt(x3^2 + y3^2 + z3^2);

% scalebars

% FOV - Field of view - physical length
% Size - number of scans/pixels in a scan
FOV_x = str2double(handle.head.Image.SizeReal.SizeX.Text);
Size_x = str2double(handle.head.Image.SizePixel.SizeX.Text);

FOV_y = str2double(handle.head.Image.SizeReal.SizeY.Text);
Size_y = str2double(handle.head.Image.SizePixel.SizeY.Text);

FOV_z = str2double(handle.head.Image.SizeReal.SizeZ.Text);
Size_z = str2double(handle.head.Image.SizePixel.SizeZ.Text);

pixel_size_x = FOV_x/Size_x*10^3;
pixel_size_y = FOV_y/Size_y*10^3;
pixel_size_z = FOV_z/Size_z*10^3;
% 10^3 - transferring from mm to um
% FOV/Size = size of one pixel

scalebar_length_x = 500/pixel_size_x;
scalebar_length_y = 500/pixel_size_y;
scalebar_length_z = 500/pixel_size_z;
% calculate length for 500um
scalebar_length_yz = sqrt(scalebar_length_y^2 + scalebar_length_z^2);

z_lower = 50*z3/y3;
% 50 because y is moved by 50 pixels as well, otherwise it's arbitrary
% calculated on the basis of triangle similarity

hold on
% horizontal scale bar
plot3([x2-100-scalebar_length_x,x2-100],[y1+50,y1+50],[z2-z_lower, z2-z_lower],'k', 'LineWidth', 1);
% -100 - move left from the last pixel by a 100 pixels

% vertical scale bar
a = line(x2-100-scalebar_length_x, y1+50+scalebar_length_yz, z2-z_lower);
rotate(a, [1, 0, 0], theta);
plot3([x2-100-scalebar_length_x,a.XData], [y1+50,a.YData], [z2-z_lower,a.ZData], 'k', 'LineWidth', 1);

text(x2-100-scalebar_length_x, y1+40, z2, '500 um', 'HorizontalAlignment','left')
hold off

view(0,90)
axis tight 

xlim([0, size(h.XData,1)])
ylim([0, size(h.YData,1)])