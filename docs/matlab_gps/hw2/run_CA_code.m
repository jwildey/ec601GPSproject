% Rizwan Qureshi. AAE 575:
% HW 2

clear; clc; close all;

% sv: Is a row or column vector of the SV's to be generated.
% Valid entries are 1 to 37.
% In this HW it is PRN 22 and PRN 27:

% fs: optional number of samples per chip (defaults to 1), fractional samples allowed, must be 1 or greater.

sv = [22 27];

% fs = 1;   % For HW 1, fs = 1 since # of samples per chip is 1, hence default fs = 1.
% fs = 1.023/1.023;   % This is fs = 1. In HW 1, our sampling frequency was 1.023 Mhz

% HW 2. Sampling frequency is 5.714286 Mhz.

fs = 5.714286/1.023;   % sample rate at 5.714286 Mhz

% call on C/A function to generate the PRN codes:
% function G=CACODE(SV,FS) generates 1023 length C/A Codes for GPS PRNs 1-37

 g = cacode_original(sv, fs)';

C_A_prn_22_signal = g(:,1);     % C/A code for PRN 22
C_A_prn_27_signal = g(:,2);    % C/A code for PRN 27


% Now convert C/A PRN 22 signal into BPSK modulation (i.e. covert 0's, 1's into
% 1's and -1's :

PRN_22 = g(:,1);    % C/A code for PRN_22

n = 1;
while n <= length(PRN_22)
    if PRN_22(n) == 0
        PRN_22(n,:) = 1;
    elseif PRN_22(n) == 1
        PRN_22(n,:) = -1;
    end
    PRN_22(n,:);            % Modulated BPSK PRN_22
    n = n+1;
end

% Now convert C/A PRN 27 signal into BPSK modulation (i.e. covert 0's, 1's into
% 1's and -1's :

PRN_27 = g(:,2);     % C/A code for PRN_27

m = 1;
while m <= length(PRN_27)
    if PRN_27(m) == 0
        PRN_27(m,:) = 1;
    elseif PRN_27(m) == 1
        PRN_27(m,:) = -1;
    end
    PRN_27(m,:);            % Modulated BPSK PRN_27
    m = m+1;
end


%%%%%%%%%%%%%%%%%%%%%%%%% HW 2 Problem 1: %%%%%%%%%%%%%%%%%%%%%%%%%:


% Ts = 1/(1.023e6);   % This is Tc = sample period (i.e. duration of 1 chip) or chip period.

Ts = 1/(5.714286e6);

Prn_22_5_cyc = [PRN_22;PRN_22;PRN_22;PRN_22;PRN_22];  % BPSK modulated
Prn_27_5_cyc = [PRN_27;PRN_27;PRN_27;PRN_27;PRN_27]; % BPSK modulated

t = 0:Ts:0.005;

new_t = t(1:28570)';   %column vector

FI = 1.405e6;

%For PRN 22:
I_L = sqrt(2)*sin(2*pi*(FI)*new_t).*Prn_22_5_cyc;  
I_Q = sqrt(2)*cos(2*pi*(FI)*new_t).*Prn_22_5_cyc;

%For PRN 27:
I_L_27 = sqrt(2)*sin(2*pi*(FI)*new_t).*Prn_27_5_cyc;
I_Q_27 = sqrt(2)*cos(2*pi*(FI)*new_t).*Prn_27_5_cyc;

% HW 2 Problem 1 plots:

% figure(1)
% plot(new_t,I_L,'ob')
% axis([0 5e-6 -2 2])
% grid on
% title('IL(t) generated for PRN 22:')
% xlabel('Time (seconds)')
% ylabel('IL(t) for PRN 22')
% 
% 
% figure(2)
% plot(new_t,I_Q,'ob')
% axis([0 5e-6 -2 2])
% grid on
% title('IQ(t) generated for PRN 22:')
% xlabel('Time (seconds)')
% ylabel('IQ(t) for PRN 22')
% 
% figure(3)
% plot(new_t,I_L_27,'ob')
% axis([0 5e-6 -2 2])
% grid on
% title('IL(t) generated for PRN 27:')
% xlabel('Time (seconds)')
% ylabel('IL(t) for PRN 27')
% 
% figure(4)
% plot(new_t,I_Q_27,'ob')
% axis([0 5e-6 -2 2])
% grid on
% title('IQ(t) generated for PRN 27:')
% xlabel('Time (seconds)')
% ylabel('IQ(t) for PRN 27')


% Load down_converted signal from text file provided by prof:

%x_i = load('hw2_data.txt');  % downconverted signal
load hw2_data.mat
x_i = hw2_data;


%%%%%%%%%%%%%%%%%%%%%%%% HW 2: Problem 2: %%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%% Search for PRN 22:

z = 1;
 
for fd = [-3*1000:100:3*1000];  % search from -15 to 15 Khz

I_22(:,z) = [sqrt(2)*sin(2*pi*(FI + fd)*new_t).*Prn_22_5_cyc];   % col vector
Q_22(:,z) = [sqrt(2)*cos(2*pi*(FI + fd)*new_t).*Prn_22_5_cyc];

[R_I_22, I_lag] = circcorr(x_i, I_22(:,z), Ts);
[R_Q_22, Q_lag] = circcorr(x_i, Q_22(:,z), Ts);

R_I_out(z,:)= R_I_22;   % 26 x 28570
R_Q_out(z,:)= R_Q_22;    %

% I_lag_out(z,:) = I_lag; % No need for this. All rows are same. Use I_lag
% Q_lag_out(z,:) = Q_lag; % No need for this. All rows are same. Use Q_lag

% Z_mag_loop(z,:) = sqrt(R_I_out(z,:).^2 + R_Q_out(z,:).^2);


z = z+1;
end

Z_mag_prn_22 = sqrt(R_I_out.^2 + R_Q_out.^2);  %magnitude of ambiguity function 
figure(6)
surf(Z_mag_prn_22)

% Find maximum value within the Z_magnitude matrix: 

n = 1;
while n <= 61;
max_of_Z(n,:) = max(Z_mag_prn_22(n,:));
n= n+1;
end

%find index within max_of_Z array where Z_max occurs:

max_in_max_of_Z =  max(max_of_Z);
a = max_in_max_of_Z;
k = 0;
 for n = 1:length(max_of_Z)
     if max_of_Z(n)>= a
          k = k+1;
         index_22(k) = n;
     end
 
 end
    
lag_new = I_lag/(Ts);

indexes_22 = find(max_of_Z>=a);

% Plot fd_range vs max_of_Z and plot cross-correlation for Z_max (when Z_max = 0.07251) vs lag range:

fd_range = [-3*1000:100:3*1000];
fd_range(indexes_22)

figure(1)
plot(fd_range,max_of_Z)
title('Maximum magnitudes of Z corresponding to EACH test Doppler frequency that has range from -3000 Hz to +3000 Hz for PRN 22:')
xlabel('Range of Doppler frequency from -3000 Hz to +3000 Hz')
ylabel('Maximum magnitudes from Z matrix for every test Doppler frequency ')

figure(2)
plot(lag_new,Z_mag_prn_22(41,:))
title('Cross-correlation plots for magnitude of Z Vs. delay range corresponding to Maximum value of Z = 0.07251 for PRN 22: (Doppler frequency = 1 Khz) ')
xlabel('Delay range from -14285 to +14285')
ylabel('Maximum magnitudes from Z matrix for every test Doppler frequency ')

%% chip_delay_for_max_Z = find(Z_mag_prn_22(11,:)>=0.0725); % gives chip lag of 12091 lag in chips corresponding to Z_max = 0.0725 
% 

% figure(1)
% plot(lag_new,Z_mag_prn_22(11,:))
% xlabel('Lag (Chips)')
% ylabel('Magnitude of Z:')
% title('Maximum Magnitude of Ambiguity function Z vs. delay in Chips for PRN 22:')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%% Search for PRN 27:

w = 1;

for fd = [-3*1000:100:3*1000];  % search from -3 to 3 Khz

I_27(:,w) = sqrt(2)*sin(2*pi*(FI+ fd)*new_t).*Prn_27_5_cyc;
Q_27(:,w) = sqrt(2)*cos(2*pi*(FI + fd)*new_t).*Prn_27_5_cyc;

[R_I_27, I_lag_27] = circcorr(x_i, I_27(:,w), Ts);
[R_Q_27, Q_lag_27] = circcorr(x_i, Q_27(:,w), Ts);

R_I_out_27(w,:)= R_I_27;   %
R_Q_out_27(w,:)= R_Q_27;    %

% I_lag_out(w,:) = I_lag_27; % No need for this. All rows are same. Use I_lag
% Q_lag_out(w,:) = Q_lag_27; % No need for this. All rows are same. Use Q_lag

% Z_mag_loop_27(w,:) = sqrt(R_I_out_27(w,:).^2 + R_Q_out_27(w,:).^2);

w = w+1;

end

Z_mag_prn_27 = sqrt(R_I_out_27.^2 + R_Q_out_27.^2);  %magnitude of ambiguity function 

% Find maximum value within the Z_magnitude matrix:

n = 1;
while n <= 61;
max_of_Z_27(n,:) = max(Z_mag_prn_27(n,:));
n= n+1;
end

%find index within max_of_Z_27 array where Z_max occurs:

max_in_max_of_Z_27 =  max(max_of_Z_27);
b = max_in_max_of_Z_27;
k = 0;
 for n = 1:length(max_of_Z_27)
     if max_of_Z_27(n)>= b
          k = k+1;
         index_27(k) = n;
     end
 
 end
    

indexes_27 = find(max_of_Z_27>=b);

lag_new_27 = I_lag_27/(Ts);

% Plot fd_range vs max_of_Z and plot cross-correlation for Z_max (when Z_max = 0.0288) vs lag range:

fd_range = [-3*1000:100:3*1000];

figure(3)
plot(fd_range,max_of_Z_27)
title('Maximum magnitudes of Z corresponding to EACH test Doppler frequency that has range from -3000 Hz to +3000 Hz for PRN 27:')
xlabel('Range of Doppler frequency from -3000 Hz to +3000 Hz')
ylabel('Maximum magnitudes from Z matrix for every test Doppler frequency ')
% 
figure(4)
plot(lag_new_27,Z_mag_prn_27(8,:))
title('Cross-correlation plots for magnitude of Z Vs. delay range corresponding to Maximum value of Z = 0.0228 for PRN 27: (Doppler frequency = -2.3 Khz) ')
xlabel('Delay range from -14285 to +14285')
ylabel('Maximum magnitudes from Z matrix for every test Doppler frequency ')

% chip_delay_for_max_Z_27 = find(Z_mag_loop_27(208,:)>= 0.02589); % gives chip lag of 23390 lag in chips corresponding to Z_max = 0.0259

% figure(1)
% plot(lag_new_27,Z_mag_prn_22(11,:))
% xlabel('Lag (Chips)')
% ylabel('Magnitude of Z:')
% title('Maximum Magnitude of Ambiguity function Z vs. delay in Chips for
% PRN 22:') % gives chip lag of 12091 lag in chips corresponding to Z_max = 0.0725
