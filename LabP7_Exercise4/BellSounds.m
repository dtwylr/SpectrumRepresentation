%% Creating a Bell with Harmonics
% Parameters
sample_rate = 44100; 
duration = 4.0;  
fundamental_freq = 440.0; 
decay_rate = 0.5;     
attack_duration = 0.01; 

t = 0:1/sample_rate:duration-1/sample_rate;

% Harmonics: Create harmonics (fundamental to 7th)
harmonics = [];
for k = 1:7  
    detune_factor = 1 + 0.01 * k * randn;  
    amplitude = 1 / k;  
    harmonics = [harmonics; amplitude * sin(2 * pi * fundamental_freq * k * t * detune_factor)];
end

% Combine harmonics into the sound wave
sound_wave = sum(harmonics, 1);

% Sharp attack envelope for big strike
attack_samples = round(attack_duration * sample_rate);
attack_envelope = [linspace(0, 1, attack_samples), ones(1, length(t) - attack_samples)];

% Apply decay envelope (exponential decay)
decay_envelope = exp(-decay_rate * t);  

% Combine attack and decay envelopes
sound_wave = sound_wave .* attack_envelope .* decay_envelope; 

% Normalize
sound_wave = sound_wave / max(abs(sound_wave)); 

% Save the sound
audiowrite('big_strike_bell_like_sound.wav', sound_wave, sample_rate);

% Plot waveform
figure;
plot(t, sound_wave);
title('Bell-like Sound with Quick Attack');
xlabel('Time (s)');
ylabel('Amplitude');

%% Creating Bell using FM synthesis
% FM synthesis parameters
Fs = 44100;             
duration = 5;         
t = linspace(0, duration, Fs * duration);  

% Original FM Bell Sound
carrier_freq = 440;      
modulator_freq = 400;   
modulation_index = 5;    

bell_sound = cos(2 * pi * carrier_freq * t + ...
                 modulation_index * sin(2 * pi * modulator_freq * t));

decay_rate = 3;  
amplitude_envelope = exp(-decay_rate * t);
bell_sound = bell_sound .* amplitude_envelope;

% Normalize
bell_sound = bell_sound / max(abs(bell_sound));

audiowrite('bell_sound_fm_original.wav', bell_sound, Fs);

figure;
plot(t, bell_sound);
title('FM Bell Sound (Modulator Frequency = 400 Hz)');
xlabel('Time (s)');
ylabel('Amplitude');

%% Changing Modulation Frequency
modulator_freq = 100;  
bell_sound = cos(2 * pi * carrier_freq * t + ...
                 modulation_index * sin(2 * pi * modulator_freq * t));
bell_sound = bell_sound .* amplitude_envelope;
bell_sound = bell_sound / max(abs(bell_sound));

audiowrite('carrier_bell_sound.wav', bell_sound, Fs);

figure;
plot(t, bell_sound);
title('FM Bell Sound (Modulator Frequency = 100 Hz)');
xlabel('Time (s)');
ylabel('Amplitude');

%% Low Carrier Frequency
carrier_freq = 100;    
modulator_freq = 400;   
bell_sound = cos(2 * pi * carrier_freq * t + ...
                 modulation_index * sin(2 * pi * modulator_freq * t));
bell_sound = bell_sound .* amplitude_envelope;
bell_sound = bell_sound / max(abs(bell_sound));

audiowrite('carrier_bell_sound_low_freq.wav', bell_sound, Fs);

figure;
plot(t, bell_sound);
title('FM Bell Sound (Carrier Frequency = 100 Hz)');
xlabel('Time (s)');
ylabel('Amplitude');

%% High Modulation
carrier_freq = 400;      
modulator_freq = 1000;    
bell_sound = cos(2 * pi * carrier_freq * t + ...
                 modulation_index * sin(2 * pi * modulator_freq * t));
bell_sound = bell_sound .* amplitude_envelope;
bell_sound = bell_sound / max(abs(bell_sound));

audiowrite('reverse_bell_sound_fm.wav', bell_sound, Fs);

figure;
plot(t, bell_sound);
title('FM Bell Sound (Modulator Frequency = 1000 Hz)');
xlabel('Time (s)');
ylabel('Amplitude');

%% Sideband Filtering effect on Sound
carrier_freq = 500;      
modulator_freq = 400;    
bell_sound = cos(2 * pi * carrier_freq * t + ...
                 modulation_index * sin(2 * pi * modulator_freq * t));
bell_sound = bell_sound .* amplitude_envelope;
bell_sound = bell_sound / max(abs(bell_sound));

fc_low = carrier_freq - 20;  
fc_high = carrier_freq + 20; 

[b, a] = butter(4, [fc_low, fc_high] / (Fs / 2), 'bandpass');
filtered_sound = filter(b, a, bell_sound);
filtered_sound = filtered_sound / max(abs(filtered_sound));

audiowrite('bell_sound_fm_filtered.wav', filtered_sound, Fs);

figure;
plot(t, filtered_sound);
title('Filtered FM Bell Sound (Isolated Carrier Frequency)');
xlabel('Time (s)');
ylabel('Amplitude');
