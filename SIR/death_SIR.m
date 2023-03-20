function [time_domain,S,I,R] = death_SIR(alpha,beta,rho,delta,epsilon,S0,I0,R0,T)
%death_SIR Does the SIR model with birth and death
%INPUTS
% alpha -- percentage of interactions between susceptible and infected that
% results in an infection
% beta -- percentage of infected that recovers w.r.t. time
% rho -- birth rate
% delta -- death by natural causes rate
% epsilon -- death by disease rate
% S0,I0,R0 -- initial values
% T -- how much time to go through: [0,T]
%OUTPUTS
% time_domain -- steps of time in [0,T]
% S,I,R -- vectors with same shape as time_domain

    function ygrad = odefun(~,y)
        ygrad = zeros(3,1);
        N = sum(y);
        ygrad(1) = rho - alpha*y(1)*y(2)/N + delta*y(1);
        ygrad(2) = alpha*y(1)*y(2)/N - (beta+delta+epsilon)*y(2);
        ygrad(3) = beta*y(2) - delta*y(3);
    end

tspan = [0 T];
y0 = [S0;I0;R0];

[time_domain,y] = ode45(@(t,y) odefun(t,y),tspan,y0);

S = y(:,1);
I = y(:,2);
R = y(:,3);

end

