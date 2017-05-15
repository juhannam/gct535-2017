function overlap = sola(x, Sa, N, alpha, L)
% The following code is modified from the original MATLAB code provided
% with the DAFX book (2nd Edition).
%
% TimeScaleSOLA.m
% Authors: U. Z?lzer, G. De Poli, P. Dutilleux
% Time Scaling with Synchronized Overlap and Add
%
% Parameters:
%
% analysis hop size     Sa = 256 (default parameter)
% block length          N  = 2048 (default parameter)
% time scaling factor   0.25 <= alpha <= 2
% overlap interval      L  = 256*alpha/2
%
%--------------------------------------------------------------------------
% This source code is provided without any warranties as published in
% DAFX book 2nd edition, copyright Wiley & Sons 2011, available at
% http://www.dafx.de. It may be used for educational purposes and not
% for commercial applications without further permission.
%--------------------------------------------------------------------------

Ss = round(Sa*alpha);

% Segmentation into blocks of length N every Sa samples
% leads to M segments
M =	ceil(length(x)/Sa);

x(M*Sa+N)=0;
overlap = x(1:N);

for i=1:M-1
    % take a segment
    grain=x(i*Sa+1:N+i*Sa);
    
    % compute cross-correlation between overlapped regions
    x_corr_segment = xcorr(grain(1:L),overlap(i*Ss:i*Ss+(L-1)));
    [~, max_index] = max(x_corr_segment);
    
    % cross-fade gain
    fadeout=1:(-1/(length(overlap)-(i*Ss-(L-1)+max_index-1))):0;
    fadein=0:(1/(length(overlap)-(i*Ss-(L-1)+max_index-1))):1;
    
    % overlapped region
    Tail=overlap((i*Ss-(L-1))+ max_index-1:length(overlap)).*fadeout;
    Begin=grain(1:length(fadein)).*fadein;
    Add=Tail+Begin;

    overlap=[overlap(1:i*Ss-L+max_index-1) Add grain(length(fadein)+1:N)];
end

