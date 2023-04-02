function hospital_SIR_test()
%hospital_SIR_test Graphs our hospital model with an example

alpha = 0.002;
fI = @(p) (1e-30)^p;
%fI = @(p) 1;
tI = 3;
kQ = 0.3;
kH = 0.1;
tA = 3;
lambda = 0.1;
B = 0.3;
tQ = 12;
eH = 0.2;
eC = 0.6;
tS = 7*8;

pop_size = 300;
vac_rate = 0;
start_infect = 0.01;
pop_size = pop_size - start_infect;

X0 = [vac_rate*pop_size;(1-vac_rate)*pop_size;start_infect;0;0;0;0;0];
D0 = zeros(6,1);
Dhist = zeros(6,1);

T = 200;
tstep = 0.01;
D0(3,:) = start_infect/tstep;

pop_size = pop_size + start_infect;

[time_domain,X,Saved] = hospital_SIR(alpha,fI,tI,kQ,kH,tA,lambda,B,tQ,eH,eC,tS,X0,D0,Dhist,T,tstep);

plot(time_domain,X(3:8,:));
%legend(["Vaccinated","Susceptible","Asymptomatic","Quarantined","Hospitalized","Critical","Recovered","Dead"]);
legend(["Asymptomatic","Quarantined","Hospitalized","Critical","Recovered","Dead"]);
xlabel("Time (days)");
ylabel("Individuals in state (millions)");

fprintf("cases: %f\n", sum(sum(Saved(4:6,:))));
fprintf("deaths: %f\n", X(8,end));
fprintf("death per case: %f\n", X(8,end)/sum(sum(Saved(4:6,:))));

%% Some vaccination

alpha = 0.002;
fI = @(p) (1e-30)^p;
%fI = @(p) 1;
tI = 3;
kQ = 0.3;
kH = 0.1;
tA = 3;
lambda = 0.1;
B = 0.3;
tQ = 12;
eH = 0.2;
eC = 0.6;
tS = 7*8;

pop_size = 300;
vac_rate = 0.3;
start_infect = 0.01;
pop_size = pop_size - start_infect;

X0 = [vac_rate*pop_size;(1-vac_rate)*pop_size;start_infect;0;0;0;0;0];
D0 = zeros(6,1);
Dhist = zeros(6,1);

T = 200;
tstep = 0.01;
D0(3,:) = start_infect/tstep;

pop_size = pop_size + start_infect;

[time_domain,X,Saved] = hospital_SIR(alpha,fI,tI,kQ,kH,tA,lambda,B,tQ,eH,eC,tS,X0,D0,Dhist,T,tstep);

figure();
plot(time_domain,X(3:8,:));
%legend(["Vaccinated","Susceptible","Asymptomatic","Quarantined","Hospitalized","Critical","Recovered","Dead"]);
legend(["Asymptomatic","Quarantined","Hospitalized","Critical","Recovered","Dead"]);
xlabel("Time (days)");
ylabel("Individuals in state (millions)");

fprintf("cases: %f\n", sum(sum(Saved(4:6,:))));
fprintf("deaths: %f\n", X(8,end));
fprintf("death per case: %f\n", X(8,end)/sum(sum(Saved(4:6,:))));

%% Much vaccination

alpha = 0.002;
fI = @(p) (1e-30)^p;
%fI = @(p) 1;
tI = 3;
kQ = 0.3;
kH = 0.1;
tA = 3;
lambda = 0.1;
B = 0.3;
tQ = 12;
eH = 0.2;
eC = 0.6;
tS = 7*8;

pop_size = 300;
vac_rate = 0.6;
start_infect = 0.01;
pop_size = pop_size - start_infect;

X0 = [vac_rate*pop_size;(1-vac_rate)*pop_size;start_infect;0;0;0;0;0];
D0 = zeros(6,1);
Dhist = zeros(6,1);

T = 200;
tstep = 0.01;
D0(3,:) = start_infect/tstep;

pop_size = pop_size + start_infect;

[time_domain,X,Saved] = hospital_SIR(alpha,fI,tI,kQ,kH,tA,lambda,B,tQ,eH,eC,tS,X0,D0,Dhist,T,tstep);

figure();
plot(time_domain,X(3:8,:));
%legend(["Vaccinated","Susceptible","Asymptomatic","Quarantined","Hospitalized","Critical","Recovered","Dead"]);
legend(["Asymptomatic","Quarantined","Hospitalized","Critical","Recovered","Dead"]);
xlabel("Time (days)");
ylabel("Individuals in state (millions)");

fprintf("cases: %f\n", sum(sum(Saved(4:6,:))));
fprintf("deaths: %f\n", X(8,end));
fprintf("death per case: %f\n", X(8,end)/sum(sum(Saved(4:6,:))));

%% vax plots
vaxstep = 0.01;

    function [cases,deaths] = get_stuff(vac_rate)
        
        alpha = 0.002;
        fI = @(p) (1e-30)^p;
        %fI = @(p) 1;
        tI = 3;
        kQ = 0.3;
        kH = 0.1;
        tA = 3;
        lambda = 0.1;
        B = 0.3;
        tQ = 12;
        eH = 0.2;
        eC = 0.6;
        tS = 7*8;
        
        pop_size = 300;
        start_infect = 0.01;
        pop_size = pop_size - start_infect;
        
        X0 = [vac_rate*pop_size;(1-vac_rate)*pop_size;start_infect;0;0;0;0;0];
        D0 = zeros(6,1);
        Dhist = zeros(6,1);
        
        T = 200;
        tstep = 0.01;
        D0(3,:) = start_infect/tstep;
        
        pop_size = pop_size + start_infect;

        [cases,deaths] = hospital_death_analysis(alpha,fI,tI,kQ,kH,tA,lambda,B,tQ,eH,eC,tS,X0,D0,Dhist,T,tstep);
    end
vdom = 0:vaxstep:1;

[Cases,Deaths] = arrayfun(@(v) get_stuff(v), vdom);

figure();
plot(vdom,Cases);
xlabel("Proportion vaccinated");
ylabel("Total confirmed cases (millions)");

figure();
plot(vdom,Deaths,"Color","#D95319");
xlabel("Proportion vaccinated");
ylabel("Total deaths (millions)");

figure();
plot(vdom,Deaths./Cases,"Color","#EDB120");
xlabel("Proportion vaccinated");
ylabel("Deaths per confirmed case");

end
