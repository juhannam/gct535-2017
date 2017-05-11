% Time stretching by PSOLA
%
% Version 0.1, May-10-2015 
%
% By Juhan Nam, KAIST
% 

[x,fs] = audioread('PianoC4.wav');

soundsc(x,fs)

%% pitch-shifting with time-stretching by resampling


note = 2; % 0,1,2... 12 (semi-tone)

alpha = power(note,12/12);   % for equal temperament scale

y = resample(x,100,floor(alpha*100));
soundsc(y,fs)


%%

