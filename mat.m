clear variables;

##
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
kappa= 0.55373785

##
#----------initialization----------#

# addpath('C:\Users\Dr.Kwok\OneDrive - University of Central Florida\Research\Resources\Materials\Polymer\Polyethylene\SF420');
# filename='Data-Creep_SF420.xlsx';
# #time [s]
# t=xlsread(filename, 'UniaxialCreep_UCF', 'K11:K347');
# #Second Piola-Kirchhoff stress [MPa]
# SPK1=xlsread(filename, 'UniaxialCreep_UCF', 'M11:M347'); SPK2(1:length(SPK1),1)=0; SPK6(1:length(SPK1),1)=0; 
# for h=1:1:length(t)  
#     #Green strain
#     E1(h,1)=0; E2(h,1)=0; E3(h,1)=0; E6(h,1)=0; 
#     Ev(h,1)=E1(h,1)+E2(h,1)+E3(h,1); #volumetric
#     Ed(h,1)=sqrt(2/3*((E1(h,1)-Ev(h,1)/3)^2+(E2(h,1)-Ev(h,1)/3)^2+(E3(h,1)-Ev(h,1)/3)^2+kappa*E6(h,1)^2)); #distortion strain
#     #temperature [K]
#     T(h,1)=-10 + 273.16;
# end

# #Test 2
# #time [s]
# t=linspace(0,28800,1001)';
# #Second Piola Kirchoff stress [MPa]
# SPK1=8.48*ones(length(t),1); SPK2=7.2*ones(length(t),1); SPK6=zeros(length(t),1);
# #temperature [K]
# T=254.5*ones(length(t),1);
# for h=1:1:length(t)
#     if t(h,1)<3601
#     SPK1(h,1)=8.48*(t(h,1))/3600; SPK2(h,1)=7.2*(t(h,1))/3600;
#     T(h,1)=293.16-(293.16-254.5)*(t(h,1))/3600;
#     end
#     E1(h,1)=0; E2(h,1)=0; E3(h,1)=0; E6(h,1)=0; 
#     Ev(h,1)=E1(h,1)+E2(h,1)+E3(h,1); #volumetric
#     Ed(h,1)=sqrt(2/3*((E1(h,1)-Ev(h,1)/3)^2+(E2(h,1)-Ev(h,1)/3)^2+(E3(h,1)-Ev(h,1)/3)^2+kappa*E6(h,1)^2)); #distortion strain
# end

#Test 3
#time [s]
t=(0:1:420)';
for h=1:1:find(t==120)
    #Second Piola Kirchoff stress [MPa]
    SPK1(h,1)=(8.0/120)*t(h); SPK2(h,1)=(4.0/120)*t(h); SPK6(h,1)=0; 
    #Green strain
    E1(h,1)=0; E2(h,1)=0; E3(h,1)=0; E6(h,1)=0; 
    Ev(h,1)=E1(h,1)+E2(h,1)+E3(h,1); #volumetric
    Ed(h,1)=sqrt(2/3*((E1(h,1)-Ev(h,1)/3)^2+(E2(h,1)-Ev(h,1)/3)^2+(E3(h,1)-Ev(h,1)/3)^2+kappa*E6(h,1)^2)); #distortion strain
    #temperature [K]
    T(h,1)=20+273; 
    #linear coefficient of thermal expansion [1/K]
    alpha(h,:)=alpha_SF420(T(h,1));
    #volumetric coefficient of thermal expansion [1/K]
    alphav(h,1)=alpha(1,1)+alpha(1,2)+alpha(1,3); 
end
for h=find(t==120)+1:1:length(t)
    #Second Piola Kirchoff stress [MPa]
    SPK1(h,1)=8.0; SPK2(h,1)=4.0; SPK6(h,1)=0; 
    #Green strain
    E1(h,1)=0; E2(h,1)=0; E3(h,1)=0; E6(h,1)=0; 
    Ev(h,1)=E1(h,1)+E2(h,1)+E3(h,1); #volumetric
    Ed(h,1)=sqrt(2/3*((E1(h,1)-Ev(h,1)/3)^2+(E2(h,1)-Ev(h,1)/3)^2+(E3(h,1)-Ev(h,1)/3)^2+kappa*E6(h,1)^2)); #distortion strain
    #temperature [K]
    T(h,1)=20+273;
    #linear coefficient of thermal expansion [1/K]
    alpha(h,:)=alpha_SF420(T(h,1));
    #volumetric coefficient of thermal expansion [1/K]
    alphav(h,1)=alpha(1,1)+alpha(1,2)+alpha(1,3); 
end
SPK1(1,1)=0; SPK2(1,1)=0; SPK6(1,1)=0;

#intermediate variable
q1j(1,1:length(tauj))=0; 
q2j(1,1:length(tauj))=0;
q6j(1,1:length(tauj))=0;

