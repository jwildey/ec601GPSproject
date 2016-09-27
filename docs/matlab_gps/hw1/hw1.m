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
prn22_corr = corr(bpsk(1,:),bpsk(2,:));

% Auto correlation of PRN 27 for -10 chips <= t <= 10 chips


% Cross correlation between PRN 22 & PRN 27 for -10 chips <= t <= 10 chips