import copy
from alpha import alpha_SF420
from a_sf import a_SF420
import math
import numpy as np
import matplotlib.pyplot as plt

#----------material properties----------#
#creep compliance [1/MPa], retardation time [s], reference temperature [K]

#Prony coefficients [1/MPa]
S110 = 3e-4
S11j = [1.7427440e-4, 6.5109057e-6, 6.2842691e-5, 1.0754311e-4, 5.8577103e-5, 1.5508027e-4, 2.8438661e-4, 4.5671545e-4, 6.4613944e-4, 8.6980460e-4, 1.0174406e-3, 1.1201386e-3, 1.0881332e-3, 8.6245215e-4, 1.0593370e-3, 1.1494698e-3, 1.4144114e-3, 9.2623404e-4, 1.3703076e-4]   
S120 = -1.5e-4
S12j = [-6.1737e-6, -2.7396e-5, -5.1691e-5, -5.7504e-5, -9.2453e-6, -1.3158e-4, -1.9545e-4, -2.4264e-4, -3.9097e-4, -5.3432e-4, -6.8591e-4, -6.4146e-4, -5.7814e-4, -6.4545e-4, -6.1626e-4, -6.1421e-4, -1.0500e-3, -5.3076e-4, -6.8429e-5]
S220 = 3e-4
S22j = [1.0998367e-4, 5.8649043e-5, 2.4142765e-5, 4.2217698e-5, 1.5062738e-4, 9.6093116e-5, 2.5979678e-4, 4.4622050e-4, 4.7933786e-4, 5.9115290e-4, 7.5112198e-4, 1.2373818e-3, 1.2622477e-3, 6.4407837e-4, 8.2459510e-4, 9.4358983e-4, 1.7421522e-3, 7.7977930e-4, 9.7438006e-5]
S660 = 0.0015335914
S66j = [1.5048241e-6, 4.8564773e-7, 1.1495912e-4, 3.4537697e-4, 4.4141444e-4, 3.7851546e-4, 1.9050740e-3, 1.2369637e-3, 2.9077949e-3, 1.5893981e-3, 4.3942746e-3, 3.5281134e-3, 1.4208478e-3, 2.0412667e-3, 6.8347953e-3, 2.6735171e-3, 4.6575021e-3, 4.9645784e-3, 4.9958466e-3]

S130 = -1.04992416701508e-07
S13j = [-1.04992416876497e-07, -1.04992418543893e-07, -1.04992405056546e-07, -1.04992410257512e-07, -1.04992475254358e-07, -1.04992503139510e-07, -1.04992350121481e-07, -1.04992079065086e-07, -1.04996777738715e-07, -1.05016197053925e-07, -1.05239584394056e-07, -1.07120633787188e-07, -1.20014285592671e-07, -1.90639666368382e-07, -0.00410830747982386, -0.00384688094820268, -0.00188568078040921, -2.59127621146338e-08, -4.90111734300003e-08]
S230 = -5.25016515641824e-08
S23j = [-5.25016544627866e-08, -5.25016556127258e-08, -5.25016537803372e-08, -5.25016505713051e-08, -5.25016592649298e-08, -5.25016667325532e-08, -5.25022732650757e-08, -5.25018903689055e-08, -5.25031481125555e-08, -5.25160020883262e-08, -5.26353009727579e-08, -5.38029034556093e-08, -6.16794282270492e-08, -1.01792053355245e-07, -0.000383326316527949, -2.32905724902962e-07, -1.32447766137871e-07, -1.26959111979220e-08, -2.36984767790279e-08]

#retardation time [s]
tauj = [1e-9, 1e-8, 1e-7, 1e-6, 1e-5, 1e-4, 1e-3, 1e-2, 1e-1, 1, 1e1, 1e2, 1e3, 1e4, 1e5, 1e6, 1e7, 1e8, 1e9]
#reference temperature [K]
Tref = 20 + 273.16

#distortion strain parameter
kappa = 0.55373785

#----------initialization----------#

#Test 2
#time [s]
t = np.linspace(0,28800,1001)

E1 = [None]*len(t)
E2 = [None]*len(t)
E3 = [None]*len(t)
E6 = [None]*len(t)
Ev = [None]*len(t)
Ed = [None]*len(t)
Deltatr = [None]*len(t)
alphav = [None]*len(t)
a = [None]*len(t)
uf = [None]*len(t)
u = [None]*len(t)
E1j = [[None]*len(tauj) for i in range(len(t))]
E2j = [[None]*len(tauj) for i in range(len(t))]
E3j = [[None]*len(tauj) for i in range(len(t))]
E6j = [[None]*len(tauj) for i in range(len(t))]
SPK1j = [[None]*len(tauj) for i in range(len(t))]
SPK2j = [[None]*len(tauj) for i in range(len(t))]
SPK6j = [[None]*len(tauj) for i in range(len(t))]
ufj = [[None]*len(tauj) for i in range(len(t))]

