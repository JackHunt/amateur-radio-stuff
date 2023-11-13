function rw(varargin)
% RW(bands) calculates half-wavelengths in feet of each ham band
% passed in vector bands_m.
%
% EXAMPLES
%   rw([40 20 15 10])
%   rw([80 30 40], 'metric')
%   rw([15])
%   rw([40 20 15 10], 'cw')
%
% INPUT
%   bands: vector of integers representing a ham band.  For instance,
%          [40 20 15 10] represents the UK amateur 40m, 20m, 15, and 10m
%          ham bands.  If a second argument is provided and is 'cw', then
%          UK cw sub-bands will be graphed.
%
% OUTPUT
%   A graph whose red bands indicate half-wavelengths for the ham bands
%   chosen.  These are the highest impedance lengths for end-fed wires.
%   For typical transceiver antenna tuners, these are lengths to avoid.
%
% Author
%   Mike Markowski AB3AP
%
%   UK band modifications: Jack Hunt 2E0GDV
%
% Date
%   2013 Feb  5 Original
%   2013 Feb  7 Added provision for 'cw' in varargin.
%   2021 Feb  2 UK bands.
%   2021 Feb  25 Metric option.

    bands_m = varargin{1};
    useCw = 0;
    distUnit = 'ft';
    
    for i = 1:nargin
        if strcmp(varargin{i}, 'cw')
            useCw = 1;
        end
        
        if strcmp(varargin{i}, 'metric')
            distUnit = 'm';
        end
    end
    
    % Convert ham band names to min/max band edge frequency pairs.
    n = size(bands_m, 2);
    freqs_kHz = zeros(n, 2);
    bands_m = sort(bands_m, 'descend');
    for i = 1:n
        if useCw
            freqs_kHz(i, :) = mapBandCw(bands_m(i));
        else
            freqs_kHz(i, :) = mapBand(bands_m(i));
        end
    end
    lowest_MHz = freqs_kHz(1) * 1e-3;

    % Prepare plot.
    clf
    hold on
    grid on
    figHandle = figure(1);
    screensize = get( 0, 'ScreenSize' );
    scrWidth = screensize(3);
    scrHeight = screensize(4);
    set(figHandle, 'Position', ...
        [scrWidth/2 - 500, scrHeight/2, 150 * size(bands_m, 2), 100]);
    
    if useCw
        bandStr = ' UK CW Sub-bands';
    else
        bandStr = ' UK Bands';
    end
    
    title(['End-fed Antenna High Impedance Lengths for ', ...
        mat2str(bands_m), bandStr]);
    xlabel(sprintf('Lengths to Avoid in Red (%s)', distUnit));

    % Plot length of zero feet through quarter wave, since antenna
    % must (should) be at least 1/4 wavelength long.
    fullWave_ft = 2 * 468 / lowest_MHz; % Max wavelength in band.
    qtrWave_ft = fullWave_ft / 4;    
    
    qtrX = [0 0 qtrWave_ft qtrWave_ft];
    if strcmp(distUnit, 'm')
        qtrX = ft2m(qtrX);
    end
    
    qtrY = [0 1 1 0];
    set(area(qtrX, qtrY), 'FaceColor', [1 0 0], 'EdgeColor', [1, 0, 0])
    
    % Draw a rectangle for difficult (high impedance) end fed wire lengths.
    for i = 1:size(freqs_kHz, 1)
        badLengths(freqs_kHz(i, 1), freqs_kHz(i, 2), fullWave_ft, distUnit)
    end
    set(gca(), 'YTickLabel', '')
    
    % Adjust limits of x axis to multiples of 10 feet.
    shortestQtrWave = 234 / (freqs_kHz(1) * 1e-3);
    shortestQtrWave = 10 * floor(shortestQtrWave / 10);
    
    if strcmp(distUnit, 'm')
        xlim([ft2m(shortestQtrWave), ft2m(fullWave_ft)]);
    else
        xlim([shortestQtrWave, fullWave_ft]);
    end
    
    % Pick an even increment along x axis.
    inc = (fullWave_ft - shortestQtrWave) / size(bands_m, 2) / 1.5;
    inc = 10 * floor(inc / 10);
    
    hold off
end

function badLengths(min_kHz, max_kHz, fullWave_ft, distUnit)
% Plot a solid rectangle covering the frequency range half-wavelengths in
% ft.
    n = 1;
    while 1
        % For each min/max frequency delimiting a range, draw a rectangle
        % indicating bad, or very high impedance, end-fed wire lengths.
        lambda0_ft = n * 468 / (max_kHz * 1e-3);
        lambda1_ft = n * 468 / (min_kHz * 1e-3);
        
        badX = [lambda0_ft lambda0_ft lambda1_ft lambda1_ft];
        if strcmp(distUnit, 'm')
            badX = ft2m(badX);
        end
        
        badY = [0 1 1 0];
        set(area(badX, badY), 'FaceColor', [1 0 0], 'EdgeColor', [1, 0, 0])
        n = n + 1;
        
        if lambda1_ft > fullWave_ft || n > 51
            break
        end
    end
end