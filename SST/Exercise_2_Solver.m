% Solves the El Niño/La Niña problem in Example 4
function [] = Exercise_2_Solver(alpha, beta, gamma, kappa, tau1, tau2, h_val)

    % Find delays, which are linearly spaced constants. 
    delyf   = max([tau1, tau2]);
    
    dely    = [tau1, tau2];
    tau2_0  = 0;
    
    y_hist_need = linspace(-delyf, 0, 100);
    
    hist    = history_SST(y_hist_need, h_val);

    % Covering case where no delay for tau2
    if (tau2 == 0) 
        dely    = tau1;
        tau2_0  = 1;
    end
    
    % Start and End Points
    t0  = 0;
    tf  = 10;
    
    % Solve DDE using ddensd
    sol = dde23(@(t, y, ydel)ddefun_SST1(t, y, ydel, alpha, beta, gamma, kappa, tau2_0), dely, @(t)history_SST(t, h_val), [t0  tf]);
    
    plotX   = [y_hist_need, sol.x];
    plotY   = [hist, sol.y];
    
    % Plotting
    plot(plotX, plotY);

end
