clc;
close all;
clear all;

speed_of_light = 3e8; %m/s
chirp_frequency = 77e9; %Hz
chirp_bandwidth = 4e9; %Hz
chirp_period = 8e-6; %s
no_of_chirps = 64;
ramp_repetition_period = chirp_period + 1e-6; %s
samples_per_chirp = 512;
sampling_frequency = 80e6; %Hz
sampling_period = 1/sampling_frequency; %s

delta_R = (speed_of_light*chirp_period)/(2*chirp_bandwidth*sampling_period*samples_per_chirp); %m
delta_v = speed_of_light/(2*chirp_frequency*ramp_repetition_period*no_of_chirps); %m/s
max_range = delta_R * samples_per_chirp; %m
min_range = 0.5; %m
max_velocity = delta_v * no_of_chirps / 2; %m/s
min_velocity = -max_velocity; %m/s

t_start_data_collection = 5*(2*max_range/speed_of_light); %s

snr = 10; %dB

if (t_start_data_collection+samples_per_chirp*(sampling_period) >= chirp_period)
    disp('Wrong input chirp profile');
    return;
end

no_of_targets = 1;
range_vector = min_range + (max_range-min_range) .* rand(no_of_targets,1);
% velocity_vector = min_velocity + (max_velocity-min_velocity) .* rand(no_of_targets,1);
velocity_vector = 0;
range_velocity_matrix = [range_vector(:), velocity_vector(:)];

combined_s_IF = fmcw_radar_multi_target_baseband_signal_generator(chirp_frequency, chirp_bandwidth, chirp_period, no_of_chirps, ramp_repetition_period, samples_per_chirp, sampling_period, t_start_data_collection, snr, no_of_targets, range_velocity_matrix);
visualize_fmcw_radar_baseband_signals(combined_s_IF, samples_per_chirp, no_of_chirps,delta_R, delta_v);
