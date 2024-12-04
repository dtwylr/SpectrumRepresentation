% Parameters for bell-like sound with a big initial strike
sample_rate = 44100; 
duration = 4.0;  % Duration of the bell sound
fundamental_freq = 440.0;  % Fundamental frequency (A4)
decay_rate = 0.5;     % Decay rate for overall fade
attack_duration = 0.01;  % Short but sharp attack for the strike

% Time vector
t = 0:1/sample_rate:duration-1/sample_rate;

% Harmonics: Create harmonics (fundamental to 7th)
harmonics = [];
for k = 1:7  % First 7 3 harmonics for a rich bell sound
    detune_factor = 1 + 0.01 * k * randn;  % Random slight detuning
    amplitude = 1 / k;  % Amplitude decreases for higher harmonics
    harmonics = [harmonics; amplitude * sin(2 * pi * fundamental_freq * k * t * detune_factor)];
end

% Combine harmonics into the sound wave
sound_wave = sum(harmonics, 1);

% Create a sharp attack envelope for the big strike
attack_samples = round(attack_duration * sample_rate); % Number of samples for attack
attack_envelope = [linspace(0, 1, attack_samples), ones(1, length(t) - attack_samples)];

% Apply decay envelope (exponential decay)
decay_envelope = exp(-decay_rate * t);  

% Combine the attack and decay envelopes 
sound_wave = sound_wave .* attack_envelope .* decay_envelope; 

% Normalize the sound
sound_wave = sound_wave / max(abs(sound_wave)); 

% Play
sound(sound_wave, sample_rate);

% Save the sound to a WAV file
audiowrite('big_strike_bell_like_sound.wav', sound_wave, sample_rate);

% Plot the waveform (first 1000 samples for visualization)
figure;
plot(t(1:1000), sound_wave(1:1000));
title('Bell-like Sound with Big Initial Strike');
xlabel('Time (s)');
ylabel('Amplitude');
