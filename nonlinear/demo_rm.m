% demo_rm.m
%
% Version 0.1, Apr-28-2015 
% Version 0.2, Apr-12-2017 
%
% By Juhan Nam, KAIST
%

% input sound
[x_m,fs] = audioread('jobs.wav');
x_m = x_m(:,1);

% carrir oscillator
f0 = 200;
x_c = sin(2*pi*f0*[0:length(x_m)-1]'/fs);

% ring modulation
y = x_m.*x_c;

soundsc(y,fs);




