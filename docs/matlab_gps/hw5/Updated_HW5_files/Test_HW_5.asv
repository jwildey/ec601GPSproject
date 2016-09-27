% HW 5 problem 1

clear all; clc; close all;
format long

load rcvrc.dat
load eph.dat


tb_R = 0
x_R = -2701206.38/1000
y_R = -4293642.366/1000
z_R = 3857878.924/1000

n = 0
while n <= 3;  
  

c = 2.99792458e+08/1000;   % [km/s]
mu = 398600; % km^3/s^2
we = 7.2921151467e-5 ; % exact value from 1S-200E  USE THIS
% we = 7.2921150e-005;   % EXACT from Google. Full digits
% % mu= 3986004.418e8;  % m^3/s^2
 
% % %====================== SV 5 =================================:

e_5 = eph(1,9); 
sqrt_sma_5 =  eph(1,10);     % [(m^1/2)]
delta_N_5 = eph(1,11);     % [rad/s]
M_0_5 = eph(1,12);    % [rad]
AOP_5 = eph(1,13);    % [rad]
lamda_0_5 = eph(1,14);   % [rad]
i_0_5 = eph(1,15); % [rad]
RAAN_dot_5 = eph(1,16);  % [rad]
I_DOT_5 = eph(1,17);   % [rad/s]

C_u_s_5 = eph(1,18);   % [rad]
C_u_c_5 = eph(1,19);    %[rad]

C_i_s_5 = eph(1,20);    %[rad]
C_i_c_5 = eph(1,21);    %[rad]

C_r_s_5 = eph(1,22)/1000;    %[km]
C_r_c_5 = eph(1,23)/1000;    %[km]
 
% t = [172800:900:258300]';
% t_k = [t - toe];

tR = eph(1,1);   % time of reception SAME for all SVs
toe_5 =  eph(1,4);
% tb_R = 0;     % Initial GUESS in Receiver clock bias

c_rho5 = rcvrc(1,3)/1000;   %   SV 5 corrected pseudorange [km] 

tau5 = (c_rho5 - c*tb_R)/c;    
t_T5 = tR - [tau5];   % time of TRANSMISSION of SV 5  [s]
tk5 = t_T5 - toe_5;

a5 = [sqrt_sma_5^2]/1000;   % now sma is in [Km]
n05 = sqrt(mu/(a5^3));  % [ 1/sec]
n5 = n05 + delta_N_5;
Mk5 = (M_0_5 + n5*tk5);   % [rad]
% Mk5 = (M_0_5 + n5*t_T5);  

Ek5 = kepler_E(e_5, Mk5);  % [rad]
theta_k5 = 2*atan(sqrt((1+e_5)/(1-e_5))*tan(Ek5/2));  %[rad]
% 
phi_k5 = theta_k5 + AOP_5;   % [rad]
delta_uk5 = C_u_s_5*sin(2*phi_k5) + C_u_c_5*cos(2*phi_k5);  % [rad]
delta_rk5 = C_r_s_5*sin(2*phi_k5) + C_r_c_5*cos(2*phi_k5);   % [km]
delta_ik5 = C_i_s_5*sin(2*phi_k5) + C_i_c_5*cos(2*phi_k5);   % [rad]
% 
u_k5 = phi_k5 + delta_uk5;    % [rad]
r_k5 = a5*(1-e_5*cos(Ek5)) + delta_rk5;   % [km]
i_k5 = i_0_5 + (I_DOT_5*tk5) + delta_ik5;  % [rad]
% i_k5 = i_0_5 + (I_DOT_5*t_T5) + delta_ik5;  % [rad]

lamda_k5 = lamda_0_5 + (RAAN_dot_5 - we)*tk5 - we*toe_5;
% lamda_k5 = lamda_0_5 + (RAAN_dot_5 - we)*t_T5 - we*toe_5;

x_k5 = r_k5*cos(u_k5);    % all in [km]
y_k5 = r_k5*sin(u_k5);
z_k5 = 0;

% SV 5 position at t_T5  [km]
x_ecef_sv5_t_T5 = x_k5*cos(lamda_k5) - y_k5*cos(i_k5)*sin(lamda_k5);
y_ecef_sv5_t_T5 = x_k5*sin(lamda_k5)+ y_k5*cos(i_k5)*cos(lamda_k5);
z_ecef_sv5_t_T5 = y_k5*sin(i_k5);

SV5_mag_at_t_T5 = sqrt(x_ecef_sv5_t_T5^2 + y_ecef_sv5_t_T5^2 + z_ecef_sv5_t_T5^2);

% Now get SV 5 position at the time of reception: tR:   [km]
x_ecef_sv5_t_R = cos(we*tau5)*x_ecef_sv5_t_T5 + sin(we*tau5)*y_ecef_sv5_t_T5 + 0;
y_ecef_sv5_t_R = -sin(we*tau5)*x_ecef_sv5_t_T5 + cos(we*tau5)* y_ecef_sv5_t_T5 + 0;
z_ecef_sv5_t_R = z_ecef_sv5_t_T5;

SV5_mag_at_tR = sqrt(x_ecef_sv5_t_R^2 + y_ecef_sv5_t_R^2 + z_ecef_sv5_t_R^2);


% % %====================== SV 6 =================================:


