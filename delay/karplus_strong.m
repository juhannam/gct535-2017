function y = karplus_strong(note, r, a, dur, fs)
%
% plucked string synthesis by the Karplus-Strong Algorithm
% 
% - note: note number
% - r: feedback gain, control the decay time
% - dur: duration of the note
% - fs: sampling rate
%
% Version 0.1, May-16-2015 
% Version 0.2, Apr-1-2017 : change f0 to MIDI note 
%
% By Juhan Nam, KAIST

f0 = 441*power(2,(note-69)/12);

sampling_len = round(dur*fs);
y = zeros(sampling_len,1);	

% length of delayline
MAX_DELAY_LENGTH = ceil(fs/20);

delay_length = fs/f0;

% write pointer
wp = 1;

% fill delayline with random noise
delayline = 2*rand(MAX_DELAY_LENGTH,1) - 1;

% delay element for lowpass filter
tap_out_z = 0;

% feed-back loop
for n=1:sampling_len

    % read sample
    op = wp - delay_length;
    if ( op < 1 )
        op = op + MAX_DELAY_LENGTH;
    end
    rp = floor(op);
    rp_frac = op - rp;
    
    % read sample using linear intepolation
    if rp == MAX_DELAY_LENGTH
        tap_out = (1-rp_frac)*delayline(MAX_DELAY_LENGTH) + rp_frac*delayline(1);
    else
        tap_out = (1-rp_frac)*delayline(rp) + rp_frac*delayline(rp+1);
    end

    % lowpass filter
    lp_out = a*tap_out+(1-a)*tap_out_z;
    tap_out_z = tap_out;
    
    delayline(wp) = r*lp_out;
    
    % update write pointer
    wp = wp + 1;
    if wp > MAX_DELAY_LENGTH
        wp = 1;
    end
    
    y(n) = lp_out;
end


