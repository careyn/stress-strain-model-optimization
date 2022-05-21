function dydt = KelvinVoigt(t,y,at,a,sigmat,sigma,Di,taui)
a = interp1(at,a,t); % Interpolate the data set (ft,f) at time t
sigma = interp1(sigmat,sigma,t); % Interpolate the data set (gt,g) at time t
dydt = -y./(a.*taui) + Di.*sigma./(a.*taui); % Evaluate ODE at time t
end
