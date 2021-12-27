function [horizontal, vertical] = oct_scalebar (h,theta, handle)

% diagonal
x_1 = h.XData(~isnan(h.CData));
y_1 = h.YData(~isnan(h.CData));
z_1 = h.ZData(~isnan(h.CData));

x1 = min(x_1); x2 = max(x_1); x3 = x2-x1;
y1 = min(y_1); y2 = max(y_1); y3 = y2-y1;
z1 = min(z_1); z2 = max(z_1); z3 = z2-z1;

k = sqrt(x3^2 + y3^2 + z3^2);

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

% horizontal scale bar
% rows: axes
% coumns: start/finish
horizontal = zeros(3,2);
horizontal(1,1) = x2-100-scalebar_length_x;
% -100 - move left from the last pixel by a 100 pixels
horizontal(1,2) = x2-100;
horizontal(2,1) = y1+50;
horizontal(2,2) = y1+50;
horizontal(3,1) = z2-z_lower;
horizontal(3,2) = z2-z_lower;
plot3([horizontal(1,1),horizontal(1,2)],[horizontal(2,1),horizontal(2,2)],[horizontal(3,1), horizontal(3,2)],'k', 'LineWidth', 1);

% vertical scale bar
a = line(x2-100-scalebar_length_x, y1+50+scalebar_length_yz, z2-z_lower);
rotate(a, [1, 0, 0], theta);
% rows: axes
% coumns: start/finish
vertical = zeros(3,2);
vertical(1,1) = x2-100-scalebar_length_x;
vertical(1,2) = a.XData;
vertical(2,1) = y1+50;
vertical(2,2) = a.YData;
vertical(3,1) = z2-z_lower;
vertical(3,2) = a.ZData;