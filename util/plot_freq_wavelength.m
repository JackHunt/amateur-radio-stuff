function [f, lambda] = plot_freq_wavelength(f_min_mhz, f_max_mhz)
%PLOT_FREQ_WAVELENGTH Plot frequency vs wavelength over a given range.
    f = linspace(f_min_mhz * 1e6, f_max_mhz * 1e6, 100);

    lambda = 3e8 ./ f; % Speed of light (m/s) / freq

    figure;
    plot(f / 1e6, lambda, 'b-', 'LineWidth', 1.5);
    title('Frequency vs Wavelength');
    
    grid on;
    yscale log;
    xscale log;
    xlabel('Frequency (MHz)');
    ylabel('Wavelength (m)');
    
    xlim([f_min_mhz, f_max_mhz]);
    ylim([min(lambda), max(lambda)]);
end

