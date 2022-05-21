function [err]=BACalibrationObjective(Si3j)

%global variables
global c1 c2 T0 deltad deltav tauj S110 S11j S120 S12j 
global S220 S22j S660 S66j kappa wi timestep
global test_return Formulation

% v spans how many tests to use for calibration. 
for v=1:length(test_return)
    error(v)=wi(v)*BAErrorfuncV200(test_return{v}(1,:),test_return{v}(2,:),test_return{v}(3,:),test_return{v}(4,:),timestep,test_return{v}(5,end),test_return{v}(6,:),Formulation,Si3j);
end

err=sum(error);
end

