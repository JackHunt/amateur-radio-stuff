function minMax = mapBand(band)
% Convert a ham band name to its UK min and max frequencies in kHz.
    switch band
        case 160
            minMax = [1810 2000];
        case 80
            minMax = [3500 3800];
        case 60
            minMax = [5351.5 5366.5];
        case 40
            minMax = [7000 7200];
        case 30
            minMax = [10100 10150];
        case 20
            minMax = [14000 14350];
        case 17
            minMax = [18068 18168];
        case 15
            minMax = [21000 21450];
        case 12
            minMax = [24890 24990];
        case 10
            minMax = [28000 29700];
        case 6
            minMax = [50000 52000];
        otherwise
            disp('Unexpected amateur band: ', band, ' m')
            minMax = [];
    end 
end