% AAE 575. HW 3. Rizwan Qureshi.
% PROBLEM 4 & 5:

clear all; clc; close all;

%%%%%%%%%%%% Problem 4 %%%%%%%%%%%%%%%%%%%%

load DH010600.mat;

data_used_in_models = DH010600;

GPS_t1 = data_used_in_models(:,6);   % [secs]

P0 = data_used_in_models(:,7);   % surface atmospheric pressure [mbar]
T0_C = data_used_in_models(:,8);   % Surface atmospheric temperature. [Celcius]
T0_K = T0_C + 273.15;               %  Surface atmospheric temperature. [Kelvin]
RH = data_used_in_models(:,9)/100;     %Relative humidity converted into decimals

phi = 33.390;     % [Deg]

phi_array = [ones(1,144)*phi]';    % [Deg]

%Compute water vapor e0:
e0 = 6.108*RH.*exp((17.15*T0_K-4684)./(T0_K-38.5));    % [mbar]

%Compute Sasstamoinen Model DRY and WET Zeneith Delay:

Dry_delay_S_model = 0.0022777*(1+0.0026*cosd(2*phi_array)).*P0;     % [meters] 
Wet_delay_S_model = 0.0022777*(1255./T0_K + 0.05).*e0;    %[ meters]

% Now compute Hopfield Model DRY and WET Zeneith Delays:

hd = 40136 + 148.72*(T0_K - 273.16);   % [meters]
hw = 11000;        % [meters]

Dry_delay_H_model = (77.64e-6*P0.*hd)./(5*T0_K);    % [meters]
Wet_delay_H_model = (0.373*e0*hw)./(5*(T0_K.^2));    % [meters]


%%%%%%%%%%%% Problem 5 %%%%%%%%%%%%%%%%%%%%


%====== Optional 'for' loop. Can use 'while' loop or 'for' loop:==========
% w = 1;
% %Elevation angle  [Deg]
% for El = [5 15 45 85];    
% 
% %simple flat-Earth mapping function:
% 
% md = 1./(sind(El));
% mw = 1./(sind(El));
% 
% Total_delay_Flat_Earth_S_model(:,w) = md* Dry_delay_S_model + mw*Wet_delay_S_model;
% Total_delay_Flat_Earth_H_model(:,w) = md* Dry_delay_H_model + mw*Wet_delay_H_model;
% 
% w = w+1;
% end
% 
% 
% w = 1;
% %Elevation angle  [Deg]
% for El = [5 15 45 85];    
% 
% %simple flat-Earth mapping function:
% 
% md_m = 1./sqrt(1-((cosd(El)./1.001)).^2);
% mw_m = 1./sqrt(1-((cosd(El)./1.001)).^2);
% 
% Total_delay_Misra_S_model(:,w) = md_m* Dry_delay_S_model + mw_m*Wet_delay_S_model;
% Total_delay_Misra_H_model(:,w) = md_m* Dry_delay_H_model + mw_m*Wet_delay_H_model;
% 
% w = w+1;
% end
% 
% 
% w = 1;
% %Elevation angle  [Deg]
% for El = [5 15 45 85];    
% 
% %simple flat-Earth mapping function:
% 
% md_c = 1./[(sind(El) + (0.00143./(tand(El)+0.0445)))];
% mw_c = 1./[(sind(El) +(0.00035./(tand(El)+0.017)))];
% 
% Total_delay_Chao_S_model(:,w) = md_c* Dry_delay_S_model + mw_c*Wet_delay_S_model;
% Total_delay_Chao_H_model(:,w) = md_c* Dry_delay_H_model + mw_c*Wet_delay_H_model;
% 
% w = w+1;
% end


%========= Optional 'while' loop. Can use 'while' loop or 'for' loop:=====

%% simple flat-Earth mapping functions and TOTAL delay for S and H models:

El = [5 15 45 85]';
 
md = 1./(sind(El));
mw = 1./(sind(El));

n = 1;
while n<=4
Total_delay_Flat_Earth_S_model(:,n) = md(n)* Dry_delay_S_model + mw(n)*Wet_delay_S_model;    %[meters]
Total_delay_Flat_Earth_H_model(:,n) = md(n)* Dry_delay_H_model + mw(n)*Wet_delay_H_model;  %[meters]

n = n+1;
end
    
%% Mapping functions given in Misra & Enge & TOTAL delay for S & H models:

md_m = 1./sqrt(1-((cosd(El)./1.001)).^2);
mw_m = 1./sqrt(1-((cosd(El)./1.001)).^2);

n = 1;
while n<=4
Total_delay_Misra_S_model(:,n) = md_m(n)* Dry_delay_S_model + mw_m(n)*Wet_delay_S_model;  %[meters]
Total_delay_Misra_H_model(:,n) = md_m(n)* Dry_delay_H_model + mw_m(n)*Wet_delay_H_model; %[meters]

n = n+1;
end


% Mapping functions given by Chao & TOTAL delay for S & H models:

md_c = 1./[(sind(El) + (0.00143./(tand(El)+0.0445)))];
mw_c = 1./[(sind(El) +(0.00035./(tand(El)+0.017)))];

n = 1;
while n<=4
Total_delay_Chao_S_model(:,n) = md_c(n)* Dry_delay_S_model + mw_c(n)*Wet_delay_S_model;   %[meters]
Total_delay_Chao_H_model(:,n) = md_c(n)* Dry_delay_H_model + mw_c(n)*Wet_delay_H_model;  %[meters]