e_6 = eph(2,9); 
sqrt_sma_6 =  eph(2,10);     % [(m^1/2)]
delta_N_6 = eph(2,11);     % [rad/s]
M_0_6 = eph(2,12);    % [rad]
AOP_6 = eph(2,13);    % [rad]
lamda_0_6 = eph(2,14);   % [rad]
i_0_6 = eph(2,15); % [rad]
RAAN_dot_6 = eph(2,16);  % [rad]
I_DOT_6 = eph(2,17);   % [rad/s]

C_u_s_6 = eph(2,18);   % [rad]
C_u_c_6 = eph(2,19);    %[rad]

C_i_s_6 = eph(2,20);    %[rad]
C_i_c_6 = eph(2,21);    %[rad]

C_r_s_6 = eph(2,22)/1000;    %[km]
C_r_c_6 = eph(2,23)/1000;    %[km]
 
% t = [172800:900:258300]';
% t_k = [t - toe];

tR = eph(1,1);   % time of reception
toe_6 =  eph(2,4);
% tb_R = 0;     % Initial GUESS in Receiver clock bias

c_rho6 = rcvrc(2,3)/1000;   %   SV 6 corrected pseudorange [km] 

tau6 = (c_rho6 - c*tb_R)/c;    
t_T6 = tR - [tau6];   % time of TRANSMISSION of SV 6  [s]
tk6 = t_T6 - toe_6;

a6 = [sqrt_sma_6^2]/1000;   % now sma is in [Km]
n06 = sqrt(mu/(a6^3));  % [ 1/sec]
n6 = n06 + delta_N_6;
Mk6 = (M_0_6 + n6*tk6);   % [rad]
% Mk6 = (M_0_6 + n6*t_T6);   % [rad]  

Ek6 = kepler_E(e_6, Mk6);  % [rad]
theta_k6 = 2*atan(sqrt((1+e_6)/(1-e_6))*tan(Ek6/2));  %[rad]
% 
phi_k6 = theta_k6 + AOP_6;   % [rad]
delta_uk6 = C_u_s_6*sin(2*phi_k6) + C_u_c_6*cos(2*phi_k6);  % [rad]
delta_rk6 = C_r_s_6*sin(2*phi_k6) + C_r_c_6*cos(2*phi_k6);   % [km]
delta_ik6 = C_i_s_6*sin(2*phi_k6) + C_i_c_6*cos(2*phi_k6);   % [rad]
% 
u_k6 = phi_k6 + delta_uk6;    % [rad]
r_k6 = a6*(1-e_6*cos(Ek6)) + delta_rk6;   % [km]
i_k6 = i_0_6 + (I_DOT_6*tk6) + delta_ik6;  % [rad]
% i_k6 = i_0_6 + (I_DOT_6*t_T6) + delta_ik6;  % [rad]

lamda_k6 = lamda_0_6 + (RAAN_dot_6 - we)*tk6 - we*toe_6;
% lamda_k6 = lamda_0_6 + (RAAN_dot_6 - we)*t_T6 - we*toe_6;

x_k6 = r_k6*cos(u_k6);    % all in [km]
y_k6 = r_k6*sin(u_k6);
z_k6 = 0;

% SV 5 position at t_T5  [km]
x_ecef_sv6_t_T6 = x_k6*cos(lamda_k6) - y_k6*cos(i_k6)*sin(lamda_k6);
y_ecef_sv6_t_T6 = x_k6*sin(lamda_k6)+ y_k6*cos(i_k6)*cos(lamda_k6);
z_ecef_sv6_t_T6 = y_k6*sin(i_k6);

SV6_mag_at_t_T6 = sqrt(x_ecef_sv6_t_T6^2 + y_ecef_sv6_t_T6^2 + z_ecef_sv6_t_T6^2);

% Now get SV 6 position at the time of reception: tR:   [km]
x_ecef_sv6_t_R = cos(we*tau6)*x_ecef_sv6_t_T6 + sin(we*tau6)*y_ecef_sv6_t_T6 + 0;
y_ecef_sv6_t_R = -sin(we*tau6)*x_ecef_sv6_t_T6 + cos(we*tau6)* y_ecef_sv6_t_T6 + 0;
z_ecef_sv6_t_R = z_ecef_sv6_t_T6;

SV6_mag_at_tR = sqrt(x_ecef_sv6_t_R^2 + y_ecef_sv6_t_R^2 + z_ecef_sv6_t_R^2);




% % %====================== SV 17 =================================:


e_17 = eph(3,9); 
sqrt_sma_17 =  eph(3,10);     % [(m^1/2)]
delta_N_17 = eph(3,11);     % [rad/s]
M_0_17 = eph(3,12);    % [rad]
AOP_17 = eph(3,13);    % [rad]
lamda_0_17 = eph(3,14);   % [rad]
i_0_17 = eph(3,15); % [rad]
RAAN_dot_17 = eph(3,16);  % [rad]
I_DOT_17 = eph(3,17);   % [rad/s]

C_u_s_17 = eph(3,18);   % [rad]
C_u_c_17 = eph(3,19);    %[rad]

C_i_s_17 = eph(3,20);    %[rad]
C_i_c_17 = eph(3,21);    %[rad]

