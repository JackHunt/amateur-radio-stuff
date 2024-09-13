function plot_impedance_vswr(f_range, z, swr, title)
%PLOT_IMPEDANCE_VSWR Plot impedance and VSWR over a frequency range.
    % Impedance.
    figure;
    subplot(2, 1, 1);
    plot(f_range, real(z), 'b-', 'LineWidth', 1.5);
    
    hold on;
    plot(f_range, imag(z), 'r--', 'LineWidth', 1.5);

    grid on;
    xlabel('Frequency (MHz)');
    ylabel('Impedance (\Omega)');
    legend('Real Part', 'Imaginary Part');
    
    hold off;

    % VSWR.
    subplot(2, 1, 2);
    plot(f_range, swr, 'r-', 'LineWidth', 1.5);
    
    grid on;
    xlabel('Frequency (MHz)');
    ylabel('VSWR');
    ylim([1, max(swr) * 1.1]);
    legend('VSWR');

    sgtitle(title);
end

