function gain = gain_curve(x, threshold_dB, ratio)
%
% gain curve for compressor
%
% x: input level in dB
% gain: gain in linear

gain = zeros(size(length(x)));

for i=1:length(x)        
    if x(i) > threshold_dB    
        gain_dB = (x(i)-threshold_dB)*(1/ratio-1);
    else
        gain_dB = 0;
    end
    gain(i) = power(10,gain_dB/20);
end
