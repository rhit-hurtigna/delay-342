function cloud_test()
%CLOUD_TEST Tests cloud_main

gbasic = @(x1,x2,~,~,~,~,~) max(0,x1-x2);

gsafe = @(x1,x2,rho1,~,~,~,u) max(0,x1 - (x2 + rho1*u));

% Two processors, connected 1 - 2. Basic problem, this is the first example
% in the paper.
rho = [5;5];
u = [0 1 ; 1 0];
connected = [0 1 ; 1 0];
kappa = [3;3];
V0 = [40;0];
T = 20;
tstep = 5e-3;

cloud_pretty(gbasic,rho,u,connected,kappa,V0,T,tstep);

% Two processors, connected 1 - 2. Delay makes the problem really apparent.
rho = [5;5];
u = [0 8 ; 8 0];
connected = [0 1 ; 1 0];
kappa = [3;3];
V0 = [40;0];
T = 70;
tstep = 5e-3;

cloud_pretty(gbasic,rho,u,connected,kappa,V0,T,tstep);

% Two processors, connected 1 - 2. No delay.
rho = [5;5];
u = [0 0 ; 0 0];
connected = [0 1 ; 1 0];
kappa = [3;3];
V0 = [40;0];
T = 16;
tstep = 5e-3;

cloud_pretty(gbasic,rho,u,connected,kappa,V0,T,tstep);

%% START OF SAFE EXPERIMENTS

% Two processors, connected 1 - 2. Basic problem, this is the first example
% in the paper.
rho = [5;5];
u = [0 1 ; 1 0];
connected = [0 1 ; 1 0];
kappa = [3;3];
V0 = [40;0];
T = 20;
tstep = 5e-3;

cloud_pretty(gsafe,rho,u,connected,kappa,V0,T,tstep);

% Two processors, connected 1 - 2. Delay makes the problem really apparent.
rho = [5;5];
u = [0 8 ; 8 0];
connected = [0 1 ; 1 0];
kappa = [3;3];
V0 = [40;0];
T = 70;
tstep = 5e-3;

cloud_pretty(gsafe,rho,u,connected,kappa,V0,T,tstep);

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
kappa = [3;3];
V0 = [20;0];
T = 180;
tstep = 5e-3;

cloud_pretty(gbasic,rho,u,connected,kappa,V0,T,tstep);

% Two processors, connected 1 - 2. Same as above, but no delay.
rho = [1;1];
u = [0 0 ; 0 0];
connected = [0 1 ; 1 0];
kappa = [3;3];
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

