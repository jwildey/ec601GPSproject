% AAE 575. HW 3. Rizwan Qureshi.
% PROBLEM 1:

clear all; clc; close all;

load orbit0_sv_13.mat;
load rawdata_sv_13.mat;

c = 299792458;  % speed of light in [m/sec]
f1 = 1575.42e06;
f2 = 1227.60e06;
lamda1 = c/(1575.42e06);
lamda2 = c/(1227.60e06);

orbit_sv_13 = orbit0;
raw_data_sv_13 = rawdata;

GPS_t1 = raw_data_sv_13(:,1);   % [secs]

L1_P_range = raw_data_sv_13(:,2);   % [meters]
L2_P_range = raw_data_sv_13(:,3);   % [meters]
L1_C_phase = raw_data_sv_13(:,4);    % [cycles]  
L2_C_phase = raw_data_sv_13(:,5);    % [cycles]  
L1_D_freq = raw_data_sv_13(:,6);    % [Hz]   [i.e. cycles/second]
L2_D_freq = raw_data_sv_13(:,7);    % [Hz]

% Time when satellite PRN13 is tracked
GPS_t2 = orbit_sv_13(:,1);   % [secs]. GPS_t1 = GPS_t2

% Satellite PRN 13's x,y,z position coordinates:
x_s = orbit_sv_13(:,2);   % [meters]
y_s = orbit_sv_13(:,3);   % [meters]
z_s = orbit_sv_13(:,4);   % [meters]

% Location of Receiver which is on the GROUND:
x_R = -1288337.0539;    % [meters]
y_R = -4721990.4483;   % [meters]
z_R = 4078321.6617;    % [meters]


% 
% phi_star_L1 = f1^2/(f1^2-f2^2)*phi_L1 - f1*f2/(f1^2-f2^2)*phi_L2 
% or
% phi_star_L1 = 2.5457*phi_L1 - 1.9837*phi_L2; 

% PART 1:

