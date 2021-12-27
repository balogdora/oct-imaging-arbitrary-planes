function [xd, yd,zd] = oct_rotate_surface(hslice, theta, x, y, z, oct_volume)

rotate(hslice,[x,y,z],theta)
xd = get(hslice,'XData');
yd = get(hslice,'YData');
zd = get(hslice,'ZData');

% deleting the black surface
delete(hslice)