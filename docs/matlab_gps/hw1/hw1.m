%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Homework 1
%  9/23/2011
%  AAE57500
%  Josh Wildey
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all
clc
 
% Problem 1
% Choose PRN 22 & 27
sv = [22 27];
% Generate C/A Code
ca = cacodegen(sv);
 
% Problem 2
% Get BPSK of C/A Code
bpsk = BPSK(ca);
% Auto correlation of PRN 22 for -10 chips <= t <= 10 chips
prn22_corr = corr(bpsk(1,:));
 
figure(1)
plot(-10:1:10,prn22_corr);
title('Autocorrelation of PRN 22'),xlabel('\tau'),ylabel('R_2_2')
 
prn22_p1 = max(prn22_corr(1:5));
prn22_p2 = min(prn22_corr(5:10));
prn22_p3 = max(prn22_corr(9:11));
 
% Auto correlation of PRN 27 for -10 chips <= t <= 10 chips
prn27_corr = corr(bpsk(2,:));
 
figure(2)
plot(-10:1:10,prn27_corr);
title('Autocorrelation of PRN 27'),xlabel('\tau'),ylabel('R_2_7')
 
prn27_p1 = min(prn27_corr(6:8));
prn27_p2 = max(prn27_corr(8:12));
 
% Cross correlation between PRN 22 & PRN 27 for -10 chips <= t <= 10 chips
prn2227_corr = corr(bpsk(1,:),bpsk(2,:));
 
figure(3)
plot(-10:1:14,prn2227_corr);
title('Cross Correlation between PRN 22 & PRN 27'),xlabel('\tau'),ylabel('R_2_2_-_2_7')
 
prn2227_p1 = max(prn2227_corr(1:10));
prn2227_p2 = max(prn2227_corr(10:19));
prn2227_p2 = min(prn2227_corr);