function [test_return]=BADataExtractCylinder(name,Temp,Formulation, FormulationStrain)
%% Geometrical parameters and parameters of discretization

%geometrical parameters
thickness=0.038;
D=126.9;

%discretization time step
timestep=10;

%% Read the test data from xlsx or csv file
if endsWith(name,'.xlsx')
 Test=xlsread(name,'Sheet1');
else 
 Test=xlsread(name,name(1:end-4));   
end

%% Polynomical fits and stress calculation
[m,n]=size(Test);                                                           %size of the file, m: rows
strain1=Test(1:m,1);                                                        %obtain strain1
strain2=Test(1:m,2);                                                        %obtain strain2
time=Test(1:m,5);                                                           %obtain time
load=Test(1:m,6);                                                           %obtain pressure
load=load-load(1);                                                          %remove the initial pressure
tfinal=time(end);                                                           %test duration, last element of time array

%Calculate the stresses- Stress1 is MD, Stress2 is in TD
stress1=1e-6.*load.*D./4./thickness;
stress2=1e-6.*load.*D./2./thickness;

%Polynomial fits
time_fit=[0:timestep:tfinal];                                               %create fitted time array
p_strain1=polyfit(time,strain1,15);                                         %polynomial coeff. for strain1
strain1_fitted=polyval(p_strain1, time_fit);                                %fitted strain1 values
p_strain2=polyfit(time,strain2,15);                                         %polynomial coeff. for strain2
strain2_fitted=polyval(p_strain2, time_fit);                                %fitted strain2 values

p_stress1=polyfit(time,stress1,15);                                         %polynomial coeff. for stress1
stress1_fitted=polyval(p_stress1, time_fit);                                %fitted stress1 values
p_stress2=polyfit(time,stress2,15);                                         %polynomial coeff. for stress2
stress2_fitted=polyval(p_stress2, time_fit);                                %fitted stress2 values
clear m n                                                                   %clear size of the test file

%reassign fitted data
strain1=strain1_fitted;                                                    
stress1=stress1_fitted;
strain2=strain2_fitted;                                                    
stress2=stress2_fitted;
time=time_fit;
clear tfinal strain1_fitted stress2_fitted time_fit strain2_fitted stress2_fitted

%calculate and attach the nominal temperature values as the last row
Temp=(Temp+273.15)*ones(1,length(time));

%test_return is imported as cell
test_return=[stress1;stress2;strain1;strain2;time;Temp];

end