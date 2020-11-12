%MECH2430 Report anyalysis

close all
clear all
clc
format long %gets more significant figure

%Accessing the data
filename = 'Stress_Strain_7075_F.txt';
fileID = fopen(filename);
C = textscan(fileID,'%s');
fclose(fileID);
whos C %Displaying what the data is

%Turning the cell into an array and keeping all the significant figures
A = [C{:}];
A = cellfun(@str2double,A);

%Setting variables
lengthx = length(A);
LENC =1;
FORC = 1;
area = 6.25e-5;
LENo = 39.930624;

%Sorting the single array into 2 seperate arrays

for i=1:2:lengthx
    
    Len(LENC) = A(i,1);
    LENC = LENC +1;
end

for j=2:2:lengthx
    
    FOR(FORC) = A(j,1);
    FORC = FORC+1;
end


%Calculation for strain
for i=1:length(Len)
    
    SLen = Len(i);
    Strain(i) = ((SLen-LENo)/LENo);
end

%Calculation for stress
for i = 1:length(FOR)

    SFOR = FOR(i);
    Stress(i) = (((SFOR)*10^3)/area);
end


E = (Stress(5100)-Stress(100))/(Strain(5100)-Strain(100));

%Plotting stress strain
figure, plot(Strain,Stress)
xlabel('Strain')
ylabel('Stress (MPa)')
title('7075-T6 Stress-Strain Graph')
ax = gca;
ax.YAxis.Exponent = 6;
xlim([-0.005 0.05]);
dim = [0.5 0.3 0.3 0.3];
str = {'E = 70.99 GPa','Rupture load = 34.7 KN','Rupture elongation = 0.18'};
annotation('textbox',dim,'String',str,'FitBoxToText','on');
