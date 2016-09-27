%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Author: Josh Wildey
%  Class: AAE57500
%  Homework 2 - 10/17/2011
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all
clear all
clc

load hw2_data.mat
hw2_data = transpose(hw2_data);

%Initialize some variables
fdhat = 0;
taohat = 0;
fi = 1.405e6;
fs = 5.714286e6;
Ts = 1/fs;
fL1 = 1575.42e6;

%Generate C/A Codes
ca = cacodegen([22 27]);

%Generate time vectors
tv1023 = 0:1/1.023e6:.9999e-3;
tv5714 = 0:1/fs:.9999e-3;
t = 0:Ts:4.9996e-3;
tvrt = 0:1/50e6:.9999e-3;  %Real Time to produce solid line on graph

%Resample C/A codes to desired rates
ts1 = timeseries(ca,tv1023);
ts2 = resample(ts1,tv5714,'zoh');
tsrt = resample(ts1,tvrt,'zoh');
bpsk = BPSK(ts2.data(:,:));
bpsk = [bpsk bpsk bpsk bpsk bpsk];
bpskrt = BPSK(tsrt.data(:,:));

%IL & QL Calculation
Il22 = sqrt(2)*sin(2*pi*(fi+fdhat)*t).*bpsk(1,:);
Ql22 = sqrt(2)*cos(2*pi*(fi+fdhat)*t).*bpsk(1,:);

Il27 = sqrt(2)*sin(2*pi*(fi+fdhat)*t).*bpsk(2,:);
Ql27 = sqrt(2)*cos(2*pi*(fi+fdhat)*t).*bpsk(2,:);

Il22rt = sqrt(2)*sin(2*pi*(fi+fdhat)*tvrt(1:293)).*bpskrt(1,1:293);
Ql22rt = sqrt(2)*cos(2*pi*(fi+fdhat)*tvrt(1:293)).*bpskrt(1,1:293);

Il27rt = sqrt(2)*sin(2*pi*(fi+fdhat)*tvrt(1:293)).*bpskrt(2,1:293);
Ql27rt = sqrt(2)*cos(2*pi*(fi+fdhat)*tvrt(1:293)).*bpskrt(2,1:293);

%Plot the Inphase and Quadrature Signals
%PRN 22
figure(1)
subplot(2,1,1)
hold on
plot(tv5714(1:34),Il22(1:34),'*'),grid on
plot(tvrt(1:293),Il22rt,'g')
title('PRN: 22'),xlabel('Time (Sec)'),ylabel('I_L22')
hold off
subplot(2,1,2)
hold on
plot(tv5714(1:34),Ql22(1:34),'*'),grid on
plot(tvrt(1:293),Ql22rt,'g')
title('PRN: 22'),xlabel('Time (Sec)'),ylabel('Q_L22')
hold off

%PRN 27
figure(2)
subplot(2,1,1)
hold on
plot(tv5714(1:34),Il27(1:34),'*'),grid on
plot(tvrt(1:293),Il27rt,'g')
title('PRN: 27'),xlabel('Time (Sec)'),ylabel('I_L27')
hold off
subplot(2,1,2)
hold on
plot(tv5714(1:34),Ql27(1:34),'*'),grid on
plot(tvrt(1:293),Ql27rt,'g')
title('PRN: 27'),xlabel('Time (Sec)'),ylabel('Q_L27')
hold off

%Homework 2 Problem 2

fd = -6e3:100:6e3;
for n = 1:length(fd)
    hw2Il22(n,:) = sqrt(2)*sin(2*pi*(fi+fd(n))*t).*bpsk(1,:);
    hw2Ql22(n,:) = sqrt(2)*cos(2*pi*(fi+fd(n))*t).*bpsk(1,:);

    hw2Il27(n,:) = sqrt(2)*sin(2*pi*(fi+fd(n))*t).*bpsk(2,:);
    hw2Ql27(n,:) = sqrt(2)*cos(2*pi*(fi+fd(n))*t).*bpsk(2,:);
    
    [R_I_prn22(n,:), I22_lag] = circcorr(hw2_data,hw2Il22(n,:),Ts);
    [R_Q_prn22(n,:), Q22_lag] = circcorr(hw2_data,hw2Ql22(n,:),Ts);
    
    [R_I_prn27(n,:), I27_lag] = circcorr(hw2_data,hw2Il27(n,:),Ts);
    [R_Q_prn27(n,:), Q27_lag] = circcorr(hw2_data,hw2Ql27(n,:),Ts);
end

Z_prn22 = sqrt(R_I_prn22.^2 + R_Q_prn22.^2);
Z_prn27 = sqrt(R_I_prn27.^2 + R_Q_prn27.^2);
[m n] = size(Z_prn22);
for c = 1:m
    max_Z_prn22(c,:) = max(Z_prn22(c,:));
    max_Z_prn27(c,:) = max(Z_prn27(c,:));
end

% Find Doppler Shift Frequency by finding max of Z and its index
[a22 i22] = max(max_Z_prn22);
[a27 i27] = max(max_Z_prn27);

prn22_dop_lag = fd(i22)
prn27_dop_lag = fd(i27)

% Find Time Delay by finding max of Z at the doppler frequency shift and
% its index
[b22 j22] = max(Z_prn22(i22,:));
[b27 j27] = max(Z_prn27(i27,:));

prn22_t_lag = (j22-14285)*Ts
prn27_t_lag = (j27-14285)*Ts

%Plot the Doppler Shift for PRN 22
figure(3)
plot(fd,max_Z_prn22)
title('Max Magnitude of Z for each Doppler Shift from -6kHz to 6kHz for PRN 22')
xlabel('Doppler Frequency')
ylabel('Max Magnitude from Ambiguity Fcn')

%Plot the Time Delay for PRN 22
figure(4)
plot(I22_lag/Ts,Z_prn22(i22,:))
title('Cross Correlation of Locally Generated Signal and Sample for PRN 22 at estimated Doppler Shift')
xlabel('Delay Range (-14285 to 14285)')
ylabel('Magnitude of Z at Doppler Shift')

%Plot the Doppler Shift for PRN 27
figure(5)
plot(fd,max_Z_prn27)
title('Max Magnitude of Z for each Doppler Shift from -6kHz to 6kHz for PRN 27')
xlabel('Doppler Frequency')
ylabel('Max Magnitude from Ambiguity Fcn')

%Plot the Time Delay for PRN 27
figure(6)
plot(I22_lag/Ts,Z_prn27(i27,:))
title('Cross Correlation of Locally Generated Signal and Sample for PRN 27 at estimated Doppler Shift')
xlabel('Delay Range (-14285 to 14285)')
ylabel('Magnitude of Z at Doppler Shift')

%Calculate SNR and CR/No Ratio
SNR22 = a22/(mean(Z_prn22(i22,:)))
SNR27 = a27/(mean(Z_prn27(i27,:)))

No22 = a22/SNR22*5e-3;
No27 = a27/SNR27*5e-3;

CrNo_rat22 = a22/No22
CrNo_rat27 = a27/No27