#Second Piola Kirchoff stress [MPa]
SPK1 = 8.48 * np.ones(len(t)) 
SPK2 = 7.2 * np.ones(len(t)) 
SPK6 = np.zeros(len(t))

#temperature [K]
T = 254.5 * np.ones(len(t))

for h in range(len(t)):
    if t[h] < 3601:
        SPK1[h] = 8.48*(t[h])/3600 
        SPK2[h] = 7.2*(t[h])/3600
        T[h] = 293.16 - (293.16-254.5)*(t[h])/3600

    E1[h] = 0
    E2[h] = 0
    E3[h] = 0
    E6[h] = 0 
    Ev[h] = E1[h] + E2[h] + E3[h] #volumetric
    Ed[h] = math.sqrt(2/3 * ((E1[h] - Ev[h]/3)**2 + (E2[h]-Ev[h]/3)**2 + (E3[h] - Ev[h]/3)**2 + kappa*E6[h]**2)) #distortion strain

#Test 3
# time [s]
# t = [n for n in range(0,420)]

# E1 = [None]*len(t)
# E2 = [None]*len(t)
# E3 = [None]*len(t)
# E6 = [None]*len(t)
# Ev = [None]*len(t)
# Ed = [None]*len(t)
# Deltatr = [None]*len(t)
# alphav = [None]*len(t)
# a = [None]*len(t)
# uf = [None]*len(t)
# u = [None]*len(t)
# E1j = [[None]*len(tauj) for i in range(len(t))]
# E2j = [[None]*len(tauj) for i in range(len(t))]
# E3j = [[None]*len(tauj) for i in range(len(t))]
# E6j = [[None]*len(tauj) for i in range(len(t))]
# SPK1j = [[None]*len(tauj) for i in range(len(t))]
# SPK2j = [[None]*len(tauj) for i in range(len(t))]
# SPK6j = [[None]*len(tauj) for i in range(len(t))]
# ufj = [[None]*len(tauj) for i in range(len(t))]

# SPK1 = 8.48 * np.ones(len(t)) 
# SPK2 = 7.2 * np.ones(len(t)) 
# SPK6 = np.zeros(len(t))

# T = 254.5 * np.ones(len(t))

# for h in range(0, len(t)):
#     if t[h] > 120:
#         break
#     #Second Piola Kirchoff stress [MPa]
#     SPK1[h] = (8.0/120)*t[h]
#     SPK2[h] = (4.0/120)*t[h]
#     SPK6[h] = 0 
#     #Green strain
#     E1[h] = 0
#     E2[h] = 0
#     E3[h] = 0
#     E6[h] = 0 
#     Ev[h] = E1[h] + E2[h] + E3[h] #volumetric
#     Ed[h] = math.sqrt(2/3*((E1[h]-Ev[h]/3)**2+(E2[h]-Ev[h]/3)**2+(E3[h]-Ev[h]/3)**2+kappa*E6[h]**2)) #distortion strain
#     #temperature [K]
#     T[h] = 20 + 273 
#     #linear coefficient of thermal expansion [1/K]
#     a_1_1, a_1_2, a_1_3 = alpha_SF420(T[h])
#     #volumetric coefficient of thermal expansion [1/K]
#     alphav[h] = a_1_1 + a_1_2 + a_1_3

# for h in range(0, len(t)):
#     if t[h] < 120:
#         continue
#     #Second Piola Kirchoff stress [MPa]
#     SPK1[h] = 8.0 
#     SPK2[h] = 4.0 
#     SPK6[h] = 0 
#     #Green strain
#     E1[h] = 0
#     E2[h] = 0
#     E3[h] = 0
#     E6[h] = 0 
#     Ev[h] = E1[h] + E2[h] + E3[h] #volumetric
#     Ed[h] = math.sqrt(2/3*((E1[h]-Ev[h]/3)**2+(E2[h]-Ev[h]/3)**2+(E3[h]-Ev[h]/3)**2+kappa*E6[h]**2)) #distortion strain
#     #temperature [K]
#     T[h] = 20 + 273
#     #linear coefficient of thermal expansion [1/K]
#     a_1_1, a_1_2, a_1_3 = alpha_SF420(T[h])
#     #volumetric coefficient of thermal expansion [1/K]
#     alphav[h] = a_1_1 + a_1_2 + a_1_3

SPK1[0] = 0
SPK2[0] = 0
SPK6[0] = 0

