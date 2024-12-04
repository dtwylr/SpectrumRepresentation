function [xx, tt] = mychirp(f1, f2, dur, fsamp)
    % MYCHIRP Generate a linear-FM chirp signal
    %
    % Usage:
    % [xx, tt] = mychirp(f1, f2, dur, fsamp)
    %
    % f1 = starting frequency
    % f2 = ending frequency
    % dur = total time duration
    % fsamp = sampling frequency (optional, default = 11025 Hz)
    % xx = samples of the chirp signal
    % tt = vector of time instants for t = 0 to t = dur
    
    % Default sampling frequency
    if nargin < 4
        fsamp = 11025; % Default sampling rate
    end
    
    dt = 1 / fsamp; % Time step
    tt = 0 : dt : dur; % Time vector
    
    % Linear chirp formula
    psi = 2 * pi * (f1 * tt + ((f2 - f1) / (2 * dur)) * tt.^2);
    xx = real(exp(1j * psi)); % Chirp signal (real part)
end