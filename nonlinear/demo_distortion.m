% Distortion Example
%
% Version 0.1, Apr-12-2015 
%
% By Juhan Nam, KAIST
% 

% guitar sample
[x,fs] = audioread('16054__lg__guitar-clean-rif.wav');
% soundsc(x,fs);

% applying gain
g = 100;
x2 = g*x;

% distortion curve
y = zeros(length(x2),1);
for i=1:length(x)
    if x2(i) < -1
        y(i) = -2/3;
    elseif x2(i) > 1
        y(i) = 2/3;
    else
        y(i) = x2(i) - x2(i)^3/3;
    end
end    

soundsc(y,fs);


