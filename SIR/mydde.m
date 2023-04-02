function [time, Vals, Saved] = mydde(ddefun, delays, y0, tmax, tstep, d0, dhist)
%MYDDE Forward Euler solver with added funkiness

tper = ceil(tstep^(-1));
tstep = tper^(-1);
delays = delays * tper;
tmax = ceil(tmax);

N = size(y0,1);

time = 0:tper*tmax;
time = time / tper;

Vals = zeros(N,tper*tmax+1);
Vals(:,1) = y0;

Saved = zeros(size(d0,1),tper*tmax+1);
Saved(:,1) = d0;

for i=1:tper*tmax % use @i to find @i+1
    saved_hist = zeros(6,4);
    for del=1:4
        if i-delays(del) == 1
            saved_hist(:,del) = d0;
        elseif i-delays(del) < 1
            saved_hist(:,del) = dhist;
        else
            saved_hist(:,del) = Saved(:,i-delays(del));
        end
    end
    fixedDelays = max(1,i-delays);
    [ygrad, saved] = ddefun(Vals(:,i), ...
        Vals(:,fixedDelays),saved_hist);
    Vals(:,i+1) = Vals(:,i) + tstep*ygrad;
    Saved(:,i+1) = saved;
end

Saved = Saved * tstep;

end