##
#----------strain & free energy density----------#
a(1,1)=a_SF420(T(1,1), Tref, Ev(1,1), Ed(1,1));
for h=2:1:length(t)
    
    #shift factor
    a(h,1)=a_SF420(T(h,1), Tref, Ev(h-1,1), Ed(h-1,1));
        
    #reduced time increment [s]
    Deltatr(h,1)=(t(h)-t(h-1))/a(h,1);
         
    #intermediate variable
    q1j_old=q1j;
    q2j_old=q2j;
    q6j_old=q6j;
    
    for j=1:1:length(tauj)
        #intermediate variable
        q1j(1,j)=exp(-Deltatr(h,1)/tauj(1,j))*q1j_old(1,j)+(SPK1(h,1)-SPK1(h-1,1))*(1-exp(-Deltatr(h,1)/tauj(1,j)))/(Deltatr(h,1)/tauj(1,j));
        q2j(1,j)=exp(-Deltatr(h,1)/tauj(1,j))*q2j_old(1,j)+(SPK2(h,1)-SPK2(h-1,1))*(1-exp(-Deltatr(h,1)/tauj(1,j)))/(Deltatr(h,1)/tauj(1,j));
        q6j(1,j)=exp(-Deltatr(h,1)/tauj(1,j))*q6j_old(1,j)+(SPK6(h,1)-SPK6(h-1,1))*(1-exp(-Deltatr(h,1)/tauj(1,j)))/(Deltatr(h,1)/tauj(1,j));
        #strain in the jth Kelvin solid element
        E1j(h,j)=S11j(1,j)*SPK1(h,1)-S11j(1,j)*q1j(1,j)+S12j(1,j)*SPK2(h,1)-S12j(1,j)*q2j(1,j);
        E2j(h,j)=S12j(1,j)*SPK1(h,1)-S12j(1,j)*q1j(1,j)+S22j(1,j)*SPK2(h,1)-S22j(1,j)*q2j(1,j);
        E3j(h,j)=S13j(1,j)*SPK1(h,1)-S13j(1,j)*q1j(1,j)+S23j(1,j)*SPK2(h,1)-S23j(1,j)*q2j(1,j);
        E6j(h,j)=S66j(1,j)*SPK6(h,1)-S66j(1,j)*q6j(1,j);
        #spring stress in the jth Kelvin solid element [MPa]
        SPK1j(h,j)=SPK1(h,1)-q1j(1,j);
        SPK2j(h,j)=SPK2(h,1)-q2j(1,j);
        SPK6j(h,j)=SPK6(h,1)-q6j(1,j);
        #internal free energy density in the jth spring [MPa]
        ufj(h,j)=(1/2)*SPK1j(h,j)*E1j(h,j)+(1/2)*SPK2j(h,j)*E2j(h,j)+(1/2)*SPK6j(h,j)*E6j(h,j);
    end
    E10=S110*SPK1(h,1)+S120*SPK2(h,1);
    E20=S120*SPK1(h,1)+S220*SPK2(h,1);
    E30=S130*SPK1(h,1)+S230*SPK2(h,1);
    E60=S660*SPK6(h,1);
            
    #Green strain
    E1(h,1)=E10+sum(E1j(h,:));
    E2(h,1)=E20+sum(E2j(h,:));
    E3(h,1)=E30+sum(E3j(h,:));
    E6(h,1)=E60+sum(E6j(h,:));
    Ev(h,1)=E1(h,1)+E2(h,1)+E3(h,1); #volumetric
    Ed(h,1)=sqrt(2/3*((E1(h,1)-Ev(h,1)/3)^2+(E2(h,1)-Ev(h,1)/3)^2+(E3(h,1)-Ev(h,1)/3)^2+kappa*E6(h,1)^2)); #distortional
    
    #internal free energy density [MPa]
    uf(h,1)=(1/2)*SPK1(h,1)*E10+(1/2)*SPK2(h,1)*E20+(1/2)*SPK6(h,1)*E60+sum(ufj(h,:));
        
    #internal strain energy density [MPa]
    u(h,1)=(1/2)*SPK1(h,1)*E1(h,1)+(1/2)*SPK2(h,1)*E2(h,1)+(1/2)*SPK6(h,1)*E6(h,1);
        
end

clear h i j
##
#----------plot results----------#
# figure(1)
# plot(t, SPK1, 'g-', t, SPK2, 'k-', 'LineWidth', 2);
# xlabel('Time [s]', 'FontSize', 14);
# ylabel('Stress [MPa]', 'FontSize', 14);
# legend('Stress 1', 'Stress 2');
# set(gca,'FontSize', 12);

figure(2)
plot(t, E1, t, E2, 'k-', 'LineWidth', 2);
xlabel('Time [s]', 'FontSize', 14);
ylabel('Strain [#]', 'FontSize', 14);
#legend('Strain 1', 'Strain 2');
set(gca,'FontSize', 12);

# figure(3)
# plot(t, uf, 'k-', 'LineWidth', 2);
# xlabel('Time [s]', 'FontSize', 14);
# ylabel('Free Energy Density [MPa]', 'FontSize', 14);
# set(gca,'FontSize', 12);
