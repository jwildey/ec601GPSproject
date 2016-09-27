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


%Compute True Geometric range (r(t)):
r_true = sqrt([(ones(1,101)'*x_R - x_s).^2 + (ones(1,101)'*y_R - y_s).^2 + (ones(1,101)'*z_R - z_s).^2]) ;  % TRUE Geometric range [meters]

% TRUE Geometric range rate:
True_Geometric_range_rate = diff(r_true)./diff(GPS_t1);  % [m/sec]

% Ionosphere free pseudorange
rho_star = 2.546*L1_P_range - 1.546*L2_P_range;   % [meters]

% A value:
A=((1227.6e6^2)*(1575.42e6^2)/(1227.6e6^2-1575.42e6^2))*(L1_P_range-L2_P_range);

% Pseudorange: rho_L1
pseudorange_at_L1 = [rho_star] + [A./(1575.42e6^2)];    % same as given L1_P_range variable!. L1_P_range is = L2_P_range for all purposes

% Ionosphere free carrier phase
phi_star_L1 = [2.5457*L1_C_phase] - [1.9837*L2_C_phase];   %[cycles]

% %Carrier phase range @ L1:  JUSTIN proposed formula
% carrier_phase_range_L1 = lamda1* L1_C_phase;   %meters*cycles = [meters]

carrier_phase_range_L1 = lamda1* phi_star_L1;  % gives nearly SAME plot as Justin's formula

%Doppler range rate @ L1   JUSTIN proposed formula
doppler_range_rate_L1 = -lamda1*L1_D_freq;   % meters* cycles/sec = [meters/sec]

%phi_L1 range rate:
phi_L1_range_rate=(c/f1)*[diff(phi_star_L1)./diff(GPS_t1)];    %meters*(cyles/seconds) = [m/sec]

figure(1)
plot(GPS_t1,r_true,'r')
hold on
plot(GPS_t1,pseudorange_at_L1,'b')
plot(GPS_t1,-carrier_phase_range_L1,'k')
xlabel('GPS Time (seconds)')
ylabel('Range (meters)')
legend('True Geometric range', 'Pseudorange', 'Carrier-phase range')

figure(2)
plot(GPS_t1(2:101),True_Geometric_range_rate,'r')
hold on
plot(GPS_t1,doppler_range_rate_L1,'b')
plot(GPS_t1(2:101),phi_L1_range_rate,'k')
xlabel('GPS Time (seconds)')
ylabel('Range rate (meters/sec)')
legend('True Geometric range-rate','Doppler range-rate', 'Carrier Phase range-rate')
