function cloud_graph()
%CLOUD_GRAPH Tests cloud_main on some cool-looking graphss

makeg = @(bal) @(x1,x2,rho1,rho2,kappa1,kappa2,u) max(0,kappa1*x1/rho1 - kappa2*(x2+bal*rho1*u)/rho2);

gbasic = makeg(0);

gsafe = makeg(1);

rng(190);

% % Mesh of 10 processors, random stuff.
% rho = rand(6,1) * 10 + 10;
% u = rand(6,6);
% connected = ones(6,6) - eye(6,6);
% u = u .* connected;
% u = round(u,2);
% kappa = rand(6,1) * 80+20;
% V0 = zeros(6,1);
% V0(1) = 70;
% T = 80;
% tstep = 1e-2;
%
% cloud_pretty(gbasic,rho,u,connected,kappa,V0,T,tstep);
%
% balmin=0;
% balmax=2;
% balstep=0.05;
%
% [B,P] = balance_optimizer(rho,u,connected,kappa, ...
%     V0,T,tstep,balmin,balmax,balstep);
%
% figure();
% plot(B,P);
% xlabel("Safety parameter");
% ylabel("Makespan (time)");
%
% [~,i] = min(P);
% fprintf("%f\n",B(i));
% cloud_pretty(makeg(B(i)),rho,u,connected,kappa,V0,T,tstep);


% % Ring of 6 processors, random stuff.
% rng(200);
% rho = rand(6,1) * 10 + 10;
% u = rand(6,6);
% connected = [0 1 0 0 0 1;
%     1 0 1 0 0 0;
%     0 1 0 1 0 0;
%     0 0 1 0 1 0;
%     0 0 0 1 0 1;
%     1 0 0 0 1 0];
% u = u .* connected;
% u = round(u,2);
% kappa = rand(6,1) * 80+20;
% V0 = zeros(6,1);
% V0(1) = 70;
% T = 80;
% tstep = 1e-2;
%
% cloud_pretty(gbasic,rho,u,connected,kappa,V0,T,tstep);
%
% balmin=0;
% balmax=2;
% balstep=0.05;
%
% [B,P] = balance_optimizer(rho,u,connected,kappa, ...
%     V0,T,tstep,balmin,balmax,balstep);
%
% figure();
% plot(B,P);
% xlabel("Safety parameter");
% ylabel("Makespan (time)");
%
% [~,i] = min(P);
% fprintf("%f\n",B(i));
% cloud_pretty(makeg(B(i)),rho,u,connected,kappa,V0,T,tstep);

% Star of 6 processors, random stuff.
rng(280);
rho = rand(6,1) * 10 + 10;
u = rand(6,6);
connected = [0 0 0 0 0 1;
    0 0 0 0 0 1;
    0 0 0 0 0 1;
    0 0 0 0 0 1;
    0 0 0 0 0 1;
    1 1 1 1 1 0];
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

end