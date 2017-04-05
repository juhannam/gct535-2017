% Delay effect examples (also Karplus-Strong model as a side example)
%
% Version 0.1, May-16-2015 
% Version 0.2, Apr-5-2017 adding melody using Karplus-Strong algorithm 
% 
% By Juhan Nam, KAIST
% 


%% delay effect

addpath('/Users/juhannam/Google Drive/SoundClips/Courses/');

%[x,fs] = audioread('drumloop1.wav');  % tempo = 0.4 sec
%[x,fs] = audioread('suzanne.wav');
[x,fs] = audioread('Snare.wav');
%[x,fs] = audioread('PianoC4.wav');

x = x(:,1);

delay_time = 0.5;
r = 0.5;
x = [x; zeros(3*fs,1)];
y1 = delay(x, delay_time, r, fs);

soundsc(y1,fs);


%% chorus effect

%[x,fs] = audioread('drumloop1.wav');  % tempo = 0.4 sec
[x,fs] = audioread('AcousticGuitar.aif');

x = x(:,1);

delay_time = 0.03;
x = [x; zeros(3*fs,1)];

lfo.rate = 1.5;        % 1~2 Hz
lfo.depth = 0.001;   % 0.001 or around

y1 = chorus(x, delay_time, lfo, fs);

soundsc(x+y1,fs); % wet/dry: 50/50


%% flanger effect

%[x,fs] = audioread('../../Samples/AcousticGuitar.aif');
[x,fs] = audioread('drumloop1.wav');  % tempo = 0.4 sec

x = x(:,1);
x = [x; zeros(3*fs,1)];

static_delay = 0.02;
variable_delay = 0.0225;

lfo.rate = 0.1;        % 0.01 Hz
lfo.depth = 0.002;   % 0.001 or around

y1 = flanger(x, variable_delay, static_delay, lfo, fs);
soundsc(y1,fs);



%% plucked string by Karplus-Strong Algorithm
fs = 44100;

% from Yoon Sang's "Waiting for Happiness"
note = [69 76 76 69 67  74  72  65 69 72 72 71];
len = 0.28*[1  1  1  1  1.5 1.5 2  1  1  1  1.5 1.5];

x = [];
r = 0.995;
a = 0.7;
for i=1:length(note)
    temp = karplus_strong(note(i), r, a, len(i), fs);
    x = [x; temp];
end
soundsc(x,fs);

%% add flanger
static_delay = 0.02;
variable_delay = 0.025;

lfo.rate = 1;        % 0.01 Hz
lfo.depth = 0.002;   % 0.001 or around

y1 = flanger(x, variable_delay, static_delay, lfo, fs);

soundsc(y1,fs);


%% add delay
delay_time = 0.28;
r = 0.6;
y1 = [y1; zeros(3*fs,1)];
y2 = delay(y1, delay_time, r, fs);

soundsc(y2,fs);



