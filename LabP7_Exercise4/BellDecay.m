function BellDecay = BellDecay(ff, Io, tau, dur, fsamp)
    % BELL produce a bell sound using FM synthesis
    %    ff     = frequency vector [fc, fm] (carrier and modulating frequencies)
    %    Io     = scale factor for modulation index (I_0)
    %    tau    = decay parameter for A(t) and I(t)
    %    dur    = duration (in sec.) of the output signal
    %    fsamp  = sampling rate (samples per second)

    % Extract carrier and modulating frequencies
    fc = ff(1);  % Carrier frequency
    fm = ff(2);  % Modulating frequency

    % Time vector
    t = 0:1/fsamp:dur-1/fsamp;

    % Generate envelope functions for amplitude and modulation index
    A = exp(-t / tau);         % Amplitude envelope A(t) = A0 * exp(-t/tau)
    I = Io * exp(-t / tau);    % Modulation index envelope I(t) = I0 * exp(-t/tau)

    % FM synthesis equation: y(t) = A(t) * sin(2*pi*fc*t + I(t) * sin(2*pi*fm*t))
    BellDecay = A .* sin(2*pi*fc*t + I .* sin(2*pi*fm*t));  % FM sound signal

    % Normalize to avoid clipping
    BellDecay = BellDecay / max(abs(BellDecay));
end
