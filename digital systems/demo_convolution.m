% convolution.m
%
% This animation script illustrates the convolution operation
%
% Version 0.1, Mar-31-2015 
%
% By Juhan Nam, KAIST
%

clear all;

make_movie = 0;

x = [0.8 1.2 1.6 2.0];
h = [1.2 1.0 0.8];

L = length(x) + length(h) + 10;

init_delay = 2;
offset = length(x)- 1 + init_delay;

% impulse response for display
h_n = zeros(1,L);
h_n(offset + [1:length(h)]) = h;

% output for display
y_n = zeros(1,L);
y = zeros(1, length(x) + length(h)-1);


% for movie
figure(1);
subplot(3,1,1);
x_n = zeros(1,L);
x_n([1:length(x)])= x;
stem([1:L]-1, x_n, 'LineWidth',2);
xlim([-offset-2 10]); 
ylim([-1 5]); 
grid on;
title('x(n) = [0.8, 1.2, 1.6, 2.0]')
set(gca, 'FontSize',15);

subplot(3,1,2);
stem(-offset+[1:L]-1, h_n, 'g', 'LineWidth',2);
xlim([-offset-2 10]); 
ylim([-1 5]); 
grid on;
title('h(n) = [1.2, 1.0, 0.8]')
set(gca, 'FontSize',15);

if make_movie
    vidObj = VideoWriter('convolution_demo.mp4', 'MPEG-4');
    open(vidObj);
%     currFrame = getframe(gcf);
%     for k=1:10
%         writeVideo(vidObj,currFrame);
%     end
end

subplot(3,1,3);
for i=1:(L-length(x))
    % input for display
    x_n = zeros(1,L);
    x_n([1:length(x)]+i-1)= x(end:-1:1);  % flip it

    stem(-offset+[1:L]-1, x_n, 'LineWidth',2);
    hold on;
    stem(-offset+[1:L]-1, h_n, 'g', 'LineWidth',2);

    % convolution
    if i > init_delay
        y(i-init_delay) = sum(x_n.*h_n);
        y_n = zeros(1,L);
        y_n(offset + [1:length(y)]) = y;
    end    
    stem(-offset+[1:L]-1, y_n, 'r', 'LineWidth',2);
    
    hold off;
    xlim([-offset-2 10]); 
    ylim([-1 5]); 
    grid on;
    title('y(n)=[0.96, 2.24, 3.76, 4.96, 3.28, 1.60]')
    set(gca, 'FontSize',15);
    
    if make_movie
        currFrame = getframe(gcf);
        for k=1:24
            writeVideo(vidObj,currFrame);
        end
    else
        pause;
    end
end
hold off;


if make_movie
    close(vidObj);
end

