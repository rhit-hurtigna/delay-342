% Solves the El Niño/La Niña problem in Example 4
function [] = Exercise_2_Solver(alpha, beta, gamma, kappa, tau1, tau2, h_val, hist_mode)

    % Find delays, which are linearly spaced constants. 
    delyf   = max([tau1, tau2]);
    
    dely    = [tau1, tau2];
    tau2_0  = 0;
    
    y_hist_need = linspace(-delyf, 0, 100);
    
    if (hist_mode == 1)
        hist_func   = @(t)history_SST(t, h_val);
    elseif (hist_mode == 2)
        hist_func   = @history_SST_play;
    elseif (hist_mode == 3)
        [t_hist, T_hist]    = func_ex3_history_pts();
        hist_func   = @(v)CubicSpline(t_hist, T_hist, v);
    end

    hist    = hist_func(y_hist_need);
    if (hist_mode == 3)
        hist    = hist';
    end

    % Covering case where no delay for tau2
    if (tau2 == 0) 
        dely    = tau1;
        tau2_0  = 1;
    end
    
    % Start and End Points
    t0  = 0;
    tf  = 10;
    
    % Solve DDE using ddensd
    sol = dde23(@(t, y, ydel)ddefun_SST1(t, y, ydel, alpha, beta, gamma, kappa, tau2_0), dely, hist_func, [t0  tf]);
    
    plotX   = [y_hist_need, sol.x];
    plotY   = [hist, sol.y];
    
    % Plotting
    plot(plotX, plotY);

end
