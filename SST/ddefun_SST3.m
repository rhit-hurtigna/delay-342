function yp = ddefun_SST3(t, y, ydel, alpha)
    % Function that computes y' for equation 10.7 in the book, which is
    % based on the current y value and previous y values
    % INPUTS: 
    % t -- current time yp should be evaluated at
    % y -- 3x1 vector that represents y(t) at the current t
    % OUTPUT:
    % yp -- Result of ddefun_circ. Current y derivative at time t.

    % Find dydt
    yp  = -alpha*ydel + y - y.^3;

end