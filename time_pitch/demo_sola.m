% Time stretching by SOLA
%
% Version 0.1, May-10-2015 
%
% By Juhan Nam, KAIST
% 

% singing
[x,fs]=audioread('suzanne.wav');  

% drum
[x,fs]=audioread('drumloop1.wav'); 
%[x,fs]=audioread('jobs.wav'); 
[x,fs]=audioread('moore_guitar.wav'); 

x = x(:,1)';

% sine wave
%x = sin(2*pi*440*[0:fs-1]/fs);

% Parameters:
Sa = 1024;       % analysis hop size, Sa must be less than N
N = 2048;       % block length
L = 256;        % L must be chosen to be less than Ss

% time stretching ratio
alpha = 1.5;      % 0.5 <= alpha <2

y2 = sola(x, Sa, N, alpha, L);
    
soundsc(y2,fs);

%% pitch shifting without time stretch

y2 = resample(y,100,floor(alpha*100));
soundsc(y2, fs);
