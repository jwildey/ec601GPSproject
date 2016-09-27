% HW 4 problem 1

clear all; clc; close all;

%====================== SV 3 =================================:


%Ephemeris data from 'Ephermis.dat' file for SV-3:


% % **** Week    114 ephemeris for SV- 3 ************

%  Eccentricity:                2.547537326E-03              e
%  Time of Applicability(s):    2.520000000E+05              TOE
%  Orbital Inclination(rad):    9.352987781E-01              I_0
%  Rate of Right Ascen(r/s):   -8.748578750E-09              OMEGA_DOT
%  SQRT(A) (m^1/2):             5.153688175E+03              SQRT_A
%  Right Ascen at TOA(rad):    -2.256728681E+00              OMEGA_0
%  Argument of Perigee(rad):    5.176493009E-01              OMEGA
%  Mean Anom(rad):              8.667702313E-01              M_0
%  mean motion diff(r/s):       5.394510616E-09              DELTA_N
%  Rate of inclin (r/s):        3.117986980E-10              I_DOT
%  lat cosine ampl (r):         4.906207323E-06              CUC
%  Lat sine ampl   (r):         4.069879651E-06              CUS
%  radius cos ampl (m):         2.845625000E+02              CRC
%  radius sin ampl (m):         9.250000000E+01              CRS
%  inclin cos ampl(r):          1.862645149E-08              CIC
%  inclin sin ampl(r):         -1.862645149E-09              CIS

format long

toe = 2.520000000e+05;  % [seconds]
e =  2.547537326e-03;
i_0 = 9.352987781e-01;   % [rad]
RAAN_dot = -8.748578750e-09;   %[rad/sec] 
sqrt_sma = 5.153688175e+03;   % [(m^1/2)]
lamda_0 = -2.256728681e+00;  % [rad]
AOP = 5.176493009e-01;   % [rad]
M_0 = 8.667702313e-01;  % [rad]
delta_N = 5.394510616e-09;   %[rad/sec] 
I_DOT = 3.117986980e-10; %[rad/sec] 

C_u_c = 4.906207323e-06;  % [rad]. Periodic cosine corrections to Argument of Latitude
C_u_s = 4.069879651e-06;  % [rad]. Periodic sine corrections to Argument of Latitude

C_r_c =  (2.845625000e+02)/1000;  % [km]. Periodic cosine corrections to orbit radius
C_r_s = (9.250000000e+01)/1000;  % [km]. Periodic sine corrections to orbit radius

C_i_c =   1.862645149e-08;  % [rad]. Periodic cosine corrections to orbit inclination
C_i_s = -1.862645149e-09;  % [rad]. Periodic sine corrections to orbit inclination


% Read Precise IGS data from excel spreadsheet:
[sv_3_IGS_data,titles] = xlsread('SV_3_IGS_data');



x_true_km = sv_3_IGS_data(:,6);
y_true_km = sv_3_IGS_data(:,7);
z_true_km = sv_3_IGS_data(:,8);

t = [172800:900:258300]';
t_k = [t - toe];

mu = 398600; % km^3/s^2
a = [sqrt_sma^2]/1000;   % now sma is in [Km]
n0 = sqrt(mu/(a^3));  % [ 1/sec]
n = n0 + delta_N;
Mk = (M_0 + n*t_k);   % [rad]
e = [e* ones(1,96)]'; 

Ek = kepler_E(e, Mk);  % [rad]
theta_k = 2*atan(sqrt((1+e)./(1-e)).*tan(Ek/2));  %[rad]

phi_k = theta_k + AOP;   % [rad]
delta_uk = C_u_s*sin(2*phi_k) + C_u_c*cos(2*phi_k);  % [rad]
delta_rk = C_r_s*sin(2*phi_k) + C_r_c*cos(2*phi_k);   % [km]
delta_ik = C_i_s*sin(2*phi_k) + C_i_c*cos(2*phi_k);   % [rad]

u_k = phi_k + delta_uk;    % [rad]
r_k = a*(1-e.*cos(Ek)) + delta_rk;   % [km]
i_k = i_0 + (I_DOT*t_k) + delta_ik;  % [rad]

% we = (2*pi)/86400;    % [rad/sec]
% we = 7.2921e-005;   % from Google
we = 7.2921150e-005;   % EXACT from Google. Full digits

lamda_k = lamda_0 + (RAAN_dot - we)*t_k - we*toe;

x_k = r_k.*cos(u_k);
y_k = r_k.*sin(u_k);
z_k = 0;

