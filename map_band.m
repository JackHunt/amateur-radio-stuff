function min_max = map_band(band)
% Convert a ham band name to its UK min and max frequencies in kHz.
    switch band
        case 160
            min_max = [1810 2000];
        case 80
            min_max = [3500 3800];
        case 60
            min_max = [5351.5 5366.5];
        case 40
            min_max = [7000 7200];
        case 30
            min_max = [10100 10150];
        case 20
            min_max = [14000 14350];
        case 17
            min_max = [18068 18168];
        case 15
            min_max = [21000 21450];
        case 12
            min_max = [24890 24990];
        case 10
            min_max = [28000 29700];
        case 6
            min_max = [50000 52000];
        otherwise
            disp('Unexpected amateur band: ', band, ' m')
            min_max = [];
    end 
end