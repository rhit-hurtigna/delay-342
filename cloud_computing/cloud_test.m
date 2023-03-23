function cloud_test()
%CLOUD_TEST Tests cloud_main

gbasic = @(x1,x2,~,~,~) max(0,x1-x2);

% Two processors, connected 1 - 2. Processing speed is slow enough to make
% the inefficiency obvious.
rho = [1;1];
u = [0 3 ; 3 0];
connected = [0 1 ; 1 0];
kappa = 50;
V0 = [6;0];
T = 210;
tstep = 5e-3;

cloud_pretty(gbasic,rho,u,connected,kappa,V0,T,tstep);

% Two processors, connected 1 - 2. Really bad efficiency.
rho = [1;1];
u = [0 12 ; 12 0];
connected = [0 1 ; 1 0];
kappa = 3;
V0 = [20;0];
T = 180;
tstep = 5e-3;

cloud_pretty(gbasic,rho,u,connected,kappa,V0,T,tstep);

% Two processors, connected 1 - 2. Same as above, but no delay.
rho = [1;1];
u = [0 0 ; 0 0];
connected = [0 1 ; 1 0];
kappa = 3;
V0 = [20;0];
T = 180;
tstep = 5e-3;

cloud_pretty(gbasic,rho,u,connected,kappa,V0,T,tstep);

% Three processors, connected 1 - 2 - 3.
rho = [1;1;1];
u = [0 3 0 ; 0 1 0 ; 0 3 0];
connected = [0 1 0 ; 1 0 1 ; 0 1 0];
kappa = 2;
V0 = [30;0;0];
T = 45;
tstep = 1e-2;

cloud_pretty(gbasic,rho,u,connected,kappa,V0,T,tstep);

end

