function [xx, tt] = beats(A, B, fc, delf, fsamp, dur)
    %BEAT generates samples of the sum of two cosine waves
    %  usage:
    %    [xx, tt] = beat(A, B, fc, delf, fsamp, dur)
    %  where:
    %   A = amplitude of lower frequency cosine
    %   B = amplitude of higher frequency cosine
    %   fc = center frequency
    %   delf = frequency difference
    %   fsamp = sampling rate in Hz
    %   dur = total time duration in seconds
    %  Output:
    %   xx = output vector of samples
    %   tt = time vector corresponding to xx
    tt = 0:1/fsamp:dur;  % time vector
    x1 = A * cos(2 * pi * (fc - delf) * tt);
    x2 = B * cos(2 * pi * (fc + delf) * tt);
    xx = x1 + x2;
    % soundsc(xx,fsamp);
end