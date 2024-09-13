function min_max = map_band_cw(band)
% Convert a ham band name to its UK min and max frequencies in kHz for
% CW sub-bands.
    switch band
        case 160
            min_max = [1810 1838];
        case 80
            min_max = [3500 3570];
        case 60
            min_max = [5258.5 5264];
        case 40
            min_max = [7000 7040];
        case 30
            min_max = [10100 10130];
        case 20
            min_max = [14000 14070];
        case 17
            min_max = [18068 18095];
        case 15
            min_max = [21000 21070];
        case 12
            min_max = [24890 24915];
        case 10
            min_max = [28000 28070];
        case 6
            min_max = [50000 50100];
        otherwise
            disp('Unexpected amateur band: ', band, ' m')
            min_max = [];
    end 
end