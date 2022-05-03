% chirp_frequency: f_c
% chirp_bandwidth: B
% chirp_period : T
% target_range : R
% target_velocity : v
% no_of_chirps : L
% samples_per_chirp : n
% sampling_period : T_A
% IF_signal_for_single_target : s_IF
% no_of_targets : k
% rv_matrix : (k x 2) matrix denoting [range, velocity] of k targets

function IF_signal_for_multiple_targets = fmcw_radar_multi_target_baseband_signal_generator(chirp_frequency, chirp_bandwidth, chirp_period, no_of_chirps, ramp_repetition_period, samples_per_chirp, sampling_period, t_start_data_collection, snr, no_of_targets, range_velocity_matrix)

    total_samples = samples_per_chirp *  no_of_chirps;
    IF_signal_for_multiple_targets = zeros(total_samples, 1);
    
    snr_linear = 10^(snr/10);
    noise_variance = 1/snr_linear;
    
    rx_noise = randn(total_samples, 1);
    rx_noise = sqrt(noise_variance) * rx_noise;

    for target_index = 1:no_of_targets
        IF_signal_for_single_target = fmcw_radar_baseband_signal_generator(chirp_frequency, chirp_bandwidth, chirp_period, no_of_chirps, ramp_repetition_period, samples_per_chirp, sampling_period, t_start_data_collection, range_velocity_matrix(target_index, 1), range_velocity_matrix(target_index, 2));
        weight = max([0.5, random('Exponential', 0.5)]);
        IF_signal_for_multiple_targets = IF_signal_for_multiple_targets + weight * IF_signal_for_single_target;
    end
    
    IF_signal_for_multiple_targets = IF_signal_for_multiple_targets + rx_noise;

end
