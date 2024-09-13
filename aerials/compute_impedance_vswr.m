function [f_range, z, swr] = compute_impedance_vswr(antenna_obj, f_min, f_max)
%COMPUTE_IMPEDANCE_VSWR Compute impedance and VSWR over a frequency range.
    f_range = linspace(f_min, f_max, 100);
    z = impedance(antenna_obj, f_range);
    swr = vswr(antenna_obj, f_range);
end

