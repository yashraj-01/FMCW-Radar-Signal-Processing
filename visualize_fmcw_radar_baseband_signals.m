function visualize_fmcw_radar_baseband_signals(combined_IF_signal, samples_per_chirp, no_of_chirps, max_range, max_velocity)

    IF_signal_matrix = reshape(combined_IF_signal, [samples_per_chirp, no_of_chirps]); % n x L
    F1 = dftmtx(samples_per_chirp);
    Y1 = F1 * IF_signal_matrix;
    F2 = dftmtx(no_of_chirps);
    Z = F2 * Y1';
%     IF_signal_2d_fft_matrix = [Z(no_of_chirps/2 + 1:no_of_chirps,:); Z(1:no_of_chirps/2,:)];
    IF_signal_2d_fft_matrix = Z';
%     IF_signal_2d_fft_matrix = IF_signal_2d_fft_matrix';

    X = linspace(-max_velocity, max_velocity, no_of_chirps);
    Y = linspace(0, max_range, samples_per_chirp);
    surfc(X, Y, abs(IF_signal_2d_fft_matrix), 'EdgeColor', 'none');
    xlabel('Doppler Axis (in m/s)');
    ylabel('Range Axis (in m)');
    zlabel('Magnitude Spectrum');

    xh = get(gca,'XLabel');
    set(xh, 'Units', 'Normalized');
    pos = get(xh, 'Position');
    set(xh, 'Position',pos.*[1.1,0,0],'Rotation',10);
    yh = get(gca,'YLabel');
    set(yh, 'Units', 'Normalized');
    pos = get(yh, 'Position');
    set(yh, 'Position',pos,'Rotation',-16);
    fontsize(gca,20,"pixels");

end