C_r_s_17 = eph(3,22)/1000;    %[km]
C_r_c_17 = eph(3,23)/1000;    %[km]
 
% t = [172800:900:258300]';
% t_k = [t - toe];

tR = eph(1,1);   % time of reception
toe_17 =  eph(3,4);
% tb_R = 0;     % Initial GUESS in Receiver clock bias

c_rho17 = rcvrc(3,3)/1000;   %   SV 17 corrected pseudorange [km] 

tau17 = (c_rho17 - c*tb_R)/c;    
t_T17 = tR - [tau17];   % time of TRANSMISSION of SV 17  [s]
tk17 = t_T17 - toe_17;

a17 = [sqrt_sma_17^2]/1000;   % now sma is in [Km]
n017 = sqrt(mu/(a17^3));  % [ 1/sec]
n17 = n017 + delta_N_17;
Mk17 = (M_0_17 + n17*tk17);   % [rad
% Mk17 = (M_0_17 + n17*t_T17);   % [rad]


Ek17 = kepler_E(e_17, Mk17);  % [rad]
theta_k17 = 2*atan(sqrt((1+e_17)/(1-e_17))*tan(Ek17/2));  %[rad]
% 
phi_k17 = theta_k17 + AOP_17;   % [rad]
delta_uk17 = C_u_s_17*sin(2*phi_k17) + C_u_c_17*cos(2*phi_k17);  % [rad]
delta_rk17 = C_r_s_17*sin(2*phi_k17) + C_r_c_17*cos(2*phi_k17);   % [km]
delta_ik17 = C_i_s_17*sin(2*phi_k17) + C_i_c_17*cos(2*phi_k17);   % [rad]
% 
u_k17 = phi_k17 + delta_uk17;    % [rad]
r_k17 = a17*(1-e_17*cos(Ek17)) + delta_rk17;   % [km]
i_k17 = i_0_17 + (I_DOT_17*tk17) + delta_ik17;  % [rad]
% i_k17 = i_0_17 + (I_DOT_17*t_T17) + delta_ik17;  % [rad]

lamda_k17 = lamda_0_17 + (RAAN_dot_17 - we)*tk17 - we*toe_17;
% lamda_k17 = lamda_0_17 + (RAAN_dot_17 - we)*t_T17 - we*toe_17;


x_k17 = r_k17*cos(u_k17);    % all in [km]
y_k17 = r_k17*sin(u_k17);
z_k17 = 0;

% SV 17 position at t_T17  [km]
x_ecef_sv17_t_T17 = x_k17*cos(lamda_k17) - y_k17*cos(i_k17)*sin(lamda_k17);
y_ecef_sv17_t_T17 = x_k17*sin(lamda_k17)+ y_k17*cos(i_k17)*cos(lamda_k17);
z_ecef_sv17_t_T17 = y_k17*sin(i_k17);

SV17_mag_at_t_T17 = sqrt(x_ecef_sv17_t_T17^2 + y_ecef_sv17_t_T17^2 + z_ecef_sv17_t_T17^2);

% Now get SV 17 position at the time of reception: tR:   [km]
x_ecef_sv17_t_R = cos(we*tau17)*x_ecef_sv17_t_T17 + sin(we*tau17)*y_ecef_sv17_t_T17 + 0;
y_ecef_sv17_t_R = -sin(we*tau17)*x_ecef_sv17_t_T17 + cos(we*tau17)* y_ecef_sv17_t_T17 + 0;
z_ecef_sv17_t_R = z_ecef_sv17_t_T17;

SV17_mag_at_tR = sqrt(x_ecef_sv17_t_R^2 + y_ecef_sv17_t_R^2 + z_ecef_sv17_t_R^2);



% % %====================== SV 30 =================================:


e_30 = eph(4,9); 
sqrt_sma_30 =  eph(4,10);     % [(m^1/2)]
delta_N_30 = eph(4,11);     % [rad/s]
M_0_30 = eph(4,12);    % [rad]
AOP_30 = eph(4,13);    % [rad]
lamda_0_30 = eph(4,14);   % [rad]
i_0_30 = eph(4,15); % [rad]
RAAN_dot_30 = eph(4,16);  % [rad]
I_DOT_30 = eph(4,17);   % [rad/s]

C_u_s_30 = eph(4,18);   % [rad]
C_u_c_30 = eph(4,19);    %[rad]

C_i_s_30 = eph(4,20);    %[rad]
C_i_c_30 = eph(4,21);    %[rad]

C_r_s_30 = eph(4,22)/1000;    %[km]
C_r_c_30 = eph(4,23)/1000;    %[km]
 
% t = [172800:900:258300]';
% t_k = [t - toe];

tR = eph(1,1);   % time of reception
toe_30 =  eph(4,4);
% tb_R = 0;     % Initial GUESS in Receiver clock bias

c_rho30 = rcvrc(4,3)/1000;   %   SV 30 corrected pseudorange [km] 

tau30 = (c_rho30 - c*tb_R)/c;    
t_T30 = tR - [tau30];   % time of TRANSMISSION of SV 30  [s]
tk30 = t_T30 - toe_30;

a30 = [sqrt_sma_30^2]/1000;   % now sma is in [Km]
n030 = sqrt(mu/(a30^3));  % [ 1/sec]
n30 = n030 + delta_N_30;
Mk30 = (M_0_30 + n30*tk30);   % [rad]
%  Mk30 = (M_0_30 + n30*t_T30);   % [rad]

Ek30 = kepler_E(e_30, Mk30);  % [rad]
theta_k30 = 2*atan(sqrt((1+e_30)/(1-e_30))*tan(Ek30/2));  %[rad]
% 
phi_k30 = theta_k30 + AOP_30;   % [rad]
delta_uk30 = C_u_s_30*sin(2*phi_k30) + C_u_c_30*cos(2*phi_k30);  % [rad]
delta_rk30 = C_r_s_30*sin(2*phi_k30) + C_r_c_30*cos(2*phi_k30);   % [km]
delta_ik30 = C_i_s_30*sin(2*phi_k30) + C_i_c_30*cos(2*phi_k30);   % [rad]
% 
u_k30 = phi_k30 + delta_uk30;    % [rad]
r_k30 = a30*(1-e_30*cos(Ek30)) + delta_rk30;   % [km]
i_k30 = i_0_30 + (I_DOT_30*tk30) + delta_ik30;  % [rad]
% i_k30 = i_0_30 + (I_DOT_30*t_T30) + delta_ik30;  % [rad]

lamda_k30 = lamda_0_30 + (RAAN_dot_30 - we)*tk30 - we*toe_30;
% lamda_k30 = lamda_0_30 + (RAAN_dot_30 - we)*t_T30 - we*toe_30;

x_k30 = r_k30*cos(u_k30);    % all in [km]
y_k30 = r_k30*sin(u_k30);
z_k30 = 0;

% SV 30 position at t_T30  [km]
x_ecef_sv30_t_T30 = x_k30*cos(lamda_k30) - y_k30*cos(i_k30)*sin(lamda_k30);
y_ecef_sv30_t_T30 = x_k30*sin(lamda_k30)+ y_k30*cos(i_k30)*cos(lamda_k30);
z_ecef_sv30_t_T30 = y_k30*sin(i_k30);

SV30_mag_at_t_T30 = sqrt(x_ecef_sv30_t_T30^2 + y_ecef_sv30_t_T30^2 + z_ecef_sv30_t_T30^2);

% Now get SV 30 position at the time of reception: tR:   [km]
x_ecef_sv30_t_R = cos(we*tau30)*x_ecef_sv30_t_T30 + sin(we*tau30)*y_ecef_sv30_t_T30 + 0;
y_ecef_sv30_t_R = -sin(we*tau30)*x_ecef_sv30_t_T30 + cos(we*tau30)* y_ecef_sv30_t_T30 + 0;
z_ecef_sv30_t_R = z_ecef_sv30_t_T30;

SV30_mag_at_tR = sqrt(x_ecef_sv30_t_R^2 + y_ecef_sv30_t_R^2 + z_ecef_sv30_t_R^2);


% % %====================== SV 10 =================================:


e_10 = eph(5,9); 
sqrt_sma_10 =  eph(5,10);     % [(m^1/2)]
delta_N_10 = eph(5,11);     % [rad/s]
M_0_10 = eph(5,12);    % [rad]
AOP_10 = eph(5,13);    % [rad]
lamda_0_10 = eph(5,14);   % [rad]
i_0_10 = eph(5,15); % [rad]
RAAN_dot_10 = eph(5,16);  % [rad]
I_DOT_10 = eph(5,17);   % [rad/s]

C_u_s_10 = eph(5,18);   % [rad]
C_u_c_10 = eph(5,19);    %[rad]

C_i_s_10 = eph(5,20);    %[rad]
C_i_c_10 = eph(5,21);    %[rad]

C_r_s_10 = eph(5,22)/1000;    %[km]
C_r_c_10 = eph(5,23)/1000;    %[km]
 
% t = [172800:900:258300]';
% t_k = [t - toe];

tR = eph(1,1);   % time of reception
toe_10 =  eph(5,4);
% tb_R = 0;     % Initial GUESS in Receiver clock bias

c_rho10 = rcvrc(5,3)/1000;   %   SV 10 corrected pseudorange [km] 

tau10 = (c_rho10 - c*tb_R)/c;    
t_T10 = tR - [tau10];   % time of TRANSMISSION of SV 10  [s]
tk10 = t_T10 - toe_10;

a10 = [sqrt_sma_10^2]/1000;   % now sma is in [Km]
n010 = sqrt(mu/(a10^3));  % [ 1/sec]
n10 = n010 + delta_N_10;
Mk10 = (M_0_10 + n10*tk10);   % [rad]
%  Mk10 = (M_0_10 + n10*t_T10);   % [rad]

Ek10 = kepler_E(e_10, Mk10);  % [rad]
theta_k10 = 2*atan(sqrt((1+e_10)/(1-e_10))*tan(Ek10/2));  %[rad]
% 
phi_k10 = theta_k10 + AOP_10;   % [rad]
delta_uk10 = C_u_s_10*sin(2*phi_k10) + C_u_c_10*cos(2*phi_k10);  % [rad]
delta_rk10 = C_r_s_10*sin(2*phi_k10) + C_r_c_10*cos(2*phi_k10);   % [km]
delta_ik10 = C_i_s_10*sin(2*phi_k10) + C_i_c_10*cos(2*phi_k10);   % [rad]
% 
u_k10 = phi_k10 + delta_uk10;    % [rad]
r_k10 = a10*(1-e_10*cos(Ek10)) + delta_rk10;   % [km]
i_k10 = i_0_10 + (I_DOT_10*tk10) + delta_ik10;  % [rad]
% i_k10 = i_0_10 + (I_DOT_10*t_T10) + delta_ik10;  % [rad]

lamda_k10 = lamda_0_10 + (RAAN_dot_10 - we)*tk10 - we*toe_10;
% lamda_k10 = lamda_0_10 + (RAAN_dot_10 - we)*t_T10 - we*toe_10;

x_k10 = r_k10*cos(u_k10);    % all in [km]
y_k10 = r_k10*sin(u_k10);
z_k10 = 0;

% SV 10 position at t_T10  [km]
x_ecef_sv10_t_T10 = x_k10*cos(lamda_k10) - y_k10*cos(i_k10)*sin(lamda_k10);
y_ecef_sv10_t_T10 = x_k10*sin(lamda_k10)+ y_k10*cos(i_k10)*cos(lamda_k10);
z_ecef_sv10_t_T10 = y_k10*sin(i_k10);

SV10_mag_at_t_T10 = sqrt(x_ecef_sv10_t_T10^2 + y_ecef_sv10_t_T10^2 + z_ecef_sv10_t_T10^2);

% Now get SV 10 position at the time of reception: tR:   [km]
x_ecef_sv10_t_R = cos(we*tau10)*x_ecef_sv10_t_T10 + sin(we*tau10)*y_ecef_sv10_t_T10 + 0;
y_ecef_sv10_t_R = -sin(we*tau10)*x_ecef_sv10_t_T10 + cos(we*tau10)* y_ecef_sv10_t_T10 + 0;
z_ecef_sv10_t_R = z_ecef_sv10_t_T10;

SV10_mag_at_tR = sqrt(x_ecef_sv10_t_R^2 + y_ecef_sv10_t_R^2 + z_ecef_sv10_t_R^2);




% % %====================== SV 23 =================================:


e_23 = eph(6,9); 
sqrt_sma_23 =  eph(6,10);     % [(m^1/2)]
delta_N_23 = eph(6,11);     % [rad/s]
M_0_23 = eph(6,12);    % [rad]
AOP_23 = eph(6,13);    % [rad]
lamda_0_23 = eph(6,14);   % [rad]
i_0_23 = eph(6,15); % [rad]
RAAN_dot_23 = eph(6,16);  % [rad]
I_DOT_23 = eph(6,17);   % [rad/s]

C_u_s_23 = eph(6,18);   % [rad]
C_u_c_23 = eph(6,19);    %[rad]

C_i_s_23 = eph(6,20);    %[rad]
C_i_c_23 = eph(6,21);    %[rad]

C_r_s_23 = eph(6,22)/1000;    %[km]
C_r_c_23 = eph(6,23)/1000;    %[km]
 
% t = [172800:900:258300]';
% t_k = [t - toe];

tR = eph(1,1);   % time of reception
toe_23 =  eph(6,4);
% tb_R = 0;     % Initial GUESS in Receiver clock bias

c_rho23 = rcvrc(6,3)/1000;   %   SV 23 corrected pseudorange [km] 

tau23 = (c_rho23 - c*tb_R)/c;    
t_T23 = tR - [tau23];   % time of TRANSMISSION of SV 23  [s]
tk23 = t_T23 - toe_23;

a23 = [sqrt_sma_23^2]/1000;   % now sma is in [Km]
n023 = sqrt(mu/(a23^3));  % [ 1/sec]
n23 = n023 + delta_N_23;
Mk23 = (M_0_23 + n23*tk23);   % [rad] 
% Mk23 = (M_0_23 + n23*t_T23);   % [rad] 

Ek23 = kepler_E(e_23, Mk23);  % [rad]
theta_k23 = 2*atan(sqrt((1+e_23)/(1-e_23))*tan(Ek23/2));  %[rad]
% 
phi_k23 = theta_k23 + AOP_23;   % [rad]
delta_uk23 = C_u_s_23*sin(2*phi_k23) + C_u_c_23*cos(2*phi_k23);  % [rad]
delta_rk23 = C_r_s_23*sin(2*phi_k23) + C_r_c_23*cos(2*phi_k23);   % [km]
delta_ik23 = C_i_s_23*sin(2*phi_k23) + C_i_c_23*cos(2*phi_k23);   % [rad]
% 
u_k23 = phi_k23 + delta_uk23;    % [rad]
r_k23 = a23*(1-e_23*cos(Ek23)) + delta_rk23;   % [km]
i_k23 = i_0_23 + (I_DOT_23*tk23) + delta_ik23;  % [rad]
% i_k23 = i_0_23 + (I_DOT_23*t_T23) + delta_ik23;  % [rad]

lamda_k23 = lamda_0_23 + (RAAN_dot_23 - we)*tk23 - we*toe_23;
% lamda_k23 = lamda_0_23 + (RAAN_dot_23 - we)*t_T23 - we*toe_23;

x_k23 = r_k23*cos(u_k23);    % all in [km]
y_k23 = r_k23*sin(u_k23);
z_k23 = 0;

% SV 23 position at t_T23  [km]
x_ecef_sv23_t_T23 = x_k23*cos(lamda_k23) - y_k23*cos(i_k23)*sin(lamda_k23);
y_ecef_sv23_t_T23 = x_k23*sin(lamda_k23)+ y_k23*cos(i_k23)*cos(lamda_k23);
z_ecef_sv23_t_T23 = y_k23*sin(i_k23);

SV23_mag_at_t_T23 = sqrt(x_ecef_sv23_t_T23^2 + y_ecef_sv23_t_T23^2 + z_ecef_sv23_t_T23^2);

% Now get SV 23 position at the time of reception: tR:   [km]
x_ecef_sv23_t_R = cos(we*tau23)*x_ecef_sv23_t_T23 + sin(we*tau23)*y_ecef_sv23_t_T23 + 0;
y_ecef_sv23_t_R = -sin(we*tau23)*x_ecef_sv23_t_T23 + cos(we*tau23)* y_ecef_sv23_t_T23 + 0;
z_ecef_sv23_t_R = z_ecef_sv23_t_T23;

SV23_mag_at_tR = sqrt(x_ecef_sv23_t_R^2 + y_ecef_sv23_t_R^2 + z_ecef_sv23_t_R^2);





% % %====================== SV 22 =================================:

% 
e_22 = eph(7,9); 
sqrt_sma_22 =  eph(7,10);     % [(m^1/2)]
delta_N_22 = eph(7,11);     % [rad/s]
M_0_22 = eph(7,12);    % [rad]
AOP_22 = eph(7,13);    % [rad]
lamda_0_22 = eph(7,14);   % [rad]
i_0_22 = eph(7,15); % [rad]
RAAN_dot_22 = eph(7,16);  % [rad]
I_DOT_22 = eph(7,17);   % [rad/s]

C_u_s_22 = eph(7,18);   % [rad]
C_u_c_22 = eph(7,19);    %[rad]

C_i_s_22 = eph(7,20);    %[rad]
C_i_c_22 = eph(7,21);    %[rad]

C_r_s_22 = eph(7,22)/1000;    %[km]
C_r_c_22 = eph(7,23)/1000;    %[km]
 
% t = [172800:900:258300]';
% t_k = [t - toe];

tR = eph(1,1);   % time of reception
toe_22 =  eph(7,4);
% tb_R = 0;     % Initial GUESS in Receiver clock bias

c_rho22 = rcvrc(7,3)/1000;   %   SV 22 corrected pseudorange [km] 

tau22 = (c_rho22 - c*tb_R)/c;    
t_T22 = tR - [tau22];   % time of TRANSMISSION of SV 22  [s]
tk22 = t_T22 - toe_22;

a22 = [sqrt_sma_22^2]/1000;   % now sma is in [Km]
n022 = sqrt(mu/(a22^3));  % [ 1/sec]
n22 = n022 + delta_N_22;
Mk22 = (M_0_22 + n22*tk22);   % [rad]
% Mk22 = (M_0_22 + n22*t_T22);   % [rad]

Ek22 = kepler_E(e_22, Mk22);  % [rad]
theta_k22 = 2*atan(sqrt((1+e_22)/(1-e_22))*tan(Ek22/2));  %[rad]
% 
phi_k22 = theta_k22 + AOP_22;   % [rad]
delta_uk22 = C_u_s_22*sin(2*phi_k22) + C_u_c_22*cos(2*phi_k22);  % [rad]
delta_rk22 = C_r_s_22*sin(2*phi_k22) + C_r_c_22*cos(2*phi_k22);   % [km]
delta_ik22 = C_i_s_22*sin(2*phi_k22) + C_i_c_22*cos(2*phi_k22);   % [rad]
% 
u_k22 = phi_k22 + delta_uk22;    % [rad]
r_k22 = a22*(1-e_22*cos(Ek22)) + delta_rk22;   % [km]
i_k22 = i_0_22 + (I_DOT_22*tk22) + delta_ik22;  % [rad]
% i_k22 = i_0_22 + (I_DOT_22*t_T22) + delta_ik22;  % [rad]

lamda_k22 = lamda_0_22 + (RAAN_dot_22 - we)*tk22 - we*toe_22;
% lamda_k22 = lamda_0_22 + (RAAN_dot_22 - we)*t_T22 - we*toe_22;

x_k22 = r_k22*cos(u_k22);    % all in [km]
y_k22 = r_k22*sin(u_k22);
z_k22 = 0;

% SV 22 position at t_T22  [km]
x_ecef_sv22_t_T22 = x_k22*cos(lamda_k22) - y_k22*cos(i_k22)*sin(lamda_k22);
y_ecef_sv22_t_T22 = x_k22*sin(lamda_k22)+ y_k22*cos(i_k22)*cos(lamda_k22);
z_ecef_sv22_t_T22 = y_k22*sin(i_k22);

SV22_mag_at_t_T22 = sqrt(x_ecef_sv22_t_T22^2 + y_ecef_sv22_t_T22^2 + z_ecef_sv22_t_T22^2);

% Now get SV 22 position at the time of reception: tR:   [km]
x_ecef_sv22_t_R = cos(we*tau22)*x_ecef_sv22_t_T22 + sin(we*tau22)*y_ecef_sv22_t_T22 + 0;
y_ecef_sv22_t_R = -sin(we*tau22)*x_ecef_sv22_t_T22 + cos(we*tau22)* y_ecef_sv22_t_T22 + 0;
z_ecef_sv22_t_R = z_ecef_sv22_t_T22;

SV22_mag_at_tR = sqrt(x_ecef_sv22_t_R^2 + y_ecef_sv22_t_R^2 + z_ecef_sv22_t_R^2);




% % %====================== SV 26 =================================:


e_26 = eph(8,9); 
sqrt_sma_26 =  eph(8,10);     % [(m^1/2)]
delta_N_26 = eph(8,11);     % [rad/s]
M_0_26 = eph(8,12);    % [rad]
AOP_26 = eph(8,13);    % [rad]
lamda_0_26 = eph(8,14);   % [rad]
i_0_26 = eph(8,15); % [rad]
RAAN_dot_26 = eph(8,16);  % [rad]
I_DOT_26 = eph(8,17);   % [rad/s]

C_u_s_26 = eph(8,18);   % [rad]
C_u_c_26 = eph(8,19);    %[rad]

C_i_s_26 = eph(8,20);    %[rad]
C_i_c_26 = eph(8,21);    %[rad]

C_r_s_26 = eph(8,22)/1000;    %[km]
C_r_c_26 = eph(8,23)/1000;    %[km]
 
% t = [172800:900:258300]';
% t_k = [t - toe];

tR = eph(1,1);   % time of reception
toe_26 =  eph(8,4);
% tb_R = 0;     % Initial GUESS in Receiver clock bias

c_rho26 = rcvrc(8,3)/1000;   %   SV 26 corrected pseudorange [km] 

tau26 = (c_rho26 - c*tb_R)/c;    
t_T26 = tR - [tau26];   % time of TRANSMISSION of SV 26  [s]
tk26 = t_T26 - toe_26;

a26 = [sqrt_sma_26^2]/1000;   % now sma is in [Km]
n026 = sqrt(mu/(a26^3));  % [ 1/sec]
n26 = n026 + delta_N_26;
Mk26 = (M_0_26 + n26*tk26);   % [rad]
% Mk26 = (M_0_26 + n26*t_T26);   % [rad]

Ek26 = kepler_E(e_26, Mk26);  % [rad]
theta_k26 = 2*atan(sqrt((1+e_26)/(1-e_26))*tan(Ek26/2));  %[rad]
% 
phi_k26 = theta_k26 + AOP_26;   % [rad]
delta_uk26 = C_u_s_26*sin(2*phi_k26) + C_u_c_26*cos(2*phi_k26);  % [rad]
delta_rk26 = C_r_s_26*sin(2*phi_k26) + C_r_c_26*cos(2*phi_k26);   % [km]
delta_ik26 = C_i_s_26*sin(2*phi_k26) + C_i_c_26*cos(2*phi_k26);   % [rad]
% 
u_k26 = phi_k26 + delta_uk26;    % [rad]
r_k26 = a26*(1-e_26*cos(Ek26)) + delta_rk26;   % [km]
i_k26 = i_0_26 + (I_DOT_26*tk26) + delta_ik26;  % [rad]
% i_k26 = i_0_26 + (I_DOT_26*t_T26) + delta_ik26;  % [rad]

lamda_k26 = lamda_0_26 + (RAAN_dot_26 - we)*tk26 - we*toe_26;
% lamda_k26 = lamda_0_26 + (RAAN_dot_26 - we)*t_T26 - we*toe_26;

x_k26 = r_k26*cos(u_k26);    % all in [km]
y_k26 = r_k26*sin(u_k26);
z_k26 = 0;

% SV 26 position at t_T26  [km]
x_ecef_sv26_t_T26 = x_k26*cos(lamda_k26) - y_k26*cos(i_k26)*sin(lamda_k26);
y_ecef_sv26_t_T26 = x_k26*sin(lamda_k26)+ y_k26*cos(i_k26)*cos(lamda_k26);
z_ecef_sv26_t_T26 = y_k26*sin(i_k26);

SV26_mag_at_t_T26 = sqrt(x_ecef_sv26_t_T26^2 + y_ecef_sv26_t_T26^2 + z_ecef_sv26_t_T26^2);

% Now get SV 26 position at the time of reception: tR:   [km]
x_ecef_sv26_t_R = cos(we*tau26)*x_ecef_sv26_t_T26 + sin(we*tau26)*y_ecef_sv26_t_T26 + 0;
y_ecef_sv26_t_R = -sin(we*tau26)*x_ecef_sv26_t_T26 + cos(we*tau26)* y_ecef_sv26_t_T26 + 0;
z_ecef_sv26_t_R = z_ecef_sv26_t_T26;

SV26_mag_at_tR = sqrt(x_ecef_sv26_t_R^2 + y_ecef_sv26_t_R^2 + z_ecef_sv26_t_R^2);


%% Initial GUESS of Receiver's position: [km]   magnitude 6373 km

% Now form Goemetric range of all 8 satellites based on Initial GUESS
% Receiver's position  [Km]

r_5 = sqrt((x_R - x_ecef_sv5_t_R)^2 + (y_R - y_ecef_sv5_t_R)^2 + (z_R - z_ecef_sv5_t_R)^2)
r_6 = sqrt((x_R - x_ecef_sv6_t_R)^2 + (y_R - y_ecef_sv6_t_R)^2 + (z_R - z_ecef_sv6_t_R)^2)
r_17 = sqrt((x_R - x_ecef_sv17_t_R)^2 + (y_R - y_ecef_sv17_t_R)^2 + (z_R - z_ecef_sv17_t_R)^2)
r_30 = sqrt((x_R - x_ecef_sv30_t_R)^2 + (y_R - y_ecef_sv30_t_R)^2 + (z_R - z_ecef_sv30_t_R)^2)
r_10 = sqrt((x_R - x_ecef_sv10_t_R)^2 + (y_R - y_ecef_sv10_t_R)^2 + (z_R - z_ecef_sv10_t_R)^2)
r_23 = sqrt((x_R - x_ecef_sv23_t_R)^2 + (y_R - y_ecef_sv23_t_R)^2 + (z_R - z_ecef_sv23_t_R)^2)
r_22 = sqrt((x_R - x_ecef_sv22_t_R)^2 + (y_R - y_ecef_sv22_t_R)^2 + (z_R - z_ecef_sv22_t_R)^2)
r_26 = sqrt((x_R - x_ecef_sv26_t_R)^2 + (y_R - y_ecef_sv26_t_R)^2 + (z_R - z_ecef_sv26_t_R)^2)


% H matrix:

H = [(x_R -x_ecef_sv5_t_R)/r_5  (y_R -y_ecef_sv5_t_R)/r_5  (z_R -z_ecef_sv5_t_R)/r_5  1;
    (x_R -x_ecef_sv6_t_R)/r_6  (y_R -y_ecef_sv6_t_R)/r_6  (z_R -z_ecef_sv6_t_R)/r_6  1;
    (x_R -x_ecef_sv17_t_R)/r_17  (y_R -y_ecef_sv17_t_R)/r_17  (z_R -z_ecef_sv17_t_R)/r_17  1;
    (x_R -x_ecef_sv30_t_R)/r_30  (y_R -y_ecef_sv30_t_R)/r_30  (z_R -z_ecef_sv30_t_R)/r_30  1;
    (x_R -x_ecef_sv10_t_R)/r_10  (y_R -y_ecef_sv10_t_R)/r_10  (z_R -z_ecef_sv10_t_R)/r_10  1;
    (x_R -x_ecef_sv23_t_R)/r_23  (y_R -y_ecef_sv23_t_R)/r_23  (z_R -z_ecef_sv23_t_R)/r_23  1;
    (x_R -x_ecef_sv22_t_R)/r_22  (y_R -y_ecef_sv22_t_R)/r_22  (z_R -z_ecef_sv22_t_R)/r_22  1;
    (x_R -x_ecef_sv26_t_R)/r_26  (y_R -y_ecef_sv26_t_R)/r_26  (z_R -z_ecef_sv26_t_R)/r_26  1]


I = eye(4);

M_trans = linsolve(H',I');

M = M_trans';

check = M*H

%observation vector Y:  [8 x 1]  [Km]
Y = [c_rho5 c_rho6 c_rho17 c_rho30 c_rho10 c_rho23 c_rho22 c_rho26]';

% h: [km]
h = [ (r_5+ c*tb_R) (r_6+ c*tb_R) (r_17 + c*tb_R) (r_30 + c*tb_R) (r_10 + c*tb_R) (r_23 + c*tb_R) (r_22 + c*tb_R) (r_26 + c*tb_R)]' ;

% little y: [8 x 1] [km]
little_y = Y - h;

% Estimated location of Receiver
x_hat_meters = (M*little_y)*1000;
x_hat_km = M*little_y;

% Previous iteration x_hat values
previous_x_hat = [x_R y_R z_R tb_R]';   % [km km km s]
previous_x_hat_meters = [previous_x_hat(1)*1000 previous_x_hat(2)*1000 previous_x_hat(3)*1000 previous_x_hat(4)]'    % [m m m s]

% output after each iteration
disp('Output after each iteration:')
tb_R_output = x_hat_km(4)/c
x_R_output = x_hat_km(1)
y_R_output = x_hat_km(2)
z_R_output = x_hat_km(3)

magnitude_x_hat_output_km = sqrt(x_hat_km(1)^2 + x_hat_km(2)^2 + x_hat_km(3)^2)

% Update the guess:
disp('Updated x_hat and using these updated values new iteration will run:')
     tb_R =  previous_x_hat(4) + x_hat_km(4)/c 
     x_R = previous_x_hat(1) + x_hat_km(1)
     y_R = previous_x_hat(2) + x_hat_km(2) 
     z_R = previous_x_hat(3) + x_hat_km(3)

     n = n+1
end
 
lla_rizwan = ecef2lla([previous_x_hat_meters(1) previous_x_hat_meters(2) previous_x_hat_meters(3)])

% Geometry matrix:
G = inv(H'*H)

%GDOP
GDOP = sqrt(trace(G))

% PDOP
PDOP = sqrt(G(1,1) + G(2,2)+ G(3,3))

%TDOP
TDOP = sqrt(G(4,4))
 