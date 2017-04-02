function [y, B, A] = biquad(x, type, fc, fs, Q)

% biquad.m
%
% a versatile biquad filter function that can be selected as one of 
% lowpass, highpass, bandpass and notch filters. 
%
% The mapping from cut-off frequency and Q to filter coefficients are based
% on ''Cookbook formulae for audio EQ biquad filter coefficient, R.
% Bristow-Johnson, http://www.musicdsp.org/files/Audio-EQ-Cookbook.txt"
%
% Version 0.1, Apr-11-2015 
%
% By Juhan Nam, KAIST
%

% cut-off freq: fc (Hz)
% resoance: Q (dB)
% sampling rate: fs (Hz)
%
%
q = power(10,Q/20);

w0 = 2*pi*fc/fs;
alpha = sin(w0)/2/q;

if strcmp(type, 'lowpass')
    b0 = (1-cos(w0))/2;
    b1 = 1-cos(w0);
    b2 = (1-cos(w0))/2;
elseif strcmp(type, 'highpass')
    b0 = (1+cos(w0))/2;
    b1 = -(1+cos(w0));
    b2 = (1+cos(w0))/2;
elseif strcmp(type, 'bandpass')
    b0 = sin(w0)/2;
    b1 = 0;
    b2 = -sin(w0)/2;
elseif strcmp(type, 'notch')
    b0 = 1;
    b1 = -2*cos(w0);
    b2 = 1;
end
    
a0 = 1 + alpha;
a1 = -2*cos(w0);
a2 = 1 - alpha;

B = [b0 b1 b2];
A = [a0 a1 a2];

y = filter(B,A,x);





