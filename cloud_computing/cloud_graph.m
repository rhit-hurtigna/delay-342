function cloud_graph()
%CLOUD_GRAPH Tests cloud_main on some cool-looking graphss

makeg = @(bal) @(x1,x2,rho1,rho2,kappa1,kappa2,u) max(0,kappa1*x1/rho1 - kappa2*(x2+bal*rho1*u)/rho2);

gbasic = makeg(0);

gsafe = makeg(1);

rng(190);

% Mesh of 10 processors, random stuff.
rho = rand(6,1) * 10 + 10;
u = rand(6,6);
connected = ones(6,6) - eye(6,6);
u = u .* connected;
u = round(u,2);
kappa = rand(6,1) * 80+20;
V0 = zeros(6,1);
V0(1) = 70;
T = 80;
tstep = 1e-2;

cloud_pretty(gbasic,rho,u,connected,kappa,V0,T,tstep);

balmin=0;
balmax=2;
balstep=0.05;

[B,P] = balance_optimizer(rho,u,connected,kappa, ...
    V0,T,tstep,balmin,balmax,balstep);

figure();
plot(B,P);
xlabel("Safety parameter");
ylabel("Makespan (time)");

[~,i] = min(P);
fprintf("%f\n",B(i));
cloud_pretty(makeg(B(i)),rho,u,connected,kappa,V0,T,tstep);

% Two processors, connected 1 - 2. Delay makes the problem really apparent.
rho = [4;4];
u = [0 8 ; 8 0];
connected = [0 1 ; 1 0];
kappa = [4;4];
V0 = [40;0];
T = 105;
tstep = 5e-3;

cloud_pretty(gbasic,rho,u,connected,kappa,V0,T,tstep);

% Two processors, connected 1 - 2. No delay.
rho = [4;4];
u = [0 0 ; 0 0];
connected = [0 1 ; 1 0];
kappa = [4;4];
V0 = [40;0];
T = 30;
tstep = 5e-3;

cloud_pretty(gbasic,rho,u,connected,kappa,V0,T,tstep);

%% START OF SAFE EXPERIMENTS

% Two processors, connected 1 - 2. Basic problem, this is the first example
% in the paper.
rho = [4;4];
u = [0 1 ; 1 0];
connected = [0 1 ; 1 0];
kappa = [4;4];
V0 = [40;0];
T = 30;
tstep = 5e-3;

cloud_pretty(gsafe,rho,u,connected,kappa,V0,T,tstep);

% Two processors, connected 1 - 2. Delay makes the problem really apparent.
rho = [4;4];
u = [0 8 ; 8 0];
connected = [0 1 ; 1 0];
kappa = [4;4];
V0 = [40;0];
T = 105;
tstep = 5e-3;

cloud_pretty(gsafe,rho,u,connected,kappa,V0,T,tstep);

%% BEGIN BALANCE EXPERIMENTS

% Two processors, connected 1 - 2. Basic problem, this is the first example
% in the paper.
rho = [4;4];
u = [0 1 ; 1 0];
connected = [0 1 ; 1 0];
kappa = [4;4];
V0 = [40;0];
T = 30;
tstep = 5e-3;
balmin=0;
balmax=4;
balstep=0.03;

[B,P] = balance_optimizer(rho,u,connected,kappa, ...
    V0,T,tstep,balmin,balmax,balstep);

figure();
plot(B,P);
xlabel("Safety parameter");
ylabel("Makespan (time)");

[~,i] = min(P);

%fprintf("is %f\n", B(i));

cloud_pretty(makeg(B(i)),rho,u,connected,kappa,V0,T,tstep);

% Two processors, connected 1 - 2. Delay makes the problem really apparent.
rho = [4;4];
u = [0 8 ; 8 0];
connected = [0 1 ; 1 0];
kappa = [4;4];
V0 = [40;0];
T = 105;
tstep = 5e-3;
balmin=0;
balmax=1.5;
balstep=0.02;

[B,P] = balance_optimizer(rho,u,connected,kappa, ...
    V0,T,tstep,balmin,balmax,balstep);

figure();
plot(B,P);
xlabel("Safety parameter");
ylabel("Makespan (time)");

[~,i] = min(P);

fprintf("is %f\n", B(i));

cloud_pretty(makeg(B(i)),rho,u,connected,kappa,V0,T,tstep);

return;

% Two processors, connected 1 - 2. Processing speed is slow enough to make
% the inefficiency obvious.
rho = [1;1];
u = [0 3 ; 3 0];
connected = [0 1 ; 1 0];
kappa = [50;50];
V0 = [6;0];
T = 210;
tstep = 5e-3;

cloud_pretty(gbasic,rho,u,connected,kappa,V0,T,tstep);

% Two processors, connected 1 - 2. Really bad efficiency.
rho = [1;1];
u = [0 12 ; 12 0];
connected = [0 1 ; 1 0];
kappa = [4;4];
V0 = [20;0];
T = 180;
tstep = 5e-3;

cloud_pretty(gbasic,rho,u,connected,kappa,V0,T,tstep);

% Two processors, connected 1 - 2. Same as above, but no delay.
rho = [1;1];
u = [0 0 ; 0 0];
connected = [0 1 ; 1 0];
kappa = [4;4];
V0 = [20;0];
T = 180;
tstep = 5e-3;

cloud_pretty(gbasic,rho,u,connected,kappa,V0,T,tstep);

% Three processors, connected 1 - 2 - 3.
rho = [1;1;1];
u = [0 3 0 ; 0 1 0 ; 0 3 0];
connected = [0 1 0 ; 1 0 1 ; 0 1 0];
kappa = [2;2;2];
V0 = [30;0;0];
T = 45;
tstep = 1e-2;

cloud_pretty(gbasic,rho,u,connected,kappa,V0,T,tstep);

end

