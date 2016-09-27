%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Author: Josh Wildey
%  Class: AAE57500
%  Homework 4 - 12/2/2011
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all
clear all
clc

format long
%%%%%%%%% Problem 1: %%%%%%%%%
% **** Week    114 ephemeris for SV- 3 ************
e = 2.547537326e-03;            %[]  Eccentricity
toe = 2.520000000e+05;          %[s]  Time of Applicability
I_0 = 9.352987781E-01;          %[rad]  Orbital Inclination
omega_dot = -8.748578750E-09;   %[rad/s]  Rate of Right Ascen
sqrt_a = 5.153688175E+03;       %[m^.5]  SQRT(A)
omega_0 = -2.256728681E+00;     %[rad]  Right Ascen at TOA
omega = 5.176493009E-01;        %[rad]  Argument of Perigee
M_0 = 8.667702313E-01;          %[rad]  Mean Anom
delta_n = 5.394510616E-09;      %[rad/s]  mean motion diff
I_dot = 3.117986980E-10;        %[rad/s]  Rate of inclin
Cuc = 4.906207323E-06;          %[rad]  lat cosine ampl
Cus = 4.069879651E-06;          %[rad]  radius sin ampl
Crc = 2.845625000E+02;          %[m]  inclin cos ampl
Crs = 9.250000000E+01;          %[m]  radius sin ampl
Cic = 1.862645149E-08;          %[rad]  inclin cos ampl
Cis = -1.862645149E-09;         %[rad]  inclin sin ampl
omega_dot_e = 7.2921151467e-5;  %[rad/sec] Number from IS-GPS-200E
mu = 3.986005e14;               %[m^3/s^2] Number from IS-GPS-200E

t = 172800:900:258300;  % Time vector for when sample data was taken

sv3_ephemeris = xlsread('SV3-Ephemeris');

t_k = t - toe;          % Time from ephemeris refence time

A_k = sqrt_a^2;  % Semi-Major Axis
n_0 = sqrt(mu/A_k^3);  %[rad/s]  Computed Mean Motion
n = n_0 + delta_n;  % Correct Mean Motion
M_k = M_0 + n*t_k;  % Mean Anomaly

E_k = kepler_E(e,M_k);  % Eccentric Anomaly
v_k = 2*atan(sqrt((1+e)./(1-e)).*tan(E_k/2));  % True Anomaly

phi_k = v_k + omega;  % Argument of latitude
% Second Harmonic Perturbations
delta_u_k = Cus*sin(2*phi_k) + Cuc*cos(2*phi_k);  % Argument of latitude Correction
delta_r_k = Crs*sin(2*phi_k) + Crc*cos(2*phi_k);  % Radial Correction
delta_i_k = Cis*sin(2*phi_k) + Cic*cos(2*phi_k);  % Inclination Correction

u_k = phi_k + delta_u_k;               % Corrected Argument of Latitude
r_k = A_k*(1-e*cos(E_k)) + delta_r_k;  % Corrected Radius
i_k = I_0 + (I_dot)*t_k + delta_i_k;   % Corrected Inclination

% Positions in Orbital plane
x_kprime = r_k.*cos(u_k);
y_kprime = r_k.*sin(u_k);

% Corrected Longitude of Ascending Node
omega_k = omega_0 + (omega_dot - omega_dot_e)*t_k - omega_dot_e*toe;

% Earth Fixed Coordinates of SV antenna phase center
x_k_sv3 = x_kprime.*cos(omega_k) - y_kprime.*cos(i_k).*sin(omega_k);
y_k_sv3 = x_kprime.*sin(omega_k) + y_kprime.*cos(i_k).*cos(omega_k);
z_k_sv3 = y_kprime.*sin(i_k);

