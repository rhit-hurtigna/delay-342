function yp = ddefun_SST1(t, y, ydel, alpha, beta, gamma, kappa, tau2_0)
    % Function that computes y' for partial element circuits, which is
    % based on the current y value, previous values, and the derivative at
    % previous values
    % INPUTS: 
    % t -- current time yp should be evaluated at
    % y -- 3x1 vector that represents y(t) at the current t
    % ydel -- 3xp matrix that represents previous y values at various taus.
    %         p is the number of lagged y values you need
    % OUTPUT:
    % yp -- Result of ddefun_circ. Current y derivative at time t.
        
    % Set yd2 based on whether or not tau2 is 0
    if (tau2_0 == 1) 
        yd2     = y;
    else
        yd2     = ydel(2);
    end

    % Find dydt
    yp  = -alpha*tanh(kappa*ydel(1)) + beta*tanh(kappa*yd2) + gamma*cos(2*pi*t);

end