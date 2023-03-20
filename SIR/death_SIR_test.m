function death_SIR_test()
%death_SIR_test Graphs our death SIR model with an example

alpha = .8;
beta = .1;
rho = .3;
delta = .1;
epsilon = .1;
S0 = 60;
I0 = 2;
R0 = 38;
T = 30;

[time_domain,S,I,R] = death_SIR(alpha,beta,0,0,0,S0,I0,R0,T);

figure;
plot(time_domain,S,'Color','Green');
hold on;
plot(time_domain,I,'Color','Black');
plot(time_domain,R,'Color','Red');
ylabel("Population");
xlabel("Time (t)");
legend("Susceptible","Infected","Recovered")
title("Traditional SIR model");

hold off;

[time_domain,S,I,R] = death_SIR(alpha,beta,rho,delta,epsilon,S0,I0,R0,T);

figure;
plot(time_domain,S,'Color','Green');
hold on;
plot(time_domain,I,'Color','Black');
plot(time_domain,R,'Color','Red');
ylabel("Population");
xlabel("Time (t)");
legend("Susceptible","Infected","Recovered")
title("Death SIR model");


end
