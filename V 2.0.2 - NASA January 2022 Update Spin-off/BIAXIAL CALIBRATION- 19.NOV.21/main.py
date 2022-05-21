import os
import math

import pandas as pd
import numpy as np

import matplotlib.pyplot as plt
import scipy

listings = []
cwd = os.getcwd()


Formulation = input('Small or large strain formulation?')
FormulationStrain = input('Engr.-Engr. or PK2-GL?')

def BADataExtractCylinder(listing):
    test = pd.read_csv(f'{cwd}/models/{listing}', names=['strain1', 'strain2', 'gamme', 'time_0', 'time', 'load'])
    test.drop([0,1], inplace=True)
    
    thickness = 0.038
    d = 126.9
    timestep = 10

    m = len(test)
    n = len(test.columns)

    load = test.load.array

    strain1 = list(map(float, test.strain1.array))
    strain2 = list(map(float, test.strain2.array))

    stress1 = []
    stress2 = []

    for i in load:
        stress1.append(float(i)*(1e-6)*d/4/thickness)
        stress2.append(float(i)*(1e-6)*d/2/thickness)

    time = list(map(float, test.time.array))
    tfinal = float(time[-1]) + 1

    time_fit=[i for i in range (0, math.floor(tfinal), timestep)]

    p_strain1 = np.polyfit(time,strain1,15)        
    strain1_fitted = np.polyval(p_strain1, time_fit)
    p_strain2 = np.polyfit(time,strain2,15)         
    strain2_fitted = np.polyval(p_strain2, time_fit)

    p_stress1 = np.polyfit(time,stress1,15)      
    stress1_fitted = np.polyval(p_stress1, time_fit)
    p_stress2 = np.polyfit(time,stress2,15)        
    stress2_fitted = np.polyval(p_stress2, time_fit)
        
    if 'T20' in listing:
        temp = 22 + 273.15
    elif 'T10' in listing:
        temp = 10 + 273.15
    elif 'T0' in listing:
        temp = -10 + 273.15
    elif 'TM10' in listing:
        temp = -20 + 273.15
    elif 'TM20' in listing:
        temp = -30 + 273.15

    # plt.plot(time,strain1,'r')
    # plt.show()
    # plt.plot(time_fit,strain1_fitted,'b')
    # plt.show()
    # plt.plot(time,strain2,'r')
    # plt.show()
    # plt.plot(time_fit,strain2_fitted,'b')
    # plt.show()
    # plt.plot(time,stress1,'r')
    # plt.show()
    # plt.plot(time_fit,stress1_fitted,'b')
    # plt.show()
    # plt.plot(time,stress2,'r')
    # plt.show()
    # plt.plot(time_fit,stress2_fitted,'b')
    # plt.show()
    
    temp = np.ones(len(time))*temp

    return [stress1_fitted, stress2_fitted, strain1_fitted, strain2_fitted, time_fit, temp]

for file in os.listdir(f'{cwd}/models/'):
    if (file.endswith('.csv') or file.endswith('.xlsx')) and file.startswith('DIC_'):
        listings.append(file)

test_return = list(map(BADataExtractCylinder, listings))


# Retardation time [s]
tauj= [1e-9, 1e-8, 1e-7, 1e-6, 1e-5, 1e-4, 1e-3, 1e-2, 1e-1, 1, 1e1, 1e2, 1e3, 1e4, 1e5, 1e6, 1e7, 1e8, 1e9]

# Prony coefficients [1/MPa]
S110 = 3e-4
S11j = [1.7427440e-4, 6.5109057e-6, 6.2842691e-5, 1.0754311e-4, 5.8577103e-5, 1.5508027e-4, 2.8438661e-4, 4.5671545e-4, 6.4613944e-4, 8.6980460e-4, 1.0174406e-3, 1.1201386e-3, 1.0881332e-3, 8.6245215e-4, 1.0593370e-3, 1.1494698e-3, 1.4144114e-3, 9.2623404e-4, 1.3703076e-4]   

