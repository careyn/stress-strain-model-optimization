%% CALIBRATION CODE FOR BI-AXIAL STRESS STATES
% Version 2.0.0
% Updated: November 12, 2021
% Veli Bugra Ozdemir

% Takes in the Excel files (which must include data in ordered column-wise in predefined order)
% Calls in related functions to smooth, polynomial fit, discretize and
% return the tests in a cell.
% Output: A text file with date- including Si3 optimization result
           %Save the .mat file to be called later
           
%clear and set directory
clear all
clc
close all
cd

%Find the csv files and put their names in the list
listing=dir('**/*.csv');
listing1=dir('**/*.xlsx');
listing=[listing;listing1];
k=0;

%Ask for which formulation to be used, define is as global
%Small strain formulation (small volumetric strain definition)
%Large strain formulation (precise volumetric strain definition)

global Formulation
Formulation=input('Small or large strain formulation?')                     %Formulation of the strain
FormulationStrain=input('Engr.-Engr. or PK2-GL?')                           %Formulation of the strain
mfname=mfilename()                                                          %get the filename to include it in the plots

%% READ TEST DATA & ASSIGN NAMES
%sort the tests with respect to stress level and temperature

for i=1:length(listing)
    if contains(listing(i).name,'DIC_')
         if contains(listing(i).name,'T20') || contains(listing(i).name,'T20')
            test_return{i}=BADataExtractCylinder(listing(i).name,22,Formulation, FormulationStrain)
        elseif contains(listing(i).name,'T10')
            test_return{i}=BADataExtractCylinder(listing(i).name,10,Formulation, FormulationStrain)
        elseif contains(listing(i).name,'T0')
            test_return{i}=BADataExtractCylinder(listing(i).name,-10,Formulation, FormulationStrain)
        elseif contains(listing(i).name,'TM10')
            test_return{i}=BADataExtractCylinder(listing(i).name,-20,Formulation, FormulationStrain)
        elseif contains(listing(i).name,'TM30')
            test_return{i}=BADataExtractCylinder(listing(i).name,-30,Formulation, FormulationStrain)
        end   
    end
end

%% MATERIAL VARIABLES

%This section reads material properties of SF420. The file for compliances
%is changed for optimization (S_SF420----->SF420OptimizationSi3).

[tauj, S110, S11j, S120, S12j,S220, S22j, S660, S66j] = SF420OptimizationSi3

%WLF coefficients
[c1, c2, T0]=c1c2T0_SF420;

kappa=0.55373785;

%volumetric strain coefficient
deltav=1;

%distortion strain coefficient
deltad=0.45013846;

%% OPTIMIZATION BODY
%This section is the main body of the code.

%Define test data and material properties as global variables so they can
%be used in objective function.

timestep=10;

%must exclude optimization variables S13j (and S130 if not fixed)
global c1 c2 T0 deltad deltav tauj S110 S11j S120 S12j 
global S220 S22j S660 S66j kappa wi 

wi=ones(length(test_return));                                               %test weights

%global S130   %<-----%uncomment if S130 is not included in optimization

global test_return
global timestep

% optimization options
MaxFunEval=1e5;
StepTol=1e-16;
OptimTol=1e-16;
MaxIter=200;

%interior-point algorithm is used
options = optimoptions('fmincon','Display','iter','Algorithm',...
    'interior-point','MaxIterations',MaxIter,'OptimalityTolerance',...
    OptimTol,'StepTolerance',StepTol,'MaxFunctionEvaluations',MaxFunEval);

%Define upper and lower bounds for the optimization varible.
UB=zeros(1,40) ;                                                             %Si3 elements should be negative
LB=-5e-3*ones(1,40);                                                         %limit the lower bound of Si3 elements

%Give a large initial objective function value, later is used to decide if
%new Si3 is better than previous. Different weights on the test data will
%affect this value.
compare=1e5;

% It is possible to define inital guesses as some ratio of LB, or it is
% also possible to give initial guess as some ratio of S11. The latter is
% chosen for this code.
for Diff=1:20
    
%start with initial guess
init=-[S11j,S110,S22j,S220]*Diff/20; 

optimvar('Si3j',1,40) %Optimization variable name, Si3j, shown for
                      %including Si30 (therefore 40 elements).

[Si3j,fval,exitflag,output]=fmincon(@BACalibrationObjectiveV200,init,[],[],[],[],LB,UB,...
    [],options);      %Optimization, BACalibrationObjective is the objective function.

% Compare if end objective function value is lower than previous value.
if  fval<compare
    Si3jbest=Si3j;      %assign result as S13jbest
    init_best=Diff;     %save corresponding initial guess
    compare=fval;       %update comparison value for the next initial guess
end

Diff        %Display which initial guess is completed.
end

Si3jbest   %Display the best of the S13j results.
si3FileName=['Si3jBest',datestr(now, 'dd-mmm-yyyy'),''];
save(si3FileName,'Si3jbest')
%---------------------------------------------------------------------------------------END OF THE CALIBRATION CODE


%% Validate the calibration
%use BAValidationofCalibrationCylinder.m code

for i=1:length(test_return)
    BAValidationofCalibrationCylinder(test_return{i},FormulationStrain);
end

stampit('d')
stampit('f')
