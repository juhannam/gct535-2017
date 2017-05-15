% Time stretching by PSOLA
%
% Version 0.1, May-10-2015 
%
% By Juhan Nam, KAIST
% 

addpath(genpath('yin'));

file_name = 'suzanne.wav';

file_name = 'moore_guitar.wav';

%file_name = 'sin440_1sec.wav';

[x,fs]=audioread(file_name);

x = x(:,1);
%soundsc(x,fs);


% time stretching ratio
alpha = 1.5;

% pitch shifting ratio
beta = 1;

P.hop = 256;
P.wsize = 1024;

% pitch detection by YIN
warning off;
R = yin(file_name,P);
warning on;

% convert to Hertz 
f0 = 440.0 * 2.^ R.f0;
f0(isnan(f0)) = 0;

% find pitch mark
marks = findpitchmarks(x, fs, f0, R.hop, R.wsize);

% PSOLA
y = psola(x, marks, alpha, beta);

soundsc(y, fs);

