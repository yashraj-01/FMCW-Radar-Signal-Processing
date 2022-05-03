% chirp_frequency: f_c
% chirp_bandwidth: B
% chirp_period : T
% target_range : R
% target_velocity : v
% no_of_chirps : L
% samples_per_chirp : n
% total_no_of_samples : N
% sampling_period : T_A
% speed_of_light : c
% ramp_repetition_period : T_RRI
% amplitude : A
% chirp_index : l
% frequency_of_IF_signal : f_IF
% constant_phase_of_IF_signal : phi
% IF_signal : s_IF

function IF_signal = fmcw_radar_baseband_signal_generator(chirp_frequency, chirp_bandwidth, chirp_period, no_of_chirps, ramp_repetition_period, samples_per_chirp, sampling_period, t_start_data_collection, target_range, target_velocity)

    speed_of_light = 3*10^8;
    
    total_samples = samples_per_chirp *  no_of_chirps;

    IF_signal = zeros(total_samples, 1);
    
    sample_index = 1;
    
    for chirp_index = 1:no_of_chirps
        start_time = t_start_data_collection+(chirp_index-1)*ramp_repetition_period;
        chirp_sample_index = 1;
        while chirp_sample_index<=samples_per_chirp
            t = start_time+(chirp_sample_index-1)*sampling_period;
            tau = 2*(target_range+target_velocity*t) / speed_of_light;
            
            phase_at_t = 2*pi*(chirp_frequency*t + 1/2 * (chirp_bandwidth/chirp_period) * t^2);
            phase_at_t_minus_tau = 2*pi*(chirp_frequency*(t-tau) + 1/2 * (chirp_bandwidth/chirp_period) * (t-tau)^2);

            phase_of_IF_signal = phase_at_t - phase_at_t_minus_tau;

            IF_signal(sample_index) = complex(cos(phase_of_IF_signal), sin(phase_of_IF_signal));
            sample_index = sample_index+1;
            chirp_sample_index = chirp_sample_index+1;
        end
    end
    
end

