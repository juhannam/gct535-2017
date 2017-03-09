% Sampling_theorem.m
%
% This script illustrates sampling theorem with animation  
%
% "ratio" is defined as frequency of sampling rate over frequency of
% sinusoid. Select one of the ratio settings to see if they are aliased or not  
%
% Version 0.1, Mar-23-2015 
%
% By Juhan Nam, KAIST
%

% ratio = (frequency of sampling rate)/(frequency of sinusoid)

%ratio = 10;         % safely satisfties the sampling theorem
%ratio = 2.1;        % barely satisfties the sampling theorem
%ratio = 2;          % hmmm... no reconstruction
%ratio = 1.5;       % not satisfties the sampling theorem: opposite direction    
%ratio = 1.05;       % not satisfties the sampling theorem: opposite direction    
ratio = 1/1.05;     % not satisfties the sampling theorem: back to the same direction but slow

% (presumably) continusoid sinusids
T = 1000;
theta_a = 2*pi/T;
max_cycles = 20;
x_cos_a = cos([0:theta_a:2*pi*max_cycles]);
x_sin_a = sin([0:theta_a:2*pi*max_cycles]);

% initialize reconstructed sinusoid
recon_x = zeros(size(x_sin_a));

% initial plot
figure(1);
subplot(3,1,1)
grid on;
plot(x_cos_a,x_sin_a, 'LineWidth',2);
set(gca,'FontSize', 15);
xlim([-2.2 2.2]);
ylim([-1.1 1.1]);

subplot(3,1,2)
plot(x_sin_a, 'LineWidth',2);
set(gca,'FontSize', 15);

subplot(3,1,3)
plot(recon_x, 'LineWidth',2);
set(gca,'FontSize', 15);

acc_phase = 0;
time_counter = 1;

pause;

while acc_phase < (2*pi*max_cycles)
    subplot(3,1,1)
    plot(x_cos_a,x_sin_a, 'LineWidth',2);
    title('Sampled Sinusoid - Phasor View');
    set(gca,'FontSize', 15);
    xlim([-2.2 2.2]);
    ylim([-1.1 1.1]);
    hold on;
    grid on;
    plot(cos(acc_phase), sin(acc_phase),'or', 'LineWidth',4);
    hold off;

    subplot(3,1,2)
    hold on;
    grid on;
    plot(time_counter, sin(acc_phase), 'or', 'LineWidth',4);
    title('Sampled Sinusoid - Waveform View');
    set(gca,'FontSize', 15);
    ylim([-1.1 1.1]);
    hold off;

    % reconstruction with sinc function
    temp_sinc = sin(acc_phase)*sinc(([1:length(x_sin_a)]-time_counter)*ratio/T);
    recon_x = recon_x + temp_sinc;
    
    subplot(3,1,3)
    plot(recon_x, 'LineWidth',2);
    title('Reconstructed Sinusoid');
    set(gca,'FontSize', 15);
    ylim([-1.1 1.1]);
    grid on;
    
    % update
    time_counter = time_counter + T/ratio;
    acc_phase = acc_phase + (T/ratio)*theta_a;    

%    pause;  % if you want to make progress by clicking a key
    speed = 10;
    pause(1/speed);
end
