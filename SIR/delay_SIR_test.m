function delay_SIR_test()
%delay_SIR_test Graphs our delay SIR model with an example

alpha = .3095;
beta = .2;
rho = 1174.17;
delta = 3.9139e-5;
epsilon = 0.0063;
tau = 10;
u = 0.01;
S0 = 30e6;
I0 = 30;
R0 = 28;
T = 180;

[time_domain_lowvac,S_lowvac,I_lowvac,R_lowvac] = delay_SIR(alpha,beta,rho,delta,epsilon,u,tau,S0,I0,R0,T);

u = 0.02;
[time_domain_highvac,S_highvac,I_highvac,R_highvac] = delay_SIR(alpha,beta,rho,delta,epsilon,u,tau,S0,I0,R0,T);

figure;
hold on;
plot(time_domain_lowvac,S_lowvac,'Color','Green','LineStyle','--');
plot(time_domain_highvac,S_highvac,'Color','Green');
plot(time_domain_lowvac,R_lowvac,'Color','Red','LineStyle','--');
plot(time_domain_highvac,R_highvac,'Color','Red');
ylabel("Population");
xlabel("Time (t)");
legend("Susceptible u=0.01","Susceptible u=0.02","Recovered u=0.01","Recovered u=0.02")

figure;
hold on;
plot(time_domain_lowvac,I_lowvac,'Color','Black','LineStyle','--');
plot(time_domain_highvac,I_highvac,'Color','Black');
ylabel("Population");
xlabel("Time (t)");
legend("Infected u=0.01","Infected u=0.02");

end
