function R = func_ex5_resid(x, t_min, t_curr)
    
    % Making sure t_min and t_curr are in range
    if (t_min < 1870)
        t_min   = 1870;
        disp("Your minimum year is not within the available range. t_min has been changed to 1870.");
    end
    if (t_curr <= t_min)
        t_curr = t_min + 1;
        disp("Your current year is less than the minimum year. It has been changed to " + t_curr);
    end
    if (t_curr > 2012)
        t_curr = 2012;
        disp("Your current year is too large to have a 10-year projection. It has been changed to 2012");
    end

    % Finding histories
    [t_fut, T_fut]      = func_ex3_history_pts(1948, 2003);
    [t_hist, T_hist]    = func_ex3_history_pts(2003, 2013);
    alpha_7     = 1.2;
    tau_7       = 10;
    hist_func   = @(v)CubicSpline(t_hist, T_hist, v);
    t0      = 0;
    tf      = 30;
    sol = dde23(@(t, y, ydel)ddefun_SST3(t, y, ydel, alpha_7), tau_7, hist_func, [t0  tf]);

end