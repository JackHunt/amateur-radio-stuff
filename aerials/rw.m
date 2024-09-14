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
%   UK band modifications: Jack Hunt M0JMU
%
% Date
%   2013 Feb  5 Original
%   2013 Feb  7 Added provision for 'cw' in varargin.
%   2021 Feb  2 UK bands.
%   2021 Feb  25 Metric option.
    bands_m = varargin{1};
    use_cw = 0;
    dist_unit = 'ft';
    
    for i = 1:nargin
        if strcmp(varargin{i}, 'cw')
            use_cw = 1;
        end
        
        if strcmp(varargin{i}, 'metric')
            dist_unit = 'm';
        end
    end
    
    % Convert ham band names to min/max band edge frequency pairs.
    n = size(bands_m, 2);
    freqs_kHz = zeros(n, 2);
    bands_m = sort(bands_m, 'descend');
    for i = 1:n
        if use_cw
            freqs_kHz(i, :) = map_band_cw(bands_m(i));
        else
            freqs_kHz(i, :) = map_band(bands_m(i));
        end
    end
    lowest_MHz = freqs_kHz(1) * 1e-3;

    % Prepare plot.
    clf
    hold on
    grid on
    fig_handle = figure(1);
    screensize = get( 0, 'ScreenSize' );
    scr_width = screensize(3);
    scr_height = screensize(4);
    set(fig_handle, 'Position', ...
        [scr_width / 2 - 500, scr_height / 2, 150 * size(bands_m, 2), 100]);
    
    if use_cw
        band_str = ' UK CW Sub-bands';
    else
        band_str = ' UK Bands';
    end
    
    title(['End-fed Antenna High Impedance Lengths for ', ...
        mat2str(bands_m), band_str]);
    xlabel(sprintf('Lengths to Avoid in Red (%s)', dist_unit));

    % Plot length of zero feet through quarter wave, since antenna
    % must (should) be at least 1/4 wavelength long.
    full_wave_ft = 2 * 468 / lowest_MHz; % Max wavelength in band.
    qtr_wave_ft = full_wave_ft / 4;    
    
    qtr_X = [0 0 qtr_wave_ft qtr_wave_ft];
    if strcmp(dist_unit, 'm')
        qtr_X = ft2m(qtr_X);
    end
    
    qtr_Y = [0 1 1 0];
    set(area(qtr_X, qtr_Y), 'FaceColor', [1 0 0], 'EdgeColor', [1, 0, 0])
    
    % Draw a rectangle for difficult (high impedance) end fed wire lengths.
    for i = 1:size(freqs_kHz, 1)
        bad_lengths(freqs_kHz(i, 1), freqs_kHz(i, 2), full_wave_ft, dist_unit)
    end
    set(gca(), 'YTickLabel', '')
    
    % Adjust limits of x axis to multiples of 10 feet.
    shortest_qtr_wave = 234 / (freqs_kHz(1) * 1e-3);
    shortest_qtr_wave = 10 * floor(shortest_qtr_wave / 10);
    
    if strcmp(dist_unit, 'm')
        xlim([ft2m(shortest_qtr_wave), ft2m(full_wave_ft)]);
    else
        xlim([shortest_qtr_wave, full_wave_ft]);
    end
    
    % Pick an even increment along x axis.
    inc = (full_wave_ft - shortest_qtr_wave) / size(bands_m, 2) / 1.5;
    inc = 10 * floor(inc / 10);
    
    hold off
end

function bad_lengths(min_kHz, max_kHz, full_wave_ft, dist_unit)
% Plot a solid rectangle covering the frequency range half-wavelengths in
% ft.
    n = 1;
    while 1
        % For each min/max frequency delimiting a range, draw a rectangle
        % indicating bad, or very high impedance, end-fed wire lengths.
        lambda0_ft = n * 468 / (max_kHz * 1e-3);
        lambda1_ft = n * 468 / (min_kHz * 1e-3);
        
        bad_X = [lambda0_ft lambda0_ft lambda1_ft lambda1_ft];
        if strcmp(dist_unit, 'm')
            bad_X = ft2m(bad_X);
        end
        
        bad_Y = [0 1 1 0];
        set(area(bad_X, bad_Y), 'FaceColor', [1 0 0], 'EdgeColor', [1, 0, 0])
        n = n + 1;
        
        if lambda1_ft > full_wave_ft || n > 51
            break
        end
    end
end