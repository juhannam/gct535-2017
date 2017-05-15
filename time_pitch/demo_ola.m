% Time stretching by OLA
%
% Version 0.1, May-9-2017 
%
% By Juhan Nam, KAIST
% 

% audio files

% singing
[x,fs]=audioread('suzanne.wav');  
x = x(:,1)';

% sine wave
%x = sin(2*pi*440*[0:fs-1]/fs);

% Parameters:
Sa = 1024;       % analysis hop size, Sa must be less than N
N = 2048;       % block length

% time stretching ratio
alpha = 1.5;      % 0.5 <= alpha <= 2

y = ola(x, Sa, N, alpha);
    
soundsc(y,fs);

%% pitch shifting without time stretch

y2 = resample(y,100,floor(alpha*100));
soundsc(y2, fs);
