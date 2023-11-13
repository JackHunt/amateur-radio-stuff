function minMax = mapBandCW(band)
% Convert a ham band name to its UK min and max frequencies in kHz for
% CW sub-bands.
    switch band
        case 160
            minMax = [1810 1838];
        case 80
            minMax = [3500 3570];
        case 60
            minMax = [5258.5 5264];
        case 40
            minMax = [7000 7040];
        case 30
            minMax = [10100 10130];
        case 20
            minMax = [14000 14070];
        case 17
            minMax = [18068 18095];
        case 15
            minMax = [21000 21070];
        case 12
            minMax = [24890 24915];
        case 10
            minMax = [28000 28070];
        case 6
            minMax = [50000 50100];
        otherwise
            disp('Unexpected amateur band: ', band, ' m')
            minMax = [];
    end 
end