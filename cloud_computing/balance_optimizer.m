function [B,P] = balance_optimizer(rho,u,connected,kappa,V0,T,tstep, ...
    balmin,balmax,balstep)
%BALANCE_OPTIMIZER Optimizes the balance between oversending and safety
%INPUTS
%see cloud_main inputs
%uses g = gbal
%runs balance param from balmin:balstep:balmax
%OUTPUTS
%vector of balance and performance params


makeg = @(bal) @(x1,x2,rho1,rho2,kappa1,kappa2,u) max(0,rho1*x1/kappa1 - (rho2*x2/kappa2 + bal*rho1*u));

B=balmin:balstep:balmax;
P = zeros(1,size(B,2));
i = 1;
for bal=B
    [Time,V] = cloud_main(makeg(bal),rho,u,connected,kappa,V0,T,tstep);
    N = size(V,1) / 2;
    V = sum(V(1:N,:));
    P(i) = Time(find(V>0,1,"last")+1);
    i = i + 1;
end

end

