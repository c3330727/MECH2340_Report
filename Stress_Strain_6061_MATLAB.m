%MECH2430 Report anyalysis
%

close all
clear all
clc
format long

filename = 'Stress_Strain_6061_F.txt';
fileID = fopen(filename);
C = textscan(fileID,'%s');
fclose(fileID);
whos C

A = [C{:}];
A = cellfun(@str2double,A);




lengthx = length(A);
LENC =1;
FORC = 1;
area = 62.5e-6;
LENo = 39.96542567;



for i=1:2:lengthx
    
    Len(LENC) = A(i,1);
    LENC = LENC +1;
end

for j=2:2:lengthx
    
    FOR(FORC) = A(j,1);
    FORC = FORC+1;
end



for i=1:length(Len)
    
    SLen = Len(i);
    Strain(i) = ((SLen-LENo)/LENo);
end

for i = 1:length(FOR)

    SFOR = FOR(i);
    Stress(i) = (((SFOR)*10^3)/area);
end

E = (Stress(5150)-Stress(100))/(Strain(5150)-Strain(100));

figure, plot(Strain,Stress)
xlabel('Strain')
ylabel('Stress')
title('6061-T6 Stress-Strain Graph')
ax = gca;
ax.YAxis.Exponent = 6;
dim = [0.5 0.3 0.3 0.3];
str = {'E = 69.63 GPa','Rupture load = 18.1 KN','Rupture elongation = 0.2'};
annotation('textbox',dim,'String',str,'FitBoxToText','on');