%Compute True Geometric range (r(t)):
r_true = sqrt([(ones(1,101)'*x_R - x_s).^2 + (ones(1,101)'*y_R - y_s).^2 + (ones(1,101)'*z_R - z_s).^2]) ;  % TRUE Geometric range [meters]

% TRUE Geometric range rate:
True_Geometric_range_rate = diff(r_true)./diff(GPS_t1);  % [m/sec]

% Ionosphere free pseudorange
rho_star_R = 2.546*L1_P_range - 1.546*L2_P_range;   % [meters]

% A value:
A=((1227.6e6^2)*(1575.42e6^2)/(1227.6e6^2-1575.42e6^2))*(L1_P_range-L2_P_range);

% Pseudorange: rho_L1
pseudorange_at_L1 = [rho_star_R] + [A./(1575.42e6^2)];    % same as given L1_P_range variable!. L1_P_range is = L2_P_range for all purposes

% Ionosphere free carrier phase
phi_star_L1 = [2.5457*L1_C_phase] - [1.9837*L2_C_phase];   %[cycles]

% %Carrier phase range @ L1:
carrier_phase_range_L1 = lamda1* phi_star_L1;  % gives nearly SAME plot as Justin's formula

%Doppler range rate @ L1   JUSTIN proposed formula
doppler_range_rate_L1 = -lamda1*L1_D_freq;   % meters* cycles/sec = [meters/sec]

%phi_L1 range rate:
phi_L1_range_rate=(c/f1)*[diff(phi_star_L1)./diff(GPS_t1)];    %meters*(cyles/seconds) = [m/sec]

% phi_L1_range_rate=(c/f1)*[diff(L1_C_phase)./diff(GPS_t1)];  % gives SAME thing if I use phi_star_L1 !!!


% Part 2:

% Frequency bias for L1 and L2: Formula from slide W7-17: solve for f_b_s:

f_L1_bias = -L1_D_freq(1:length(True_Geometric_range_rate)) -True_Geometric_range_rate/lamda1;
f_L2_bias = -L2_D_freq(1:length(True_Geometric_range_rate)) -True_Geometric_range_rate/lamda2;

%Line of sight velocity for frequency bias L1 and L2
% L_of_sight_L1=f_L1_bias/f1;
% L_of_sight_L2=f_L2_bias/f2;

L_of_sight_L1=lamda1*f_L1_bias;    %[m/sec]
L_of_sight_L2=lamda2*f_L2_bias;   %[m/sec]


%Part 3:   

% Formula from 'Observables' PDF doc in 'PROBLEM 1' folder. See LAST page of 'Observables' PDF doc:

format long
% Receiver clock bias from pseudorange
receiver_bias_pseudo_r= [rho_star_R - r_true]/c;  % Solve for 'delta_t' [bias in seconds]
Receiver_clock_bias_rate=diff(receiver_bias_pseudo_r)./diff(GPS_t1);  %[dimensionless]


%Part 4: 

% Formula from 'GPS_Observables' PDF doc in 'PROBLEM 1' folder. See LAST page of 'Observables' PDF doc:

%Receiver clock bias from ionosphere-free carrier phase:

receiver_bias_carrier_phase = (1/f1)*[phi_star_L1 - r_true/lamda1];  % Solve for 'delta_t' [bias in seconds]
receiver_clock_biase_rate_phi = diff(receiver_bias_carrier_phase)./diff(GPS_t1);   % [dimensionless]

%Part 1:
figure(9)
plot(GPS_t1,r_true,'r')
hold on
plot(GPS_t1,pseudorange_at_L1,'b')
plot(GPS_t1,carrier_phase_range_L1,'k')
xlabel('GPS Time (seconds)')
ylabel('Range (meters)')
title('True Range vs GPS measured range')
legend('True Geometric range', 'Pseudorange', 'Carrier-phase range')
grid on

figure(10)
plot(GPS_t1(2:101),True_Geometric_range_rate,'r')
hold on
plot(GPS_t1,doppler_range_rate_L1,'b')
plot(GPS_t1(2:101),phi_L1_range_rate,'k')
xlabel('GPS Time (seconds)')
ylabel('Range rate (meters/sec)')
title('True Range-rate vs GPS measured range-rate')
legend('True Geometric range-rate','Doppler range-rate', 'Carrier Phase range-rate')
grid on

% Part 2:
figure(11)
plot(GPS_t1(1:100),f_L1_bias,'r')
hold on
plot(GPS_t1(1:100),f_L2_bias,'b')
title('Doppler Frequency Bias of L1 and L2')
xlabel('GPS time (sec)')
ylabel('Frequency (Hz)')
legend('Frequency bias in L1 Doppler', 'Frequency bias in L2 Doppler')
grid on

figure(12)
plot(GPS_t1(1:100),L_of_sight_L1,'r')
hold on
plot(GPS_t1(1:100),L_of_sight_L2,'b')
title('line-of-sight velocity bias for doppler Frequency Bias of L1 and L2')
xlabel('GPS time (sec)')
ylabel('Line-of-sight velocity (m/s)')
legend('Line of sight velocity bias for L1', 'Line of sight velocity bias for L2')
grid on

% 
%Part 3:
figure(13)
plot(GPS_t1,receiver_bias_pseudo_r,'r')
title('Receiver clock bias from ionosphere-free pseudorange measurement')
xlabel('GPS time (sec)')
ylabel('Receiver clock bias (seconds)')
grid on


figure(14)
plot(GPS_t1(1:100),Receiver_clock_bias_rate,'r')
title('Receiver Clock bias rate from ionosphere-free pseudorange measurement')
xlabel('GPS time (sec)')
ylabel('dimensionless quantity')
grid on

figure(15)
plot(GPS_t1(1:100),f_L1_bias,'r')
hold on
plot(GPS_t1(1:100),f1*Receiver_clock_bias_rate,'b')
title('Comparison of Receiver clock bias rate from iono-free pseudorange with Doppler frequency bias of L1')
xlabel('GPS time (sec)')
ylabel('[Hz]')
grid on
legend('Frequency bias in L1 Doppler', 'clock bias rate*(c/lamda_L_1)')

figure(16)
plot(GPS_t1(1:100),f_L2_bias,'r')
hold on
plot(GPS_t1(1:100),f2*Receiver_clock_bias_rate,'b')
title('Comparison of Receiver clock bias rate from iono-free pseudorange with Doppler frequency bias of L2')
xlabel('GPS time (sec)')
ylabel('[Hz]')
grid on
legend('Frequency bias in L2 Doppler', 'clock bias rate*(c/lamda_L_2)')

%Part 4:
figure(17)
plot(GPS_t1,receiver_bias_pseudo_r,'r')
hold on
plot(GPS_t1,receiver_bias_carrier_phase,'b')
title('Receiver clock bias from ionosphere-free pseudorange vs. ionosphere-free carrier phase measurement')
xlabel('GPS time (sec)')
ylabel('Receiver clock bias (seconds)')
legend('Receiver clock bias using ionosphere-free pseudorange','Receiver clock bias using ionosphere-free carrier phase')
grid on

figure(18)
plot(GPS_t1(1:100),f_L1_bias,'r')
hold on
plot(GPS_t1(1:100),f1*Receiver_clock_bias_rate,'b')
plot(GPS_t1(1:100),f1*receiver_clock_biase_rate_phi,'k')
title('Comparison of Receiver clock bias rate from iono-free pseudorange & iono-free carrier-phase with Doppler frequency bias of L1')
xlabel('GPS time (sec)')
ylabel('[Hz]')
grid on
legend('Frequency bias in L1 Doppler', 'Receiver clock bias rate*(c/lamda_L_1) from iono-free pseudorange','Receiver clock bias rate*(c/lamda_L_1) from iono-free carrier-phase')

figure(19)
plot(GPS_t1(1:100),f_L2_bias,'r')
hold on
plot(GPS_t1(1:100),f2*Receiver_clock_bias_rate,'b')
plot(GPS_t1(1:100),f2*receiver_clock_biase_rate_phi,'k')
title('Comparison of Receiver clock bias rate from iono-free pseudorange & iono-free carrier-phase with Doppler frequency bias of L2')
xlabel('GPS time (sec)')
ylabel('[Hz]')
grid on
legend('Frequency bias in L2 Doppler', 'Receiver clock bias rate*(c/lamda_L_2) from iono-free pseudorange','Receiver clock bias rate*(c/lamda_L_2) from iono-free carrier-phase')

