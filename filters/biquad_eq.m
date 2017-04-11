function y = biquad_eq(x, fc, fs, Q, AdB)

% biquad_eq.m
%
% a biquad-based EQ filter function
%
% The mapping from cut-off frequency and Q to filter coefficients are based
% on ''Cookbook formulae for audio EQ biquad filter coefficient, R.
% Bristow-Johnson, http://www.musicdsp.org/files/Audio-EQ-Cookbook.txt"
%
% Version 0.1, Apr-11-2015 
%
% By Juhan Nam, KAIST
%


%
% cut-off freq: fc (Hz)
% AdB: gain (dB)
% bandwidth: Q 
% sampling rate: fs (Hz)
%

w0 = 2*pi*fc/fs;

G = sqrt( 10^(AdB/20) );
w0 = 2*pi*fc/fs;
alpha = sin(w0)/2/Q;

b0 = 1 + alpha*G;
b1 = -2*cos(w0);
b2 = 1 - alpha*G;

alpha = sin(w0)/2/Q;
a0 = 1 + alpha/G;
a1 = -2*cos(w0);
a2 = 1 - alpha/G;

B = [b0 b1 b2];
A = [a0 a1 a2];

y = filter(B,A,x);