#intermediate variable
q1j = np.zeros(len(tauj))
q2j = np.zeros(len(tauj))
q6j = np.zeros(len(tauj))

#----------strain & free energy density----------#

a[0] = a_SF420(T[0], Tref, Ev[0], Ed[0])

for h in range(1, len(t)):
    #shift factor
    a[h] = a_SF420(T[h], Tref, Ev[h-1], Ed[h-1])
        
    #reduced time increment [s]
    Deltatr[h] = (t[h]-t[h-1])/a[h]
         
    #intermediate variable
    q1j_old = q1j[:]
    q2j_old = q2j[:]
    q6j_old = q6j[:]
    
    for j in range(0, len(tauj)):
        #intermediate variable
        q1j[j] = math.exp(-Deltatr[h]/tauj[j]*q1j_old[j]+(SPK1[h]-SPK1[h-1])*(1-math.exp(-Deltatr[h]/tauj[j]))/(Deltatr[h]/tauj[j]))
        q2j[j] = math.exp(-Deltatr[h]/tauj[j]*q2j_old[j]+(SPK2[h]-SPK2[h-1])*(1-math.exp(-Deltatr[h]/tauj[j]))/(Deltatr[h]/tauj[j]))
        q6j[j] = math.exp(-Deltatr[h]/tauj[j]*q6j_old[j]+(SPK6[h]-SPK6[h-1])*(1-math.exp(-Deltatr[h]/tauj[j]))/(Deltatr[h]/tauj[j]))

        #strain in the jth Kelvin solid element
        E1j[h][j] = S11j[j]*SPK1[h]-S11j[j]*q1j[j]+S12j[j]*SPK2[h]-S12j[j]*q2j[j]
        E2j[h][j] = S12j[j]*SPK1[h]-S12j[j]*q1j[j]+S22j[j]*SPK2[h]-S22j[j]*q2j[j]
        E3j[h][j] = S13j[j]*SPK1[h]-S13j[j]*q1j[j]+S23j[j]*SPK2[h]-S23j[j]*q2j[j]
        E6j[h][j] = S66j[j]*SPK6[h]-S66j[j]*q6j[j]
        
        #spring stress in the jth Kelvin solid element [MPa]
        SPK1j[h][j] = SPK1[h]-q1j[j]
        SPK2j[h][j] = SPK2[h]-q2j[j]
        SPK6j[h][j] = SPK6[h]-q6j[j]
        
        #internal free energy density in the jth spring [MPa]
        ufj[h][j] = (1/2)*SPK1j[h][j]*E1j[h][j]+(1/2)*SPK2j[h][j]*E2j[h][j]+(1/2)*SPK6j[h][j]*E6j[h][j]

    E10 = S110*SPK1[h]+S120*SPK2[h]
    E20 = S120*SPK1[h]+S220*SPK2[h]
    E30 = S130*SPK1[h]+S230*SPK2[h]
    E60 = S660*SPK6[h]
            
    #Green strain
    E1[h] = E10 + sum(list(filter(lambda x: x is not None, E1j[h])))
    E2[h] = E20 + sum(list(filter(lambda x: x is not None, E2j[h])))
    E3[h] = E30 + sum(list(filter(lambda x: x is not None, E3j[h])))
    E6[h] = E60 + sum(list(filter(lambda x: x is not None, E6j[h])))
    Ev[h] = E1[h] + E2[h] + E3[h] #volumetric
    Ed[h] = math.sqrt(2/3*((E1[h]-Ev[h]/3)**2+(E2[h]-Ev[h]/3)**2+(E3[h]-Ev[h]/3)**2+kappa*E6[h]**2)) #distortional
    
    #internal free energy density [MPa]
    uf[h] = (1/2)*SPK1[h]*E10+(1/2)*SPK2[h]*E20+(1/2)*SPK6[h]*E60+sum(list(filter(lambda x: x is not None, ufj[h])))
        
    #internal strain energy density [MPa]
    u[h] = (1/2)*SPK1[h]*E1[h]+(1/2)*SPK2[h]*E2[h]+(1/2)*SPK6[h]*E6[h]

#----------plot results----------#

# FIGURE 1
# plt.plot(t, SPK1, 'g', t, SPK2, 'k', lw=1)
# plt.xlabel("Time [s]")
# plt.ylabel("Stress [MPa]")
# plt.show()

# FIGURE 2
# plt.plot(t, E1, t, E2, 'k', lw=1)
# plt.xlabel("Time [s]")
# plt.ylabel("Strain [#]")
# plt.show()

# FIGURE 3
# plt.plot(t, uf, 'k', lw=1)
# plt.xlabel("Time [s]")
# plt.ylabel('Free Energy Density [MPa]')
# plt.show()