x_ecef_sv3 = x_k.*cos(lamda_k) - y_k.*cos(i_k).*sin(lamda_k);
y_ecef_sv3 = x_k.*sin(lamda_k)+ y_k.*cos(i_k).*cos(lamda_k);
z_ecef_sv3 = y_k.*sin(i_k);


%error in x_comp, y_comp, z_comp:
x_error_sv_3 = abs(x_ecef_sv3-x_true_km);   % [km]
y_error_sv_3 = abs(y_ecef_sv3-y_true_km);   % [km]
z_error_sv_3 = abs(z_ecef_sv3-z_true_km);   % [km]

figure(1)
plot(t,x_error_sv_3*1000)
xlabel('GPS time (seconds)')
ylabel('Error in X component of position (meters)')
title('Error over time for SV3')

figure(2)
plot(t,y_error_sv_3*1000)
xlabel('GPS time (seconds)')
ylabel('Error in Y component of position (meters)')
title('Error over time for SV3')

figure(3)
plot(t,z_error_sv_3*1000)
xlabel('GPS time (seconds)')
ylabel('Error in Z component of position (meters)')
title('Error over time for SV3')

R_true_magnitude_sv3 = sqrt(x_true_km.^2 + y_true_km.^2 + z_true_km.^2); % [km]
R_ecef_mag_sv3 = sqrt(x_ecef_sv3.^2 + y_ecef_sv3.^2 + z_ecef_sv3.^2);   % [km]

%error in position magnitude between R_true_sv3 and R_ecef_sv3:
error_in_position_mag_sv3 = abs(R_true_magnitude_sv3 - R_ecef_mag_sv3);

figure(4)
plot(t,error_in_position_mag_sv3*1000)
xlabel('GPS time (seconds)')
ylabel('Error in position magnitude (meters)')
title('Error over time for SV3')



% %====================== SV 5 =================================:
% 
% % *** Week    114 ephemeris for SV- 5 ************
% %  ID:                          5
% %  Eccentricity:                3.250250011E-03              e
% %  Time of Applicability(s):    2.087840000E+05              TOE
% %  Orbital Inclination(rad):    9.363323970E-01              I_0
% %  Rate of Right Ascen(r/s):   -8.031405763E-09              OMEGA_DOT
% %  SQRT(A) (m^1/2):             5.153571037E+03              SQRT_A
% %  Right Ascen at TOA(rad):     2.969759636E+00              OMEGA_0
% %  Argument of Perigee(rad):    4.894296521E-01              OMEGA
% %  Mean Anom(rad):             -2.098179373E+00              M_0
% %  mean motion diff(r/s):       4.731982806E-09              DELTA_N
% %  Rate of inclin (r/s):        4.857345429E-11              I_DOT
% %  lat cosine ampl (r):         1.855194569E-06              CUC
% %  Lat sine ampl   (r):         1.207739115E-05              CUS
% %  radius cos ampl (m):         1.338750000E+02              CRC
% %  radius sin ampl (m):         3.593750000E+01              CRS
% %  inclin cos ampl(r):         -4.284083843E-08              CIC
% %  inclin sin ampl(r):         -2.421438694E-08              CIS
% %  week:                         114
% %  t_gd:                       -4.190951586E-09              T_GD
% %  t_oc:                        2.087840000E+05              T_OC
% %  Af0(s):                      3.203805536E-04              af0
% %  Af1(s/s):                    1.477928890E-12              af1
% %  Af2(s/s/s):                  0.000000000E+00            
% 
toe =  2.087840000e+05;  % [seconds]
e =   3.250250011e-03;
i_0 =  9.363323970e-01;   % [rad]
RAAN_dot = -8.031405763e-09;   %[rad/sec] 
sqrt_sma = 5.153571037e+03;   % [(m^1/2)]
lamda_0 = 2.969759636e+00;  % [rad]
AOP = 4.894296521e-01;   % [rad]
M_0 = -2.098179373e+0;  % [rad]
delta_N = 4.731982806e-09;   %[rad/sec] 
I_DOT = 4.857345429e-11; %[rad/sec] 

C_u_c = 1.855194569e-06;  % [rad]. Periodic cosine corrections to Argument of Latitude
C_u_s = 1.207739115e-05;  % [rad]. Periodic sine corrections to Argument of Latitude

C_r_c =  (1.338750000e+02)/1000;  % [km]. Periodic cosine corrections to orbit radius
C_r_s =  (3.593750000e+01)/1000;  % [Km]. Periodic sine corrections to orbit radius

