function R = corr(bpsk,bpsk2)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Author: Josh Wildey
%  Class: AAE57500
%  Homework 1 - 9/23/2011
%
%  This function will autocorrelate a BPSK for -10 <= t <= 10 chips
%  with the option of cross correlating two BPSKs.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check if we're doing Auto Correlation or Cross Correlation
% Auto Correlation
R = zeros(1,length(1:1:21));
if exist('bpsk2','var') == 0
    % Auto Correlation Computation
    for t = -10:10
        if t < 0
            bpsk_delay = [bpsk(abs(t)+1:length(bpsk)) bpsk(1:abs(t))];
        else
            bpsk_delay = [bpsk(length(bpsk)-t+1:length(bpsk)) bpsk(1:length(bpsk)-t)];
        end
        R(t+11) = 1/length(bpsk)*sum(bpsk.*bpsk_delay);
    end
% Cross Correlation
else
    for t = -10:14
        if t<0
            bpsk_delay = [bpsk2(abs(t)+1:length(bpsk2)) bpsk2(1:abs(t))];
        else
            bpsk_delay = [bpsk2(length(bpsk2)-t+1:length(bpsk2)) bpsk2(1:length(bpsk2)-t)];
        end
        R(t+11) = 1/length(bpsk)*sum(bpsk.*bpsk_delay);
    end
end