% Error in individual X,Y,Z positions
x_error_sv3 = abs(x_k_sv3/1000-sv3_ephemeris(:,2)').*1000;  %[m]
y_error_sv3 = abs(y_k_sv3/1000-sv3_ephemeris(:,3)').*1000;  %[m]
z_error_sv3 = abs(z_k_sv3/1000-sv3_ephemeris(:,4)').*1000;  %[m]

% Compute True Magnitude of Position
R_true_mag_sv3 = sqrt(sv3_ephemeris(:,2).^2 + sv3_ephemeris(:,3).^2 + sv3_ephemeris(:,4).^2)';  %[km]

% Compute Calculated Magnitude of Position
R_mag_sv3 = sqrt(x_k_sv3.^2 + y_k_sv3.^2 + z_k_sv3.^2)/1000;  %[km]

% Error in Magnitude
R_error_sv3 = abs(R_true_mag_sv3-R_mag_sv3).*1000;  %[m]

figure(1)
plot(t,x_error_sv3),grid on
xlabel('GPS Time (s)'),ylabel('Error in X Position (m)'),title('Error over time in X Position for SV3')

figure(2)
plot(t,y_error_sv3),grid on
xlabel('GPS Time (s)'),ylabel('Error in Y Position (m)'),title('Error over time in Y Position for SV3')

figure(3)
plot(t,z_error_sv3),grid on
xlabel('GPS Time (s)'),ylabel('Error in Z Position (m)'),title('Error over time in Z Position for SV3')

figure(4)
plot(t,R_error_sv3),grid on
xlabel('GPS Time (s)'),ylabel('Error in Magnitude of Position (m)'),title('Error over time in Magnitude of Position for SV3')

%  **** Week    114 ephemeris for SV- 5 ************
e = 3.250250011E-03;            %[]  Eccentricity
toe = 2.087840000E+05;          %[s]  Time of Applicability
I_0 = 9.363323970E-01;          %[rad]  Orbital Inclination
omega_dot = -8.031405763E-09;   %[rad/s]  Rate of Right Ascen
sqrt_a = 5.153571037E+03;       %[m^.5]  SQRT(A)
omega_0 = 2.969759636E+00;     %[rad]  Right Ascen at TOA
omega = 4.894296521E-01;        %[rad]  Argument of Perigee
M_0 = -2.098179373E+00;          %[rad]  Mean Anom
delta_n = 4.731982806E-09;      %[rad/s]  mean motion diff
I_dot = 4.857345429E-11;        %[rad/s]  Rate of inclin
Cuc = 1.855194569E-06;          %[rad]  lat cosine ampl
Cus = 1.207739115E-05;          %[rad]  radius sin ampl
Crc = 1.338750000E+02;          %[m]  inclin cos ampl
Crs = 3.593750000E+01;          %[m]  radius sin ampl
Cic = -4.284083843E-08;          %[rad]  inclin cos ampl
Cis = -2.421438694E-08;         %[rad]  inclin sin ampl
omega_dot_e = 7.2921151467e-5;  %[rad/sec] Number from IS-GPS-200E
mu = 3.986005e14;               %[m^3/s^2] Number from IS-GPS-200E

sv5_ephemeris = xlsread('SV5-Ephemeris');

t_k = t - toe;          % Time from ephemeris refence time

A_k = sqrt_a^2;  % Semi-Major Axis
n_0 = sqrt(mu/A_k^3);  %[rad/s]  Computed Mean Motion
n = n_0 + delta_n;  % Correct Mean Motion
M_k = M_0 + n*t_k;  % Mean Anomaly

E_k = kepler_E(e,M_k);  % Eccentric Anomaly
v_k = 2*atan(sqrt((1+e)./(1-e)).*tan(E_k/2));  % True Anomaly

phi_k = v_k + omega;  % Argument of latitude
% Second Harmonic Perturbations
delta_u_k = Cus*sin(2*phi_k) + Cuc*cos(2*phi_k);  % Argument of latitude Correction
delta_r_k = Crs*sin(2*phi_k) + Crc*cos(2*phi_k);  % Radial Correction
delta_i_k = Cis*sin(2*phi_k) + Cic*cos(2*phi_k);  % Inclination Correction

u_k = phi_k + delta_u_k;               % Corrected Argument of Latitude
r_k = A_k*(1-e*cos(E_k)) + delta_r_k;  % Corrected Radius
i_k = I_0 + (I_dot)*t_k + delta_i_k;   % Corrected Inclination

% Positions in Orbital plane
x_kprime = r_k.*cos(u_k);
y_kprime = r_k.*sin(u_k);

% Corrected Longitude of Ascending Node
omega_k = omega_0 + (omega_dot - omega_dot_e)*t_k - omega_dot_e*toe;

% Earth Fixed Coordinates of SV antenna phase center
x_k_sv5 = x_kprime.*cos(omega_k) - y_kprime.*cos(i_k).*sin(omega_k);
y_k_sv5 = x_kprime.*sin(omega_k) + y_kprime.*cos(i_k).*cos(omega_k);
z_k_sv5 = y_kprime.*sin(i_k);

% Error in individual X,Y,Z positions
x_error_sv5 = abs(x_k_sv5/1000-sv5_ephemeris(:,2)').*1000;  %[m]
y_error_sv5 = abs(y_k_sv5/1000-sv5_ephemeris(:,3)').*1000;  %[m]
z_error_sv5 = abs(z_k_sv5/1000-sv5_ephemeris(:,4)').*1000;  %[m]

% Compute True Magnitude of Position
R_true_mag_sv5 = sqrt(sv5_ephemeris(:,2).^2 + sv5_ephemeris(:,3).^2 + sv5_ephemeris(:,4).^2)';  %[km]

% Compute Calculated Magnitude of Position
R_mag_sv5 = sqrt(x_k_sv5.^2 + y_k_sv5.^2 + z_k_sv5.^2)/1000;  %[km]

% Error in Magnitude
R_error_sv5 = abs(R_true_mag_sv5-R_mag_sv5).*1000;  %[m]

figure(5)
plot(t,x_error_sv5),grid on
xlabel('GPS Time (s)'),ylabel('Error in X Position (m)'),title('Error over time in X Position for SV5')

figure(6)
plot(t,y_error_sv5),grid on
xlabel('GPS Time (s)'),ylabel('Error in Y Position (m)'),title('Error over time in Y Position for SV5')

figure(7)
plot(t,z_error_sv5),grid on
xlabel('GPS Time (s)'),ylabel('Error in Z Position (m)'),title('Error over time in Z Position for SV5')

figure(8)
plot(t,R_error_sv5),grid on
xlabel('GPS Time (s)'),ylabel('Error in Magnitude of Position (m)'),title('Error over time in Magnitude of Position for SV5')

%%%%%%%%% Problem 2: %%%%%%%%%
%  **** Week 114 Almanac for SV- 3 ************
e = 2.558708191E-003;            %[]  Eccentricity
toe = 4.055040000E+005;          %[s]  Time of Applicability
I_0 = 9.353532195E-001;          %[rad]  Orbital Inclination
omega_dot = -8.263201678E-009;   %[rad/s]  Rate of Right Ascen
sqrt_a = 5.153633301E+003;       %[m^.5]  SQRT(A)
omega_0 = -2.258039713E+000;     %[rad]  Right Ascen at TOA
omega = 5.173110962E-001;        %[rad]  Argument of Perigee
M_0 = -1.875895619E+000;          %[rad]  Mean Anom
delta_n = 0;      %[rad/s]  mean motion diff
I_dot = 0;        %[rad/s]  Rate of inclin
Cuc = 0;          %[rad]  lat cosine ampl
Cus = 0;          %[rad]  radius sin ampl
Crc = 0;          %[m]  inclin cos ampl
Crs = 0;          %[m]  radius sin ampl
Cic = 0;          %[rad]  inclin cos ampl
Cis = 0;          %[rad]  inclin sin ampl
omega_dot_e = 7.2921151467e-5;  %[rad/sec] Number from IS-GPS-200E
mu = 3.986005e14;               %[m^3/s^2] Number from IS-GPS-200E

t_k = t - toe;          % Time from ephemeris refence time

A_k = sqrt_a^2;  % Semi-Major Axis
n_0 = sqrt(mu/A_k^3);  %[rad/s]  Computed Mean Motion
n = n_0 + delta_n;  % Correct Mean Motion
M_k = M_0 + n*t_k;  % Mean Anomaly

E_k = kepler_E(e,M_k);  % Eccentric Anomaly
v_k = 2*atan(sqrt((1+e)./(1-e)).*tan(E_k/2));  % True Anomaly

phi_k = v_k + omega;  % Argument of latitude
% Second Harmonic Perturbations
delta_u_k = Cus*sin(2*phi_k) + Cuc*cos(2*phi_k);  % Argument of latitude Correction
delta_r_k = Crs*sin(2*phi_k) + Crc*cos(2*phi_k);  % Radial Correction
delta_i_k = Cis*sin(2*phi_k) + Cic*cos(2*phi_k);  % Inclination Correction

u_k = phi_k + delta_u_k;               % Corrected Argument of Latitude
r_k = A_k*(1-e*cos(E_k)) + delta_r_k;  % Corrected Radius
i_k = I_0 + (I_dot)*t_k + delta_i_k;   % Corrected Inclination

% Positions in Orbital plane
x_kprime = r_k.*cos(u_k);
y_kprime = r_k.*sin(u_k);

% Corrected Longitude of Ascending Node
omega_k = omega_0 + (omega_dot - omega_dot_e)*t_k - omega_dot_e*toe;

% Earth Fixed Coordinates of SV antenna phase center
x_k_sv3_almanac = x_kprime.*cos(omega_k) - y_kprime.*cos(i_k).*sin(omega_k);
y_k_sv3_almanac = x_kprime.*sin(omega_k) + y_kprime.*cos(i_k).*cos(omega_k);
z_k_sv3_almanac = y_kprime.*sin(i_k);

% Error in individual X,Y,Z positions
x_error_sv3_almanac = abs(x_k_sv3_almanac/1000-sv3_ephemeris(:,2)').*1000;  %[m]
y_error_sv3_almanac = abs(y_k_sv3_almanac/1000-sv3_ephemeris(:,3)').*1000;  %[m]
z_error_sv3_almanac = abs(z_k_sv3_almanac/1000-sv3_ephemeris(:,4)').*1000;  %[m]

% Compute Calculated Magnitude of Position
R_mag_sv3_almanac = sqrt(x_k_sv3_almanac.^2 + y_k_sv3_almanac.^2 + z_k_sv3_almanac.^2)/1000;  %[km]

% Error in Magnitude
R_error_sv3_almanac = abs(R_true_mag_sv3-R_mag_sv3_almanac).*1000;  %[m]

figure(9)
plot(t,x_error_sv3_almanac),grid on
xlabel('GPS Time (s)'),ylabel('Error in X Position (m)'),title('Error over time in X Position for SV3 Using Almanac Data')

figure(10)
plot(t,y_error_sv3_almanac),grid on
xlabel('GPS Time (s)'),ylabel('Error in Y Position (m)'),title('Error over time in Y Position for SV3 Using Almanac Data')

figure(11)
plot(t,z_error_sv3_almanac),grid on
xlabel('GPS Time (s)'),ylabel('Error in Z Position (m)'),title('Error over time in Z Position for SV3 Using Almanac Data')

figure(12)
plot(t,R_error_sv3_almanac),grid on
xlabel('GPS Time (s)'),ylabel('Error in Magnitude of Position (m)'),title('Error over time in Magnitude of Position for SV3 Using Almanac Data')

%  **** Week 114 Almanac for SV- 5 ************
e = 3.262042999E-003;            %[]  Eccentricity
toe = 4.055040000E+005;          %[s]  Time of Applicability
I_0 = 9.362700582E-001;          %[rad]  Orbital Inclination
omega_dot = -7.897472010E-009;   %[rad/s]  Rate of Right Ascen
sqrt_a = 5.153512695E+003;       %[m^.5]  SQRT(A)
omega_0 = 2.968166113E+000;      %[rad]  Right Ascen at TOA
omega = 4.932729602E-001;        %[rad]  Argument of Perigee
M_0 = 1.460322738E+000;          %[rad]  Mean Anom
delta_n = 0;      %[rad/s]  mean motion diff
I_dot = 0;        %[rad/s]  Rate of inclin
Cuc = 0;          %[rad]  lat cosine ampl
Cus = 0;          %[rad]  radius sin ampl
Crc = 0;          %[m]  inclin cos ampl
Crs = 0;          %[m]  radius sin ampl
Cic = 0;          %[rad]  inclin cos ampl
Cis = 0;          %[rad]  inclin sin ampl
omega_dot_e = 7.2921151467e-5;  %[rad/sec] Number from IS-GPS-200E
mu = 3.986005e14;               %[m^3/s^2] Number from IS-GPS-200E

t_k = t - toe;          % Time from ephemeris refence time

A_k = sqrt_a^2;  % Semi-Major Axis
n_0 = sqrt(mu/A_k^3);  %[rad/s]  Computed Mean Motion
n = n_0 + delta_n;  % Correct Mean Motion
M_k = M_0 + n*t_k;  % Mean Anomaly

E_k = kepler_E(e,M_k);  % Eccentric Anomaly
v_k = 2*atan(sqrt((1+e)./(1-e)).*tan(E_k/2));  % True Anomaly

phi_k = v_k + omega;  % Argument of latitude
% Second Harmonic Perturbations
delta_u_k = Cus*sin(2*phi_k) + Cuc*cos(2*phi_k);  % Argument of latitude Correction
delta_r_k = Crs*sin(2*phi_k) + Crc*cos(2*phi_k);  % Radial Correction
delta_i_k = Cis*sin(2*phi_k) + Cic*cos(2*phi_k);  % Inclination Correction

u_k = phi_k + delta_u_k;               % Corrected Argument of Latitude
r_k = A_k*(1-e*cos(E_k)) + delta_r_k;  % Corrected Radius
i_k = I_0 + (I_dot)*t_k + delta_i_k;   % Corrected Inclination

% Positions in Orbital plane
x_kprime = r_k.*cos(u_k);
y_kprime = r_k.*sin(u_k);

% Corrected Longitude of Ascending Node
omega_k = omega_0 + (omega_dot - omega_dot_e)*t_k - omega_dot_e*toe;

% Earth Fixed Coordinates of SV antenna phase center
x_k_sv5_almanac = x_kprime.*cos(omega_k) - y_kprime.*cos(i_k).*sin(omega_k);
y_k_sv5_almanac = x_kprime.*sin(omega_k) + y_kprime.*cos(i_k).*cos(omega_k);
z_k_sv5_almanac = y_kprime.*sin(i_k);

% Error in individual X,Y,Z positions
x_error_sv5_almanac = abs(x_k_sv5_almanac/1000-sv5_ephemeris(:,2)').*1000;  %[m]
y_error_sv5_almanac = abs(y_k_sv5_almanac/1000-sv5_ephemeris(:,3)').*1000;  %[m]
z_error_sv5_almanac = abs(z_k_sv5_almanac/1000-sv5_ephemeris(:,4)').*1000;  %[m]

% Compute Calculated Magnitude of Position
R_mag_sv5_almanac = sqrt(x_k_sv5_almanac.^2 + y_k_sv5_almanac.^2 + z_k_sv5_almanac.^2)/1000;  %[km]

% Error in Magnitude
R_error_sv5_almanac = abs(R_true_mag_sv5-R_mag_sv5_almanac).*1000;  %[m]

figure(13)
plot(t,x_error_sv5_almanac),grid on
xlabel('GPS Time (s)'),ylabel('Error in X Position (m)'),title('Error over time in X Position for SV5 Using Almanac Data')

figure(14)
plot(t,y_error_sv5_almanac),grid on
xlabel('GPS Time (s)'),ylabel('Error in Y Position (m)'),title('Error over time in Y Position for SV5 Using Almanac Data')

figure(15)
plot(t,z_error_sv5_almanac),grid on
xlabel('GPS Time (s)'),ylabel('Error in Z Position (m)'),title('Error over time in Z Position for SV5 Using Almanac Data')

figure(16)
plot(t,R_error_sv5_almanac),grid on
xlabel('GPS Time (s)'),ylabel('Error in Magnitude of Position (m)'),title('Error over time in Magnitude of Position for SV5 Using Almanac Data')