function[a]=ModelFunctionExtractaT(time,stress1,Temp,inp)
%% Material Parameters
%----------define material parameters----------%

%creep compliance [1/MPa]
if inp==1
[tauj, S110, S11j, S120, S12j, S130, S13j, S220, S22j, S230, S23j, S660, S66j]=FREEs13;
elseif inp==2
[tauj, S110, S11j, S120, S12j, S130, S13j, S220, S22j, S230, S23j, S660, S66j]=S_SF420_FB;
else 
    print('Input not valid')
end
%WLF coefficients
[c1, c2, T0]=c1c2T0_SF420;

%
kappa=0.55373785;

%volumetric strain coefficient
deltav=1;

%distortion strain coefficient
deltad=0.45013846;
%% Initialize Variables
%----------initialize variables----------%

%time step [s]

t=time;

for h=1:1:length(t)     
    %temperature [K]
    T(h,1) = Temp(h);
    %coefficient of thermal expansion [1/K]
    alpha(h,:)=alpha_SF420(T(h,1));
    %Second Piola Kirchoff stress [MPa]
    SPK1(h,1) = stress1(h);         %MD
    SPK2(h,1) = 0;                  %TD
    SPK6(h,1) = 0; %1e4*t(h,1);
    
end
SPK1(1,1) = 0;    

%q
q1(1,1:length(tauj))=0;
q2(1,1:length(tauj))=0;
q6(1,1:length(tauj))=0;

%Green strain
for h=1:1:length(t)  
    E1(h,1)=0;
    E2(h,1)=0;
    E3(h,1)=0;
    E6(h,1)=0;
end

%volumetic strain
epsilonv(1,1)=0;

%distortion strain
epsilond(1,1)=0;
alphav(1)=0;
tr(1)=0;
%% Computation of strains
%----------compute strains----------%
for h=2:1:length(t)

    %volumetric coefficient of thermal expansion [1/K]
    alphav=alpha(h,1)+alpha(h,2)+alpha(h,3);  
    
    %reference fractional free volume
    %f0=f0_SF420(c2, alphav);
    f0=1.691333;

    %shift factor parameter
    %B=B_SF420(c1, f0);
    B=1601.5347;
        
    %shift factor
    a(h,1)=a_SF420(B, f0, alphav, T(h,1), T0, deltav, epsilonv(h-1,1), deltad, epsilond(h-1,1));   
        
    %reduced time increment
    Deltatr(h,1)=(t(h)-t(h-1))/a(h,1);
         
    %update q
    q1old=q1;
    q2old=q2;
    q6old=q6;
    
    %q
    for j=1:1:length(tauj)
        q1(1,j) = exp(-Deltatr(h,1)/tauj(1,j))*q1old(1,j) + (SPK1(h,1)-SPK1(h-1,1))*(1-exp(-Deltatr(h,1)/tauj(1,j)))/(Deltatr(h,1)/tauj(1,j));
        q2(1,j) = exp(-Deltatr(h,1)/tauj(1,j))*q2old(1,j) + (SPK2(h,1)-SPK2(h-1,1))*(1-exp(-Deltatr(h,1)/tauj(1,j)))/(Deltatr(h,1)/tauj(1,j));
        q6(1,j) = exp(-Deltatr(h,1)/tauj(1,j))*q6old(1,j) + (SPK6(h,1)-SPK6(h-1,1))*(1-exp(-Deltatr(h,1)/tauj(1,j)))/(Deltatr(h,1)/tauj(1,j));
    end
        
    %f
    f111=0;
    f122=0; 
    f121=0; 
    f222=0;
    f131=0;    
    f232=0;   
    f666=0;
    for j=1:1:length(tauj)
        f111 = f111 + S11j(1,j)*SPK1(h,1)-S11j(1,j)*q1(1,j);
        f122 = f122 + S12j(1,j)*SPK2(h,1)-S12j(1,j)*q2(1,j);
        f121 = f121 + S12j(1,j)*SPK1(h,1)-S12j(1,j)*q1(1,j);
        f222 = f222 + S22j(1,j)*SPK2(h,1)-S22j(1,j)*q2(1,j);
        f131 = f131 + S13j(1,j)*SPK1(h,1)-S13j(1,j)*q1(1,j);
        f232 = f232 + S23j(1,j)*SPK2(h,1)-S23j(1,j)*q2(1,j);
        f666 = f666 + S66j(1,j)*SPK6(h,1)-S66j(1,j)*q6(1,j);
    end
        
    %Green strain
    E1(h,1) = S110*SPK1(h,1) + f111 + S120*SPK2(h,1) + f122;    
    E2(h,1) = S120*SPK1(h,1) + f121 + S220*SPK2(h,1) + f222;    
    E3(h,1) = S130*SPK1(h,1) + f131 + S230*SPK2(h,1) + f232;
    E6(h,1) = S660*SPK6(h,1) + f666;
    
    %volumetric strain
    epsilonv(h,1)=(E1(h,1)+E2(h,1)+E3(h,1));
    %epsilonv(h,1)=((E1(h,1)*2+1)^(1/2))*((E2(h,1)*2+1)^(1/2))*((E3(h,1)*2+1)^(1/2))-1;
    
    %distortion strain
    epsilond(h,1)=sqrt(2/3*((E1(h,1)-epsilonv(h,1)/3)^2+(E2(h,1)-epsilonv(h,1)/3)^2+(E3(h,1)-epsilonv(h,1)/3)^2+kappa*E6(h,1)^2));
    fvmd(h,1)=epsilonv(h,1)+deltad*epsilond(h,1);   
    tr(h,1)=Deltatr(h,1)+tr(h-1,1);
    CTEv(h,1)=alphav;       
end

clear step 
clear h i j k
end