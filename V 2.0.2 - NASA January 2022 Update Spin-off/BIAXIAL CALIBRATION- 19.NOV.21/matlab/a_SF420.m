function [a]=a_SF420(B, f0, alphav, T, T0, deltav, epsilonv, deltad, epsilond)
    %shift factor
    a=10^((-B/(2.303*f0))*(alphav*(T-T0)+deltav*epsilonv+deltad*epsilond)/(f0+alphav*(T-T0)+deltav*epsilonv+deltad*epsilond));
end