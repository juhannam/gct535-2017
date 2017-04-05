function y = delay(x, delay_time, r, fs)
%
% A simple delay effect
% 
% - x: input signal
% - delay_time (in second): delay time
% - r: feedback gain
% - fs: sampling rate
%
% Version 0.1, May-16-2015 
%
% By Juhan Nam, KAIST


y = zeros(length(x),1);	

% length of delayline
MAX_DELAY_LENGTH = 44100*2;

% write pointer
wp = 1;

% length of delayline
delay_length = delay_time*fs;

% fill delayline with random noise
delayline = zeros(MAX_DELAY_LENGTH,1);

% feed-back loop
for n=1:length(x)

    % read sample
    op = wp - delay_length;
    if ( op < 1.00 )
        op = op + MAX_DELAY_LENGTH;
    end
    rp = floor(op);
    rp_frac = op - rp;
    
    if rp > MAX_DELAY_LENGTH
        rp = rp - MAX_DELAY_LENGTH;
    end
    
    % read sample using linear intepolation
    if (rp == MAX_DELAY_LENGTH) | (rp == 0)
        tap_out = (1-rp_frac)*delayline(MAX_DELAY_LENGTH) + rp_frac*delayline(1);
    else
        tap_out = (1-rp_frac)*delayline(rp) + rp_frac*delayline(rp+1);
    end
    
    % write output
    delayline(wp) = r*tap_out + x(n);
    
    % update write pointer
    wp = wp + 1;
    if wp > MAX_DELAY_LENGTH
        wp = 1;
    end
    
    y(n) = tap_out;
end