S120 = -1.5e-4
S12j=[-6.1737e-6,-2.7396e-5,-5.1691e-5,-5.7504e-5,-9.2453e-6,-1.3158e-4,-1.9545e-4,-2.4264e-4,-3.9097e-4,-5.3432e-4,-6.8591e-4,-6.4146e-4,-5.7814e-4,-6.4545e-4,-6.1626e-4,-6.1421e-4,-1.0500e-3,-5.3076e-4,-6.8429e-5]

S130 = -1.42418e-6
S13j = [-2.94260e-7, -2.60235e-6, -3.91402e-6, -9.80110e-6, -3.88945e-5, -1.50292e-4, -2.70773e-4, -4.03437e-4, -3.68015e-4, -8.14446e-4, -1.23578e-3, -7.55748e-4, -4.97460e-5, -7.69745e-4, -1.70232e-3, -1.23267e-3, -1.07432e-3, -1.61572e-3, -9.04155e-4]

S220 = 3e-4
S22j = [1.0998367e-4, 5.8649043e-5, 2.4142765e-5, 4.2217698e-5, 1.5062738e-4, 9.6093116e-5, 2.5979678e-4, 4.4622050e-4, 4.7933786e-4, 5.9115290e-4, 7.5112198e-4, 1.2373818e-3, 1.2622477e-3, 6.4407837e-4, 8.2459510e-4, 9.4358983e-4, 1.7421522e-3, 7.7977930e-4, 9.7438006e-5]

S230 = -1.78959494265527e-6
S23j = [-6.463413e-7, -2.367780e-7, -1.843346e-6, -8.161107e-6, -1.731679e-5, -9.375704e-5, -1.941175e-4, -2.577841e-4, -2.824516e-4, -2.883614e-4, -6.567791e-4, -1.079825e-3, -1.112533e-3, -6.870455e-4, -4.266290e-4, -8.676502e-5, -2.424724e-3, -1.234290e-3, -2.180432e-03]    

S660 = 0.0012
S66j = [1.5048241e-6, 4.8564773e-7, 1.1495912e-4, 3.4537697e-4, 4.4141444e-4, 3.7851546e-4, 1.9050740e-3, 1.2369637e-3, 2.9077949e-3, 1.5893981e-3, 4.3942746e-3, 3.5281134e-3, 1.4208478e-3, 2.0412667e-3, 6.8347953e-3, 2.6735171e-3, 4.6575021e-3, 4.9645784e-3, 4.9958466e-3]


# Var initialization
c1=382.2
c2=3539.3
T0=293.16

kappa=0.55373785
deltav=1
deltad=0.45013846


# - Optimization Code -

timestep=10

wi = np.ones(len(test_return))

MaxFunEval = 1e5
StepTol = 1e-16
OptimTol = 1e-16
MaxIter = 200

# Define upper and lower bounds for the optimization varible.
UB = np.zeros(40)                                                        
LB = np.ones(40)*-5e-3                                                      

# Very large initial comparison to begin the optimization
compare=1e5


# TODO: Take the following Optimization logic and implement with the scipy interior point algorithm 

# - Option values for the scipy interior point algorithm
# options = optimoptions('fmincon','Display','iter','Algorithm',...
#     'interior-point','MaxIterations',MaxIter,'OptimalityTolerance',...
#     OptimTol,'StepTolerance',StepTol,'MaxFunctionEvaluations',MaxFunEval)

for Diff in range(0,20):    
    init = -[S11j,S110,S22j,S220]*Diff/20; 
    optimvar('Si3j',1,40)

# - Optimization, BACalibrationObjective is the objective function.
# [Si3j,fval,exitflag,output] = fmincon(BACalibrationObjectiveV200(),init,[],[],[],[],LB,UB,[],options);

scipy.optimize.minimize(method='trust-constr')

# - Compare if end objective function value is lower than previous value.
if  (fval < compare):
    Si3jbest = Si3j   # assign result as S13jbest
    init_best = Diff  # save corresponding initial guess
    compare = fval    # update comparison value for the next initial guess

# si3FileName=['Si3jBest',datestr(now, 'dd-mmm-yyyy'),''];
# save(si3FileName,'Si3jbest')


def BAValidationofCalibrationCylinder(tret, formulationStrain):
    pass

# - Calibration Code - 
for i in test_return:
    BAValidationofCalibrationCylinder(test_return,FormulationStrain)


# stampit('d')
# stampit('f')

