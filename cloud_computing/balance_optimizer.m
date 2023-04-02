function [B,P] = balance_optimizer(rho,u,connected,kappa,V0,T,tstep, ...
    balmin,balmax,balstep)
%BALANCE_OPTIMIZER Optimizes the balance between oversending and safety
%INPUTS
%see cloud_main inputs
%uses g = gbal
%runs balance param from balmin:balstep:balmax
%OUTPUTS
%vector of balance and performance params


makeg = @(bal) @(x1,x2,rho1,rho2,kappa1,kappa2,u) max(0,kappa1*x1/rho1 - (kappa2*(x2+bal*rho1*u)/rho2));

B=balmin:balstep:balmax;
P = zeros(1,size(B,2));
i = 1;
for bal=B
    [Time,V] = cloud_main(makeg(bal),rho,u,connected,kappa,V0,T,tstep);
    N = size(V,1) / 2;
    X = sum(V(N+1:2*N,:));
    V = sum(V(1:N,1)) - X;
    j = find(V>0,1,"last")+1;
    j = min(j,size(Time,2));
    P(i) = Time(j);
    i = i + 1;
end

end

