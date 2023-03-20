function [time_domain,S,I,R] = reinfect_SIR(alpha,beta,kappa,S0,I0,R0,T)
%reinfect_SIR Does the SIR model in 10.4 from the
%book
%INPUTS
% alpha -- percentage of interactions between susceptible and infected that
% results in an infection
% beta -- percentage of infected that recovers w.r.t. time
% kappa -- proportion that remain susceptible after recovery
% S0,I0,R0 -- initial values
% T -- how much time to go through: [0,T]
%OUTPUTS
% time_domain -- steps of time in [0,T]
% S,I,R -- vectors with same shape as time_domain

    function ygrad = odefun(~,y)
        ygrad = zeros(3,1);
        ygrad(1) = -alpha*y(1)*y(2) + kappa*beta*y(2);
        ygrad(2) = alpha*y(1)*y(2) - beta*y(2);
        ygrad(3) = (1-kappa)*beta*y(2);
    end

tspan = [0 T];
y0 = [S0;I0;R0];

[time_domain,y] = ode45(@(t,y) odefun(t,y),tspan,y0);

S = y(:,1);
I = y(:,2);
R = y(:,3);

end

