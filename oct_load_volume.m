function [handle, oct_volume] = oct_load_volume (filename)
% importing data in the handle structure as in Thorlabs test.m
handle = OCTFileOpen(filename);

% importing the 3D image intensity values in decibel (dB)
oct_volume = OCTFileGetIntensity(handle); 