clear all
clc
% close all
cd

listing=dir('**/*.csv')
listing1=dir('**/*.xlsx')
listing=[listing;listing1]
k=0;
timestep=10;
%% READ TEST DATA & ASSIGN NAMES
for i=1:length(listing)
    if contains(listing(i).name,'_5MPa_')
        if contains(listing(i).name,'_RT_') || contains(listing(i).name,'_22C_')
            test_return{i}=PlotData(listing(i).name,22,i)
        elseif contains(listing(i).name,'_10C_')
            test_return{i}=PlotData(listing(i).name,10,i)
        elseif contains(listing(i).name,'_m10C_')
            test_return{i}=PlotData(listing(i).name,-10,i)
        elseif contains(listing(i).name,'_m30C_')
            test_return{i}=PlotData(listing(i).name,-30,i)
        end    
    elseif contains(listing(i).name,'_5p5MPa_')
        if contains(listing(i).name,'_RT_') || contains(listing(i).name,'_22C_')
            test_return{i}=PlotData(listing(i).name,22,i)
        elseif contains(listing(i).name,'_10C_')
            test_return{i}=PlotData(listing(i).name,10,i)
        elseif contains(listing(i).name,'_m10C_')
            test_return{i}=PlotData(listing(i).name,-10,i)
        elseif contains(listing(i).name,'_m30C_')
            test_return{i}=PlotData(listing(i).name,-30,i)
        end
    elseif contains(listing(i).name,'_6MPa_')
        if contains(listing(i).name,'_RT_') || contains(listing(i).name,'_22C_')
           test_return{i}=PlotData(listing(i).name,22,i)
        elseif contains(listing(i).name,'_10C_')
            test_return{i}=PlotData(listing(i).name,10,i)
        elseif contains(listing(i).name,'_m10C_')
            test_return{i}=PlotData(listing(i).name,-10,i)
        elseif contains(listing(i).name,'_m30C_')
           test_return{i}=PlotData(listing(i).name,-30,i)
        end
    elseif contains(listing(i).name,'_6p5MPa_')
        if contains(listing(i).name,'_RT_') || contains(listing(i).name,'_22C_')
           test_return{i}=PlotData(listing(i).name,22,i)
        elseif contains(listing(i).name,'_10C_')
           test_return{i}=PlotData(listing(i).name,10,i)    
        elseif contains(listing(i).name,'_m10C_')
            test_return{i}=PlotData(listing(i).name,-10,i)
        elseif contains(listing(i).name,'_m30C_')
            test_return{i}=PlotData(listing(i).name,-30,i)
        end
    
    elseif contains(listing(i).name,'_7MPa_')
        if contains(listing(i).name,'_RT_') || contains(listing(i).name,'_22C_')
            test_return{i}=PlotData(listing(i).name,22,i)
        elseif contains(listing(i).name,'_10C_')
           test_return{i}=PlotData(listing(i).name,10,i)
        elseif contains(listing(i).name,'_m10C_')
           test_return{i}=PlotData(listing(i).name,-10,i)
        elseif contains(listing(i).name,'_m30C_')
            test_return{i}=PlotData(listing(i).name,-30,i)
        end
        
    elseif contains(listing(i).name,'_7p5MPa_')
        if contains(listing(i).name,'_RT_') || contains(listing(i).name,'_22C_')
            test_return{i}=PlotData(listing(i).name,22,i)
        elseif contains(listing(i).name,'_10C_')
           test_return{i}=PlotData(listing(i).name,10,i)
        elseif contains(listing(i).name,'_m10C_')
           test_return{i}=PlotData(listing(i).name,-10,i)
        elseif contains(listing(i).name,'_m30C_')
            test_return{i}=PlotData(listing(i).name,-30,i)
        end
    elseif contains(listing(i).name,'_8MPa_')
        if contains(listing(i).name,'_RT_') || contains(listing(i).name,'_22C_')
            test_return{i}=PlotData(listing(i).name,22,i)
        elseif contains(listing(i).name,'_10C_')
           test_return{i}=PlotData(listing(i).name,10,i)
        elseif contains(listing(i).name,'_m10C_')
           test_return{i}=PlotData(listing(i).name,-10,i)
        elseif contains(listing(i).name,'_m30C_')
            test_return{i}=PlotData(listing(i).name,-30,i)
        end
    elseif contains(listing(i).name,'_8p5MPa_')
        if contains(listing(i).name,'_RT_') || contains(listing(i).name,'_22C_')
            test_return{i}=PlotData(listing(i).name,22,i)
        elseif contains(listing(i).name,'_10C_')
           test_return{i}=PlotData(listing(i).name,10,i)
        elseif contains(listing(i).name,'_m10C_')
           test_return{i}=PlotData(listing(i).name,-10,i)
        elseif contains(listing(i).name,'_m30C_')
            test_return{i}=PlotData(listing(i).name,-30,i)
        end
     elseif contains(listing(i).name,'_9MPa_')
        if contains(listing(i).name,'_RT_') || contains(listing(i).name,'_22C_')
            test_return{i}=PlotData(listing(i).name,22,i)
        elseif contains(listing(i).name,'_10C_')
            test_return{i}=PlotData(listing(i).name,10,i)
        elseif contains(listing(i).name,'_m10C_')
            test_return{i}=PlotData(listing(i).name,-10,i)
        elseif contains(listing(i).name,'_m30C_')
            test_return{i}=PlotData(listing(i).name,-30,i)
        end
     elseif contains(listing(i).name,'_9p5MPa_')
        if contains(listing(i).name,'_RT_') || contains(listing(i).name,'_22C_')
            test_return{i}=PlotData(listing(i).name,22,i)
        elseif contains(listing(i).name,'_10C_')
            test_return{i}=PlotData(listing(i).name,10,i)
        elseif contains(listing(i).name,'_m10C_')
            test_return{i}=PlotData(listing(i).name,-10,i)
        elseif contains(listing(i).name,'_m20C_')
            test_return{i}=PlotData(listing(i).name,-20,i)
        elseif contains(listing(i).name,'_m30C_')
            test_return{i}=PlotData(listing(i).name,-30,i)
        end
     elseif contains(listing(i).name,'_10MPa_')
        if contains(listing(i).name,'_RT_') || contains(listing(i).name,'_22C_')
            test_return{i}=PlotData(listing(i).name,22,i)
        elseif contains(listing(i).name,'_10C_')
            test_return{i}=PlotData(listing(i).name,10,i)
        elseif contains(listing(i).name,'_m10C_')
            test_return{i}=PlotData(listing(i).name,-10,i)
        elseif contains(listing(i).name,'_m20C_')
            test_return{i}=PlotData(listing(i).name,-20,i)
        elseif contains(listing(i).name,'_m30C_')
            test_return{i}=PlotData(listing(i).name,-30,i)
        end
      elseif contains(listing(i).name,'_10p5MPa_')
         if contains(listing(i).name,'_RT_') || contains(listing(i).name,'_22C_')
            test_return{i}=PlotData(listing(i).name,22,i)
        elseif contains(listing(i).name,'_10C_')
            test_return{i}=PlotData(listing(i).name,10,i)
        elseif contains(listing(i).name,'_m10C_')
            test_return{i}=PlotData(listing(i).name,-10,i)
        elseif contains(listing(i).name,'_m20C_')
            test_return{i}=PlotData(listing(i).name,-20,i)
        elseif contains(listing(i).name,'_m30C_')
            test_return{i}=PlotData(listing(i).name,-30,i)
         end
        elseif contains(listing(i).name,'_11MPa_')
        if contains(listing(i).name,'_RT_') || contains(listing(i).name,'_22C_')
            test_return{i}=PlotData(listing(i).name,22,i)
        elseif contains(listing(i).name,'_10C_')
            test_return{i}=PlotData(listing(i).name,10,i)
        elseif contains(listing(i).name,'_m10C_')
            test_return{i}=PlotData(listing(i).name,-10,i)
        elseif contains(listing(i).name,'_m20C_')
            test_return{i}=PlotData(listing(i).name,-20,i)
        elseif contains(listing(i).name,'_m30C_')
            test_return{i}=PlotData(listing(i).name,-30,i)
        end
           elseif contains(listing(i).name,'_11p5MPa_')
        if contains(listing(i).name,'_RT_') || contains(listing(i).name,'_22C_')
            test_return{i}=PlotData(listing(i).name,22,i)
        elseif contains(listing(i).name,'_10C_')
            test_return{i}=PlotData(listing(i).name,10,i)
        elseif contains(listing(i).name,'_m10C_')
            test_return{i}=PlotData(listing(i).name,-10,i)
        elseif contains(listing(i).name,'_m20C_')
            test_return{i}=PlotData(listing(i).name,-20,i)
        elseif contains(listing(i).name,'_m30C_')
            test_return{i}=PlotData(listing(i).name,-30,i)
        end
     elseif contains(listing(i).name,'_12MPa_')
        if contains(listing(i).name,'_RT_') || contains(listing(i).name,'_22C_')
            test_return{i}=PlotData(listing(i).name,22,i)
        elseif contains(listing(i).name,'_10C_')
            test_return{i}=PlotData(listing(i).name,10,i)
        elseif contains(listing(i).name,'_m10C_')
            test_return{i}=PlotData(listing(i).name,-10,i)
        elseif contains(listing(i).name,'_m20C_')
            test_return{i}=PlotData(listing(i).name,-20,i)
        elseif contains(listing(i).name,'_m30C_')
            test_return{i}=PlotData(listing(i).name,-30,i)
        end   
    end
