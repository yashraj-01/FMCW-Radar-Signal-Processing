# FMCW-Radar-Signal-Processing

### fmcw_radar_simulation
Base function to initialize the radar specifications and target information.

### fmcw_radar_baseband_signal_generator
Baseband signal generator for single target formed by mixing transmitting and received chirps.

### fmcw_radar_multi_target_baseband_signal_generator
Baseband signal generator for multiple targets formed by superimposing individual IF signals.

### visualize_fmcw_radar_baseband_signals
Visualizes the IF signal in range-doppler domain and obtains range and velocity from corresponding peaks.

## How to run the code?
- Set the desired radar and target specifications in **fmcw_radar_simulation**. Make sure the **correct chirp profile** check passes i.e., no of samples per chirp x sampling period ≥ chirp period
- Now run the code from **fmcw_radar_simulation**.

## Issues
- Doppler estimation is incorrect.


## Future Work
- Fix Doppler estimation.
- Apply CFAR detection.
- Automatic identifying peaks.
