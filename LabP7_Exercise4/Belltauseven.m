% Example parameters for the bell sound
ff = [110, 220];    % fc = 110 Hz, fm = 220 Hz (1:2 ratio)
Io = 50;            % Initial modulation index
tau = 0.7;          % Decay time constant
dur = 5;            % Duration of 5 seconds
fsamp = 44100;      % Sampling rate (standard audio quality)

% Generate the bell sound
bell_sound = BellDecay(ff, Io, tau, dur, fsamp);

% Play the sound
sound(bell_sound, fsamp);

% Plot the waveform (first 1000 samples)
figure;
plot(0:1/fsamp:dur-1/fsamp, bell_sound);
title('Bell Decay(tau0.7)');
xlabel('Time (seconds)');
ylabel('Amplitude');
audiowrite('Bell0.7.wav', bell_sound, fsamp);