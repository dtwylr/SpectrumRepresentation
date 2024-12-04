% Parameters
sample_rate = 44100;        % Sampling rate
duration = 2;               % Duration of the sound 
carrier_freq = 440;         % Carrier frequency 
modulating_freq = 5;        % Modulating frequency 
modulation_index = 50;      % Modulation index 

% Time
t = 0:1/sample_rate:duration-1/sample_rate;

% FM synthesis: Carrier frequency with modulation
carrier = sin(2 * pi * carrier_freq * t);                   
modulator = sin(2 * pi * modulating_freq * t);              

modulated_signal = sin(2 * pi * carrier_freq * t + modulation_index * modulator);  % FM signal

% Normalize Carrier Frequency
carrier = carrier / max(abs(carrier));  
modulated_signal = modulated_signal / max(abs(modulated_signal)); 


disp('Playing unmodulated carrier signal...');
sound(carrier, sample_rate); 

pause(duration);

% Play the modulated FM signal
disp('Playing modulated FM signal...');
sound(modulated_signal, sample_rate);

% Plot the waveform (first 1000 samples for visualization)
figure;

% Carrier waveform plot
subplot(2,1,1);
plot(t(1:1000), carrier(1:1000));
title('Carrier Frequency (440 Hz)');
xlabel('Time (s)');
ylabel('Amplitude');

% Modulated waveform plot
subplot(2,1,2);
plot(t(1:1000), modulated_signal(1:1000));
title('FM Synthesized Signal');
xlabel('Time (s)');
ylabel('Amplitude');
