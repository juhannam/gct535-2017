% sine_fun.m
%
% This scripts demonstrates how to create interesting sounds only with sinusoids 
% by exploiting digital artifacts. 
%
% Please, run each region separately by typing 'command+enter (MacOS)' or
% 'control+enter (Windows)' not to play all sounds continuously  !!!
%
% Version 0.1, Mar-25-2015: initial version 
% Version 0.2, Mar-5-2015: add aliasing and multiple sines  
%
% By Juhan Nam, KAIST
%

%% generate sinusoid

fs = 8000; % 8kHz
dur = 2;   % 2 second

f = 1000;   % Hz
n = [0:dur*fs-1];

x = sin(2*pi*f*n/fs);

soundsc(x,fs);

%% sine sweep (version 1) -- this is not correct, why?

fs = 8000;
dur = 2;
freq = linspace(220,4000,dur*fs);

n = [0:dur*fs-1];
x = sin(2*pi*freq.*n/fs);

soundsc(x,fs);


%%  sine sweep (version 2) -- this is the correct version.

fs = 8000;
dur = 2;
freq = linspace(220,4000,dur*fs);

n = [0:dur*fs-1];

phase = 0;
x = zeros(1,dur*fs);

for i=1:dur*fs
    phase = phase + 2*pi*freq(i)/fs;
    x(i) = sin(phase);
end

soundsc(x,fs);

%% sine with aliasing 

fs = 8000;
dur = 2;
freq = linspace(220,16000,dur*fs);

n = [0:dur*fs-1];

phase = 0;
x = zeros(1,dur*fs);

for i=1:dur*fs
    phase = phase + 2*pi*freq(i)/fs;
    x(i) = sin(phase);
end

soundsc(x,fs);

%% multiple sines with aliasing 

fs = 8000;
dur = 2;
freq = linspace(220,16000,dur*fs);

n = [0:dur*fs-1];

phase = 0;
x = zeros(1,dur*fs);

for i=1:dur*fs
    phase = phase + 2*pi*freq(i)/fs;
    x(i) = sin(phase) + sin(2*phase) + sin(3*phase) + sin(4*phase) + sin(5*phase);
end

soundsc(x,fs);

%% sine with random frequency 

freq = [440:10:2000];
fs = 8000;
fc_rate = 0.1*fs;
dur = 2;

x = zeros(1,dur*fs);
phase = 0;

for i=1:dur*fs
    % update frequency
    if rem(i,fc_rate) == 1
        r = rand(1,1);
        f = freq(floor(r*length(freq))+1);
    end
    
    phase = phase + 2*pi*f/fs;
    x(i) = sin(phase);
end

soundsc(x,fs);

%%  sine with clipping 

fs = 8000;
dur = 2;
freq = linspace(220,220,dur*fs);

x = zeros(1,dur*fs);
phase = 0;

clip_max = 0.5;

for i=1:dur*fs
    phase = phase + 2*pi*freq(i)/fs;
    x(i) = sin(phase);
    
    % clipping
    if x(i) > clip_max
        x(i) = clip_max;
    elseif x(i) < -clip_max
        x(i) = -clip_max;
    end
end

soundsc(x,fs);
%%  sine sweep with clipping 

fs = 8000;
dur = 2;
freq = linspace(220,4000,dur*fs);

x = zeros(1,dur*fs);
phase = 0;

clip_max = 0.5;

for i=1:dur*fs
    phase = phase + 2*pi*freq(i)/fs;
    x(i) = sin(phase);
    
    % clipping
    if x(i) > clip_max
        x(i) = clip_max;
    elseif x(i) < -clip_max
        x(i) = -clip_max;
    end
end

soundsc(x,fs);

%% sine with random frequency and clipping 

freq = [440:10:2000];
fs = 8000;
fc_rate = 0.1*fs;
dur = 2;
clip_max = 0.2;
phase = 0;

x = zeros(1,dur*fs);

for i=1:dur*fs
    % update frequency
    if rem(i,fc_rate) == 1
        r = rand(1,1);
        f = freq(floor(r*length(freq))+1);
    end
    
    phase = phase + 2*pi*f/fs;
    x(i) = sin(phase);

    % clipping
    if x(i) > clip_max
        x(i) = clip_max;
    elseif x(i) < -clip_max
        x(i) = -clip_max;
    end

end

soundsc(x,fs);

%% quantization

f = 440; %880;  % 880
B = 4;  % number of bits
fs = 8000;
dur = 1;

x = zeros(1,dur*fs);
phase = 0;

for i=1:dur*fs  
    phase = phase + 2*pi*f/fs;
    x(i) = sin(phase);    
    
    % quantization
    x(i) = 2^(B-1)*x(i);
    x(i) = round(x(i));
    x(i) = x(i)/2^(B-1);    
end

soundsc(x,fs);

%% quantization +  dithering

x = zeros(1,dur*fs);

f = 440; %880;  % 880
B = 4;  % number of bits)
fs = 8000;
dur = 1;

phase = 0;
rand('seed',2);

white_noise = (rand(1,dur*fs)-0.5)/2;%sqrt(2);

for i=1:dur*fs     
    phase = phase + 2*pi*f/fs;
    x(i) = sin(phase);    
    
    x(i) = 2^(B-1)*x(i);
    
    % add white noise
    x(i) = x(i) + white_noise(i);

    % quantization
    x(i) = round(x(i));
    x(i) = x(i)/2^(B-1);
end

soundsc(x,fs);
