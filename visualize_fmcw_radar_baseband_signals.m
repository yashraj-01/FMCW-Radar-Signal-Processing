function visualize_fmcw_radar_baseband_signals(combined_IF_signal, samples_per_chirp, no_of_chirps, delta_R, delta_v)

    IF_signal_matrix = reshape(combined_IF_signal, [samples_per_chirp, no_of_chirps]); % n x L
    F1 = dftmtx(samples_per_chirp);
    Y1 = F1 * IF_signal_matrix;
    F2 = dftmtx(no_of_chirps);
    Z = F2 * Y1';
    IF_signal_2d_fft_matrix = [Z(no_of_chirps/2 + 1:no_of_chirps,:); Z(1:no_of_chirps/2,:)];
    IF_signal_2d_fft_matrix = IF_signal_2d_fft_matrix';
%     IF_signal_2d_fft_matrix = Y1 * F2'; % Z = (F2 * Y')'
    [X,Y] = meshgrid(-1*floor((no_of_chirps-1)/2)*delta_v:delta_v:floor(no_of_chirps/2)*delta_v, ...
        0:delta_R:(samples_per_chirp-1)*delta_R);
    surfc(X, Y, abs(IF_signal_2d_fft_matrix), 'EdgeColor', 'none');
%     x = [0.3 0.5];
%     y = [0.6 0.5];
%     annotation('textarrow',x,y,'String','peak corresponding to range=45m and doppler=0');
    xlabel('Doppler Axis (in m/s)');
    ylabel('Range Axis (in m)');
    zlabel('Magnitude Spectrum');

    xh = get(gca,'XLabel');
    set(xh, 'Units', 'Normalized')
    pos = get(xh, 'Position');
    set(xh, 'Position',pos.*[1.1,0,0],'Rotation',15)
    yh = get(gca,'YLabel');
    set(yh, 'Units', 'Normalized')
    pos = get(yh, 'Position');
    set(yh, 'Position',pos,'Rotation',-24)

end
