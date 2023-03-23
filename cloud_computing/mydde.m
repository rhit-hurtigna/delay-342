function [time, Vals] = mydde(ddefun, delays, y0, tmax, tstep)
%MYDDE Forward Euler solver

tper = ceil(tstep^(-1));
tstep = tper^(-1);
delays = delays * tper;
tmax = ceil(tmax);

N = size(y0,1);

time = 0:tper*tmax;
time = time / tper;

Vals = zeros(N,tper*tmax+1);
Vals(:,1) = y0;

for i=1:tper*tmax % use @i to find @i+1
    ygrad = ddefun(time(i),Vals(:,i),Vals(:,max(1,i-delays)));
    Vals(:,i+1) = Vals(:,i) + tstep*ygrad;
end


end

