function bpsk = BPSK(cacode)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Author: Josh Wildey
%  Class: AAE57500
%  Homework 1 - 9/23/2011
%
%  This function will convert a binary C/A code to its BPSK
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

bpsk = zeros(size(cacode));
 
for i = 1:length(cacode)
    %For First row
    if cacode(1,i) == 0
        bpsk(1,i) = 1;
    else
        bpsk(1,i) = -1;
    end
    %For Second row
    if cacode(2,i) == 0
        bpsk(2,i) = 1;
    else
        bpsk(2,i) = -1;
    end
end
