%
% Biquad filter demo script
%

% user parameters
fc = 1000; % Hz
Q = 12; % dB
fs = 44100; % Hz
type='lowpass';

%% filter sweep

x = sinesweep(20,20000,2,44100,'exp');
%soundsc(x,44100);

[y, B, A] = biquad(x, type, fc, fs, Q);
%y = biquad(x, 'highpass', fc, fs, Q);
%y = biquad(x, 'bandpass', fc, fs, Q);
%y = biquad(x, 'notch', fc, fs, Q);
%soundsc(y,fs);

figure(1)

subplot(3,1,1);
plot(x);
set(gca, 'FontSize',15);
title('sine sweep: input');
subplot(3,1,2);
plot(y);
set(gca, 'FontSize',15);
title('sine sweep: output');
subplot(3,1,3);
plot(db(abs(y)+0.001));
ylim([-60 30]); 
set(gca, 'FontSize',15);
title('sine sweep: output (dB)');

%% frequency response

[H, w] = freqz(B, A, 2048);

figure(2);
semilogx(w/pi*fs/2, db(abs(H))); % log-scale in x-axis

xlim([0 fs/2]); ylim([-60 20]); 
grid;
xlabel('Frequency [Hz]');
ylabel('Amplitude response ');
set(gca, 'FontSize',15);
title('Amplitude response');

%% filter impulse response

x = zeros(1,100); x(1)= 1;

fc = 2000;
Q = 2;
fs = 44100;
y = biquad(x, 'lowpass', fc, fs, Q);
%y = biquad(x, 'bandpass', fc, fs, Q);

figure(3);
stem(y);
hold off;
ylim([-0.5 1.5]);
grid on;
set(gca, 'FontSize',15);
title('Impulse Response');

%% Sine-Analysis

x = sin(2*pi*f*[0:fs-1]/fs);
x = [zeros(1,100) x(1:500) zeros(1,200)];

y = biquad(x, type, fc, fs, Q);

figure(4);
plot(x);
hold on;
plot(y, 'g');
hold off;
ylim([-1.5 1.5]);
title('Sine Analysis');
set(gca, 'FontSize',15);
legend('input', 'output');
grid on;





