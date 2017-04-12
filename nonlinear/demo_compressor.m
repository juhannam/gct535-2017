% Compressor Example
%
% Version 0.1, May-13-2015 
%
% By Juhan Nam, KAIST
% 

% test input signal
fs = 8000;
fc = 100;
x = [0.1*sin(2*pi*fc*[0:fs-1]/fs) sin(2*pi*fc*[fs:2*fs-1]/fs) 0.1*sin(2*pi*fc*[2*fs:3*fs-1]/fs)];

% compressor parameters
attack_time = 0.001;
release_time = 0.05;
threshold_dB = -10; % thereshold
ratio = 10;

% envelope detector
env = envelope_detector (x, attack_time, release_time, fs);
env_dB = db(env+eps);

% computing gain
gain = gain_curve(env_dB, threshold_dB, ratio);

% applying gain
y = gain.*x;


%% plot the results

figure(1);
subplot(2,1,1);
plot(x);
hold on;
plot(env, 'g');
hold off;
legend('input','envelope'); 
ylim([-1.1 1.1]);
grid on

subplot(2,1,2);
plot(gain,'r');
hold on;
plot(y); 
hold off;
legend('gain','output');
ylim([-1.1 1.1]);
grid on

