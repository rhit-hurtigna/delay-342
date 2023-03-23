function [time_domain,S,I,R] = delay_SIR(alpha,beta,rho,delta,epsilon,u,tau,S0,I0,R0,T)
%DELAY_SIR Uses a delay differential to model vaccines
%INPUTS
% alpha -- percentage of interactions between susceptible and infected that
% results in an infection
% beta -- percentage of infected that recovers w.r.t. time
% rho -- birth rate
% delta -- death by natural causes rate
% epsilon -- death by disease rate
% u -- percent of susceptible population that receives a vaccination
% tau -- lag between vaccination and immune time
% S0,I0,R0 -- initial values
% T -- how much time to go through: [0,T]
%OUTPUTS
% time_domain -- steps of time in [0,T]
% S,I,R -- vectors with same shape as time_domain

options = odeset('NormControl','on','MaxStep',1);

    function ygrad = ddefun(y,Z)
        yold = Z(:,1);
        ygrad = zeros(3,1);
        N = sum(y);
        ygrad(1) = rho - alpha*y(1)*y(2)/N - delta*y(1) - u*yold(1);
        ygrad(2) = alpha*y(1)*y(2)/N - (beta+delta+epsilon)*y(2);
        ygrad(3) = beta*y(2) - delta*y(3) + u*yold(1);
    end

tspan = [0 T];
y0 = [S0;I0;R0];
delays = tau;

sol = ddesd(@(~,y,Z) ddefun(y,Z),delays,y0,tspan,options);
time_domain = sol.x;
y = sol.y;

S = y(1,:);
I = y(2,:);
R = y(3,:);

end
