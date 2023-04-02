function R = func_ex5_resid(x, hist_range)
    % Function that computes the difference between the projected
    % historical values and the measured historical values. 
    % INPUTS
    % x -- x = [alpha; tau] values for our model DDE function
    % hist_range -- 2x1 vector representing the time range that you wish to
    %               use as the history. The first value must be greater
    %               than or equal to 1870, and it must be strictly less
    %               than the second value. The second value must be less
    %               than or equal to 2012.
    % OUTPUT
    % R -- The sum of squared error between measured historical values and
    %      projected values from the DDE.
    
    % Taking out t_min and t_curr
    t_min   = hist_range(1);
    t_curr  = hist_range(2);

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
    [t_hist, T_hist]    = func_ex3_history_pts(t_min, t_curr, t_curr);
    [t_fut, T_fut]      = func_ex3_history_pts(t_curr, t_curr+10, t_curr);

    % Variables
    alpha   = x(1);
    tau     = x(2);

    % Solving 
    hist_func   = @(v)CubicSpline(t_hist, T_hist, v);
    t0      = 0;
    tf      = 10;

    options = ddeset('RelTol', 1e-6, 'AbsTol', 1e-6);
    sol     = dde23(@(t, y, ydel)ddefun_SST3(t, y, ydel, alpha), tau, hist_func, [t0  tf], options);
    t_proj  = (sol.x)';
    T_proj  = (sol.y)';

    % Comparing history and projection
    T_fut_new   = CubicSpline(t_fut, T_fut, t_proj);

    % Residual is squared differences
    R       = zeros(4,1);
    R(1)    = sum(abs(T_fut_new - T_proj));    
    R(2)    = sum((T_fut_new-T_proj).^2);
    R(3)    = max(abs(T_fut_new - T_proj));
    t4      = linspace(0, 1, length(T_fut_new))';
    y4      = 0.5-5*atan(10*(t4-0.5))/16;
    R(4)    = sum((T_fut_new-T_proj).*y4);

end