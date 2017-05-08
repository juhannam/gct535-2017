% demo_fm.m
%
% Version 0.1, Apr-28-2015 
% Version 0.2, Apr-12-2017 
%
% By Juhan Nam, KAIST
%

%% generic FM

fs = 44100;
fc = 440;
fm = 220;
dur = 5;
t = 0:1/fs:dur;

attack = linspace(0,1,round(fs*0.01));
decay = logspace(log10(1), log10(eps), length(t));
env = [attack decay];

beta = 10;
t = [0:length(env)-1]/fs;
x = env.*sin(2*pi*fc*t + beta.*sin(2*pi*fm*t));

soundsc(x,fs);

%% bell (inharmonic): JC's Formulae

fs = 44100;
fc = 200;
fm = 280;
beta_max = 10;

dur = 5;
t = 0:1/fs:dur;

env = logspace(log10(1), log10(0.01), length(t)); %0.95*exp(-t/T60);
beta = beta_max.*env;

y = env.*sin(2*pi*fc*t + beta.*sin(2*pi*fm*t));

soundsc(y, fs);

%% Wood (inharmonic): JC's Formulae

fs = 44100;
fc = 80;
fm = 55;
beta_max = 25;

dur = 0.2;
t = 0:1/fs:dur;

env = logspace(log10(1), log10(0.01), length(t));

beta_env = 1.0 - t./(0.2*dur);
beta_env = beta_env .* (1.0 + sign(beta_env))/2.0;
beta = beta_max.*beta_env;

y = env.*sin(2*pi*fc*t + beta.*sin(2*pi*fm*t));

soundsc(y, fs);

%% Brass : JC's Formulae

fs = 44100;
fc = 440;
fm = 440;
beta_max = 5;

dur = 1.0;
t = 0:1/fs:dur;

env = [linspace(0, 1, fs*0.1) ...
       linspace(1, 0.8, fs*0.1) ...
       linspace(0.8, 0.8, fs*0.7) ...
       linspace(0.8, 0, fs*0.1+2)];

beta = beta_max*env;

y = env.*sin(2*pi*fc*t + beta.*sin(2*pi*fm*t));
%plot(env)
soundsc(y, fs);

%%


