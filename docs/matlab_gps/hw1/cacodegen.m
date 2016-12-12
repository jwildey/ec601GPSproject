function ca = cacodegen(sv)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Author: Josh Wildey
%  Class: AAE57500
%  Homework 1 - 9/23/2011
%
%  This function will accept a SV ID and generate a 1023 chip C/A code for
%  the specified satellite.
%
%  Ex) For PRN 22 and 27:
%       g = cacodegen([22 27])
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Store G2i or value
ph_sel = [2 6;
          3 7;
          4 8;
          5 9;
          1 0;
          2 10;
          1 8;
          2 9;
          3 10;
          2 3;
          3 4;
          5 6;
          6 7;
          7 8;
          8 9;
          9 10;
          1 4;
          2 5;
          3 6;
          4 7;
          5 8;
          6 9;
          1 3;
          4 6;
          5 7;
          6 8;
          7 9;
          8 10;
          1 6;
          2 7;
          3 8;
          4 9;
          5 10;
          4 10;
          1 7;
          2 8;
          4 10];
         
% Initialize g1 and g2
% G1 LFSR: 1+ x^3 + x^10
s = [0 0 1 0 0 0 0 0 0 1];
n = length(s);
g1 = ones(1,n);
 
%G2 LFSR: 1 + x^2 + x^3 + x^6 + x^8 + x^9 + x^10
t = [0 1 1 0 0 1 0 1 1 1];
g2 = ones(1,n);
 
%Define variables for homework
chips = 2^n - 1;
ca = zeros(2,chips);
 
%Generate 1023 Chip long C/A Code
for cnt = 1:chips
    %G1 is the 10th bit
    g1out = g1(n);
    %G2 is the XOR of 2 chips chosen by the PRN/sv
    g2out = xor(g2(ph_sel(sv,1)),g2(ph_sel(sv,2)));
    
    %C/A Code is the XOR of g1out and g2out
    ca(:,cnt) = xor(g1out,g2out);
    
    %Shift G1 left by 1 and XOR chips 3 and 10
    g1 = [mod(sum(g1.*s),2) g1(1:9)];
    
    %Shift G2 left by 1 and XOR chips 2,3,6,8,9,10
    g2 = [mod(sum(g2.*t),2) g2(1:9)];
end