n = n+1;
end

%% Plots for Problem 4:

time = linspace(0,85800,144)';

figure(1)
plot(time,Wet_delay_S_model,'b')
hold on
plot(time,Wet_delay_H_model,'r')
xlabel('GPS time (seconds)')
ylabel('Wet zenith delay (meters)')
title('WET zenith tropospheric delay from Saastamoinen & Hopfield model') 
legend('Saastamoinen model','Hopfield model')
grid on

figure(2)
plot(time,Dry_delay_S_model,'b')
hold on
plot(time,Dry_delay_H_model,'r')
xlabel('GPS time (seconds)')
ylabel('Dry zenith delay (meters)')
title('DRY zenith tropospheric delay from Saastamoinen & Hopfield model') 
legend('Saastamoinen model','Hopfield model')
grid on


%% Plots for Problem 5:

figure(3)
plot(time,Total_delay_Flat_Earth_S_model(:,1),'b')
hold on
plot(time,Total_delay_Misra_S_model(:,1),'r')
plot(time,Total_delay_Chao_S_model(:,1),'k')
xlabel('GPS time (seconds)')
ylabel('Total tropospheric delay (meters)')
title('Total tropospheric delay using SAASTAMOINEN model @ 5 Degrees:')
grid on
legend('Flat earth mapping @ 5 Deg','Misra & Enge mapping @ 5 Deg','Chao mapping @ 5 Deg')


figure(4)
plot(time,Total_delay_Flat_Earth_H_model(:,1),'b')
hold on
plot(time,Total_delay_Misra_H_model(:,1),'r')
plot(time,Total_delay_Chao_H_model(:,1),'k')
xlabel('GPS time (seconds)')
ylabel('Total tropospheric delay (meters)')
title('Total tropospheric delay using HOPFIELD model @ 5 Degrees:')
grid on
legend('Flat earth mapping @ 5 Deg','Misra & Enge mapping @ 5 Deg','Chao mapping @ 5 Deg')


figure(5)
plot(time,Total_delay_Flat_Earth_S_model(:,2),'b')
hold on
plot(time,Total_delay_Misra_S_model(:,2),'r')
plot(time,Total_delay_Chao_S_model(:,2),'k')
xlabel('GPS time (seconds)')
ylabel('Total tropospheric delay (meters)')
title('Total tropospheric delay using SAASTAMOINEN model @ 15 Degrees:')
grid on
legend('Flat earth mapping @ 15 Deg','Misra & Enge mapping @ 15 Deg','Chao mapping @ 15 Deg')


figure(6)
plot(time,Total_delay_Flat_Earth_H_model(:,2),'b')
hold on
plot(time,Total_delay_Misra_H_model(:,2),'r')
plot(time,Total_delay_Chao_H_model(:,2),'k')
xlabel('GPS time (seconds)')
ylabel('Total tropospheric delay (meters)')
title('Total tropospheric delay using HOPFIELD model @ 15 Degrees:')
grid on
legend('Flat earth mapping @ 15 Deg','Misra & Enge mapping @ 15 Deg','Chao mapping @ 15 Deg')

figure(7)
plot(time,Total_delay_Flat_Earth_S_model(:,3),'b')
hold on
plot(time,Total_delay_Misra_S_model(:,3),'r')
plot(time,Total_delay_Chao_S_model(:,3),'k')
xlabel('GPS time (seconds)')
ylabel('Total tropospheric delay (meters)')
title('Total tropospheric delay using SAASTAMOINEN model @ 45 Degrees:')
grid on
legend('Flat earth mapping @ 45 Deg','Misra & Enge mapping @ 45 Deg','Chao mapping @ 45 Deg')

figure(8)
plot(time,Total_delay_Flat_Earth_H_model(:,3),'b')
hold on
plot(time,Total_delay_Misra_H_model(:,3),'r')
plot(time,Total_delay_Chao_H_model(:,3),'k')
xlabel('GPS time (seconds)')
ylabel('Total tropospheric delay (meters)')
title('Total tropospheric delay using HOPFIELD model @ 45 Degrees:')
grid on
legend('Flat earth mapping @ 45 Deg','Misra & Enge mapping @ 45 Deg','Chao mapping @ 45 Deg')


figure(9)
plot(time,Total_delay_Flat_Earth_S_model(:,4),'b')
hold on
plot(time,Total_delay_Misra_S_model(:,4),'r')
plot(time,Total_delay_Chao_S_model(:,4),'k')
xlabel('GPS time (seconds)')
ylabel('Total tropospheric delay (meters)')
title('Total tropospheric delay using SAASTAMOINEN model @ 85 Degrees:')
grid on
legend('Flat earth mapping @ 85 Deg','Misra & Enge mapping @ 85 Deg','Chao mapping @ 85 Deg')


figure(10)
plot(time,Total_delay_Flat_Earth_H_model(:,4),'b')
hold on
plot(time,Total_delay_Misra_H_model(:,4),'r')
plot(time,Total_delay_Chao_H_model(:,4),'k')
xlabel('GPS time (seconds)')
ylabel('Total tropospheric delay (meters)')
title('Total tropospheric delay using HOPFIELD model @ 85 Degrees:')
grid on
legend('Flat earth mapping @ 85 Deg','Misra & Enge mapping @ 85 Deg','Chao mapping @ 85 Deg')
