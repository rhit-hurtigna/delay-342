function yp = ddefun_SST1(t, y, ydel, ypdel)
    % Function that computes y' for partial element circuits, which is
    % based on the current y value, previous values, and the derivative at
    % previous values
    % INPUTS: 
    % t -- current time yp should be evaluated at
    % y -- 3x1 vector that represents y(t) at the current t
    % ydel -- 3xp matrix that represents previous y values at various taus.
    %         p is the number of lagged y values you need
    % ypdel -- 3xq matrix that represents previous y derivatives at various
    %          taus. q is the number of lagged derivatives you need.
    % OUTPUT:
    % yp -- Result of ddefun_circ. Current y derivative at time t.
    
    % Define constant matrices
    % NOT ACCURATE YET!!!
    L   = 100*[ -7  1   2;
                3   -9  0;
                1   2   -6];
    M   = 100*[ 1       0       -3;
                -0.5    -0.5    -1;
                -0.5    -1.5    0];
    N   = 1/72*[    -1  5   2;
                    4   0   3;
                    -2  4   1];
    
    yp  = L*y + sum(M*ydel, 2) + sum(N*ypdel, 2);

end