C_i_c =  -4.284083843e-08;  % [rad]. Periodic cosine corrections to orbit inclination
C_i_s = -2.421438694e-08;  % [rad]. Periodic sine corrections to orbit inclination



% Read Precise IGS data from excel spreadsheet:
[sv_5_IGS_data,titles_sv5] = xlsread('SV_5_IGS_data');

format long

x_true_km_sv5 = sv_5_IGS_data(:,6);
y_true_km_sv5 = sv_5_IGS_data(:,7);
z_true_km_sv5 = sv_5_IGS_data(:,8);

% Total time in minutes right now. NOT in GPS seconds
% t = (linspace(0,1425,96)*60)+toe;
t = [172800:900:258300]';
t_k = [t - toe];

mu = 398600; % km^3/s^2
a = [sqrt_sma^2]/1000;   % now sma is in [Km]
n0 = sqrt(mu/(a^3));  % [ 1/sec]
n = n0 + delta_N;
Mk = (M_0 + n*t_k);   % [rad]
e = [e* ones(1,96)]'; 

Ek = kepler_E(e, Mk);  % [rad]
theta_k = 2*atan(sqrt((1+e)./(1-e)).*tan(Ek/2));  %[rad]

phi_k = theta_k + AOP;   % [rad]
delta_uk = C_u_s*sin(2*phi_k) + C_u_c*cos(2*phi_k);  % [rad]
delta_rk = C_r_s*sin(2*phi_k) + C_r_c*cos(2*phi_k);   % [km]
delta_ik = C_i_s*sin(2*phi_k) + C_i_c*cos(2*phi_k);   % [rad]

u_k = phi_k + delta_uk;    % [rad]
r_k = a*(1-e.*cos(Ek)) + delta_rk;   % [km]
i_k = i_0 + I_DOT*t_k + delta_ik;  % [rad]

we = 7.2921150e-005;   % EXACT from Google. Full digits
lamda_k = lamda_0 + ((RAAN_dot - we)*t_k) -we*toe;

x_k = r_k.*cos(u_k);
y_k = r_k.*sin(u_k);
z_k = 0;

x_ecef_sv5 = x_k.*cos(lamda_k) - y_k.*cos(i_k).*sin(lamda_k);
y_ecef_sv5 = x_k.*sin(lamda_k)+ y_k.*cos(i_k).*cos(lamda_k);
z_ecef_sv5 = y_k.*sin(i_k);


%error in x_comp, y_comp, z_comp:
x_error_sv_5 = abs(x_ecef_sv5-x_true_km_sv5);   % [km]
y_error_sv_5 = abs(y_ecef_sv5-y_true_km_sv5);   % [km]
z_error_sv_5 = abs(z_ecef_sv5-z_true_km_sv5);   % [km]

figure(5)
plot(t,x_error_sv_5*1000,'r')
xlabel('GPS time (seconds)')
ylabel('Error in X component of position (meters)')
title('Error over time for SV 5')

figure(6)
plot(t,y_error_sv_5*1000,'r')
xlabel('GPS time (seconds)')
ylabel('Error in Y component of position (meters)')
title('Error over time for SV 5')

figure(7)
plot(t,z_error_sv_5*1000,'r')
xlabel('GPS time (seconds)')
ylabel('Error in Z component of position (meters)')
title('Error over time for SV 5')

R_true_magnitude_sv5 = sqrt(x_true_km_sv5.^2 + y_true_km_sv5.^2 + z_true_km_sv5.^2); % [km]
R_ecef_mag_sv5 = sqrt(x_ecef_sv5.^2 + y_ecef_sv5.^2 + z_ecef_sv5.^2);   % [km]

%error in position magnitude between R_true_sv5 and R_ecef_sv5:
error_in_position_mag_sv5 = abs(R_true_magnitude_sv5 - R_ecef_mag_sv5);

figure(8)
plot(t,error_in_position_mag_sv5*1000,'r')
xlabel('GPS time (seconds)')
ylabel('Error in position magnitude (meters)')
title('Error over time for SV 5')

% 



% titles variable is the title of excel spreadsheet's column vectors:

% titles(1,1)
% ans = 
%     'SV'
% titles(1,2)
% ans = 
%     {''}
% titles(1,3)
% ans = 
%     'hours'
% titles(1,4)
% ans = 
%     'minutes'
% titles(1,5)
% ans = 
%     'seconds'
% titles(1,6)
% ans = 
%     'x (km)'
% titles(1,7)
% ans = 
%     'y (km)'
% titles(1,8)
% ans = 
%     'z (km)'