end
%%
for v=1:length(listing)
[aT]=ModelFunctionExtractaT(test_return{v}(3,:),test_return{v}(1,:),test_return{v}(4,:),1);


[tauj, S110, D11j, S120, S12j, S130, S13j, S220, S22j, S230, S23j, S660, S66j]=FREEs13;
taui=tauj;
Di=D11j;
Di(end)=[];



%Time-span, Initial condition and solver options
ic = [0,0];
opts = odeset('RelTol',1e-4,'AbsTol',1e-4);

%Solve ODE
%take in shift factors, stress history and material parameters
time=test_return{v}(3,:)' 
stress=test_return{v}(1,:)'

time(1)=[]
stress(1)=[]
aT(1)=[]
for i=1:length(Di)
[t,epsdummy] = ode15s(@(t,y) KelvinVoigt(t,y,time,aT,time,stress,Di(i),taui(i)), time, ic, opts);
eps(i,:)=epsdummy(:,1)';
end

%Calculate free energy from strain history and material parameters - single
%branches
for i=1:length(Di)
U(i,:)=0.5.*eps(i,:).^2./Di(i);
end

%equilibrium branch energy
for i=1:length(time)
Ue(i)=stress(i)^2*0.5*S110;
end


Utot=sum(U)+Ue;

figure (2)
plot(t/60,Utot,'linewidth',2)
hold on
ylabel('Free Energy, mJ/mm^3')
xlabel('Time, min')
clear Utot Ue aT eps epsdummy stress time Di U
end
