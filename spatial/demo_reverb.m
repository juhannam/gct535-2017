% input
[x,fs] = audioread('cello.wav');

%% IR
[h,fs2] = audioread('memchu_ir.wav');

plot(h, 'LineWidth',1);
set(gca,'FontSize', 15);
xlim([1 20000]);
%ylim([-0.8 0.8]);
title('Room Impulse Response');

% note that this convolution is slow!!!
tic
y1 = conv(x(:,1),h);
y2 = conv(x(:,2),h);
toc

y = [y1 y2];

soundsc(y,fs);