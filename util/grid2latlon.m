function latlon = grid2latlon(maidenhead)
%GRID2LATLONG Convert maidenhead locator to latitude and longitude.
%   https://ham.stackexchange.com/questions/6462/how-can-one-convert-from-grid-square-to-lat-long
    arguments
        maidenhead (1, 1) string 
    end

    grid = lower(char(maidenhead));

    % Latitude.
    [lat_min, lat_max] = get_lat(grid);
    latlon.lat_min = lat_min;
    latlon.lat_max = lat_max;

    % Longitude.
    [lon_min, lon_max] = get_lon(grid);
    latlon.lon_min = lon_min;
    latlon.lon_max = lon_max;

    % Mid point.
    [lat_mid, lon_mid] = midpoint_haversine(lat_min, lon_min, lat_max, lon_max);
    latlon.lat_mid = lat_mid;
    latlon.lon_mid = lon_mid;

end

function [start_lon, end_lon] = get_lon(grid)
    field = (double(grid(1)) - 97) * 20; 
    square = str2double(grid(3)) * 2;
    sub_square_low = (double(grid(5)) - 97) * (2 / 24);
    sub_square_high = sub_square_low + (2 / 24);

    start_lon = field + square + sub_square_low - 180;
    end_lon = field + square + sub_square_high - 180;
end

function [start_lat, end_lat] = get_lat(grid)
    field = (double(grid(2)) - 97) * 10;
    square = str2double(grid(4));
    sub_square_low = (double(grid(6)) - 97) * (1 / 24);
    sub_square_high = sub_square_low + (1 / 24);

    start_lat = field + square + sub_square_low - 90;
    end_lat = field + square + sub_square_high - 90;
end

function [lat_mid, lon_mid] = midpoint_haversine(lat_a, lon_a, lat_b, lon_b)
    lat_a = deg2rad(lat_a);
    lon_a = deg2rad(lon_a);
    lat_b = deg2rad(lat_b);
    lon_b = deg2rad(lon_b);

    d_lon = lon_b - lon_a;

    b_x = cos(lat_b) * cos(d_lon);
    b_y = cos(lat_b) * sin(d_lon);

    lat_mid = atan2(sin(lat_a) + sin(lat_b), sqrt((cos(lat_a) + b_x)^2 + b_y^2));
    lon_mid = lon_a + atan2(b_y, cos(lat_a) + b_x);

    lat_mid = rad2deg(lat_mid);
    lon_mid = rad2deg(lon_mid);
end