% AAE 575. HW 3. Rizwan Qureshi.
% PROBLEM 2 & 3:

clear all; clc; close all;

load dualfreq_sv1.mat;

sv_1_K_model = dualfreq;

GPS_t1 = sv_1_K_model(:,1);   % [secs]

sv_1_AZ = sv_1_K_model(:,2)/180;   % [Azimuth angle SC]
sv_1_EL = sv_1_K_model(:,3)/180;   % [Elevation angle. SC]

L1_P_range = sv_1_K_model(:,4);    % [meters] 
L2_P_range = sv_1_K_model(:,5);     % [meters] 

L1_C_phase = sv_1_K_model(:,6);   % [cycles]
L2_C_phase = sv_1_K_model(:,7);   % [cycles]

% Location of Receiver which is on the GROUND:
x_R = -1288337.0539;    % [meters]
y_R = -4721990.4483;   % [meters]
z_R = 4078321.6617;    % [meters]

%Determine Geodetic lat and longitude of Receiver:
lla  = ecef2lla([x_R, y_R, z_R]);
latitude_R = lla(1)/180;   % [SC units]
longitude_R = lla(2)/180;  % [SC]
height_R = lla(3);    % [meters]

% Determine Psi using Approximation:
psi_deg = [0.0137./(sv_1_EL+0.11)] - 0.022;

% Determine latitude of IPP:
phi_I_Deg = [latitude_R*ones(1,611)]' + [(psi_deg.*cosd(sv_1_AZ))]; % Latitude of IPP [deg]

% Determine longitude of IPP:
lamda_I_Deg = [longitude_R*ones(1,611)]' + [(psi_deg.*(sind(sv_1_AZ)))./cosd(phi_I_Deg)]; % Longitude of IPP [deg]

% Determine Geomagnetic latitude of the IPP:
phi_M_deg = phi_I_Deg + [0.064*cosd(lamda_I_Deg-1.617)];  %[deg]

%Now compute A2 and A4:

format long
%% A2 and A4 in radians. (Converted phi_M_deg into radians by diving 57.3:
% A2 =  [0.028e-6*(phi_M_deg/57.3).^0] + [-0.007e-6*(phi_M_deg/57.3).^1] + [-0.119e-6*(phi_M_deg/57.3).^2] + [0.119e-6*(phi_M_deg/57.3).^3];
% A4 =  [137.0e3*(phi_M_deg/57.3).^0] + [-49.0e3*(phi_M_deg/57.3).^1] + [-131.0e3*(phi_M_deg/57.3).^2] + [-262.0e3*(phi_M_deg/57.3).^3];

% A2 and A4 in SC units. Prof said the inputs MUST be in SC units:
A2 =  [0.028e-6*(phi_M_deg).^0] + [-0.007e-6*(phi_M_deg).^1] + [-0.119e-6*(phi_M_deg).^2] + [0.119e-6*(phi_M_deg).^3];
A4 =  [137.0e3*(phi_M_deg).^0] + [-49.0e3*(phi_M_deg).^1] + [-131.0e3*(phi_M_deg).^2] + [-262.0e3*(phi_M_deg).^3];


%% t: lamda_I_deg converted into radians:
% t = 43200*(lamda_I_Deg/57.3)+ GPS_t1;

%% t: lamda_I_deg must be in SC units as well then:

t = [43200*(lamda_I_Deg)]+ GPS_t1;

x = [2*pi*(t-50400)]./A4;

% delay_Z = 5e-9 + (A2.*cos(x));
delay_Z = 5e-9 + [A2.*(1- (x.^2)/2 + (x.^4)/24)];  %Gives same answer if using cos(x)!

% delay_Z = 5e-9;

% F = secd(asind(0.94792*cos(sv_1_EL)));

% F semi-circle model
F = 1.0 + (16*(0.53-sv_1_EL).^3);

Ionosphere_delay_K_model = F.* delay_Z;   % in [Seconds]
% 
figure(1)
plot(t,Ionosphere_delay_K_model)
xlabel('Apparent local time (seconds )')
ylabel('Delay due to Ionosphere (Seconds)')
title('Ionosphere delay using Klobuchar model ')
grid on

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Problem 3  %%%%%%%%%%%%%%%%%%%%%

c = 299792458;  % speed of light in [m/sec]
f_L1 = 1575.42e06;
f_L2 = 1227.60e06;

% A defined on slide W8&9-36. A = 40.3*TEC
A = [(f_L1^2*f_L2^2)/(f_L2^2-f_L1^2)]*[L1_P_range - L2_P_range]; % [m/sec^2]

% Use A to get delay: See formula on slide W8&9-26:
Dual_freq_delay = [1/(c*f_L1^2)]*A;   % [sec]

figure(2)
plot(t,Dual_freq_delay)
xlabel('Apparent local time (Hours)')
ylabel('Delay due to Ionosphere (Seconds)')
title('Pseudorange estimate of delay at L1')
grid on

figure(3)
plot(t,Ionosphere_delay_K_model,'r', 'linewidth', 1.5)
hold on
plot(t,Dual_freq_delay,'o')
xlabel('Apparent local time (seconds )')
ylabel('Ionosphere delay (Seconds)')
grid on
legend('Klobuchar model', 'Pseudorange estimate at L1')


figure(4)
plot(t,Ionosphere_delay_K_model,'r', 'linewidth', 1.5)
hold on
plot(t,Dual_freq_delay)
xlabel('Apparent local time (seconds )')
ylabel('Ionosphere delay (Seconds)')
title('Ionosphere delay computed with Klobuchar model & Pseudorange measurements @ L1, L2:')
grid on
legend('Klobuchar model', 'Pseudorange estimate at L1')