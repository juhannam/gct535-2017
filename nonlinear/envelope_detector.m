function y = envelope_detector (x, attack_time, release_time, fs)

% A simple envelope detector using a leaky integrator
% 
% x: input signal
% attack_time (in second): control the sensitivity for increasing level
% release_time (in second): control the sensitivity for decreasing level
% 
%
% Version 0.1, May-13-2015 
%
% By Juhan Nam, KAIST


attack_coef = 1 - exp(-1/fs/attack_time);
release_coef = 1 - exp(-1/fs/release_time);

y = zeros(size(x));
y(1) = x(1);

for i=2:length(x)
    
    % Fullwave-rectification (abs)
    rectout = abs(x(i));
    
    % attack / release
    if rectout > y(i-1)
        y(i) = y(i-1) + attack_coef*(rectout-y(i-1));
    else
        y(i) = y(i-1) + release_coef*(rectout-y(i-1));
    end
end

