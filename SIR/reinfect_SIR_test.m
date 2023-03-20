function reinfect_SIR_test()
%reinfect_SIR_test Graphs our SIR model with an example

alpha = 0.08;
beta = 0.8;
kappa = 0.3;
S0 = 60;
I0 = 2;
R0 = 38;
T = 10;

[time_domain,S,I,R] = reinfect_SIR(alpha,beta,kappa,S0,I0,R0,T);

plot(time_domain,S,'Color','Green');
hold on;
plot(time_domain,I,'Color','Black');
plot(time_domain,R,'Color','Red');
ylabel("Population");
xlabel("Time (t)");

end
