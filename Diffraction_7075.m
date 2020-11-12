%Diffraction 7075

clc
clear all
close all

format long

filename = 'Diffraction_Data_7075_F.txt';
fileID = fopen(filename);
C = textscan(fileID,'%s');
fclose(fileID);
whos C

A = [C{:}];
A = cellfun(@str2double,A);

%counting variables
TEC = 1;
YC = 1;
ADC = 1;
AEC = 1;
TDC = 1;

%Poisson ratio
v =0.34;

%Modulas of elasticity
E = 70.99e9;

%original d spacing
d0 = 1.2188861; %Angstroms
d0err = (8e-6/d0)*100;

for i=1:length(A)
    
    n = mod(i,5);
    
switch n
    case 0
        T_error(TEC) = A(i);
        TEC = TEC + 1;
    case 1
        Y(YC) = A(i);
        YC = YC+1;
    case 2
        Axial_D(ADC) = A(i);
        ADC = ADC+1;
    case 3
        A_error(AEC) = A(i);
        AEC = AEC + 1;
    case 4
        Trans_D(TDC) = A(i);
        TDC = TDC + 1;
end
end
   
%Percent error calculations
for i = 1:19
    peT(i) = (T_error(i)/Trans_D(i))*100;
    peA(i) = (A_error(i)/Axial_D(i))*100;
end

%strain calculations
for i = 1:length(Axial_D)
    A_Strain(i) = (Axial_D(i) - d0)/d0;
    A_Strain_err(i) = (peA(i) + d0err + d0err);
    A_Strain_err1(i) = A_Strain(i).*A_Strain_err(i);
    T_Strain(i) = (Trans_D(i) - d0)/d0;
    T_Strain_err(i) = (peT(i) + d0err + d0err);
    T_Strain_err1(i) = T_Strain(i).*T_Strain_err(i);
    D_Strain(i) = ((T_Strain(i))-(A_Strain(i)));
    Hookes_Stress(i) = -1*E*D_Strain(i);
end

figure (1),errorbar(A_Strain,Y,A_Strain_err1)
title('Axial Strain')
ylabel('Position along the sample [mm]')
xlabel('Axial deformation')
ax = gca;
ax.XAxis.Exponent = -3;

figure (2),errorbar(T_Strain,Y,T_Strain_err1)
title('Transverse Strain')
ylabel('Position along the sample [mm]')
xlabel('Transverse deformation')
ax = gca;
ax.XAxis.Exponent = -3;


figure (3),plot(T_Strain,Y,'DisplayName','Tranverse Strain')
hold on
plot(A_Strain,Y,'DisplayName','Axial Strain')
title('7075-T6 Axial & Transverse Strain')
xlabel('Deformation')
ylabel('Position along the sample [mm]')
ax = gca;
ax.XAxis.Exponent = -3;
legend
hold off
% plot(D_Strain,Y,'DisplayName','Sum Strain')
% hold off

figure (4),plot(Hookes_Stress,Y,'DisplayName','Stress due to Hookes law')
title('7075-T6 Residual Elastic Stress Graph')
xlabel('Residual Stress [Pa]')
ylabel('Position along the sample [mm]')
xlim ([-250e6 250e6])
ax = gca;
ax.XAxis.Exponent = 6;
