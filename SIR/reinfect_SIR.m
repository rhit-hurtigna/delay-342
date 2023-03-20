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

time_domain = NaN;
S = NaN;
I = NaN;
R = NaN;

end

