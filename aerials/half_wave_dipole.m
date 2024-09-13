%% Clear etc.
clear all;
close all;
clc;

%% Model.
f = 3.5e6; % Hz
height = 10; % Meters
material = 'copper';
wire_rad = 0.1; % Meters

lambda = 3e8 / f; % Speed of light over f
length = lambda / 2;

hwd = dipole('Length', length, 'Width', 2 * wire_rad);
hwd.Conductor = get_material(material);
hwd.Tilt = 90;

figure;
show(hwd);
title('Half Wave Dipole');

%% Analyse.
% Impedance.
impedance_values = impedance(hwd, f);
disp(['Antenna impedance at ' num2str(f / 1e6) ...
    ' MHz: ' num2str(impedance_values) ' ohms']);

% Pattern.
figure;
pattern(hwd, f);
title('Radiation Pattern for Half Wave Dipole');

% VSWR.
vswr = vswr(hwd, f);
disp(['VSWR at ' num2str(f/1e6) ' MHz: ' num2str(vswr)]);