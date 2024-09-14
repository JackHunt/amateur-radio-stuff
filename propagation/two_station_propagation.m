%% Clear, define vars etc.
clear all;
close all;
clc;

tx_site = "IO81WL";
rx_site = "IO91JO";

% TODO: Set station info, freq etc

%% Set the RX and TX sites.
tx_latlong = grid2latlon(tx_site);
rx_latlong = grid2latlon(rx_site);

tx = txsite("Latitude", tx_latlong.lat_mid, "Longitude", tx_latlong.lon_mid);
rx = rxsite("Latitude", rx_latlong.lat_mid, "Longitude", rx_latlong.lon_mid);

show(tx)
show(rx)

%% Compute distance, angle, signal strength etc.
dm = distance(tx, rx)

[az,el] = angle(tx, rx)

ss = sigstrength(rx, tx)

margin = abs(rx.ReceiverSensitivity - ss)

link(rx, tx)

coverage(tx, "SignalStrengths", -100:5:-60)
sinr(tx)