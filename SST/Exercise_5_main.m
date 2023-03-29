% Optimizes System of Exercise 5 for optimal tau and alpha values to
% compare the known 10-year history with a projected history.
close;
clear;
clc;

% Initial guesses
alpha0  = 3;
tau0    = 7;
x0      = [alpha0; tau0];

% Finding history                                                                   
curr_yr    = 1950;
fut_end     = curr_yr + 10;

% Optimizing
optim   = 1;
if (optim)
    alpha_rng   = [1; 10];
    tau_rng     = [5; 20];
    [alpha_opt, tau_opt]    = func_grid_ex5(alpha_rng, tau_rng, curr_yr);
else
    alpha_opt   = alpha0;
    tau_opt     = tau0;
end


% Finding Optimized Model
hist_start = curr_yr - tau_opt;
[t_hist, T_hist]    = func_ex3_history_pts(hist_start, curr_yr, curr_yr);
hist_func   = @(v)CubicSpline(t_hist, T_hist, v);
options = ddeset('RelTol', 1e-6, 'AbsTol', 1e-6);
sol     = dde23(@(t, y, ydel)ddefun_SST3(t, y, ydel, alpha_opt), tau_opt, hist_func, [0, 10], options);
t_optim  = (sol.x)';
T_optim  = (sol.y)';

% Finding history
[t_fut, T_fut]      = func_ex3_history_pts(curr_yr, fut_end, curr_yr);

% Plotting and Analysis
figure(1);
clf;
plot(t_optim, T_optim, 'b', t_fut, T_fut, 'k+');
xlabel("Time (t) - Yearly Index");
ylabel("Temperature");
legend("Optimized DDE Model", "Measured History");
title("Temperature over " + curr_yr + " to " + fut_end);

disp("Optimal residual value found at alpha = " + alpha_opt);
disp("Optimal residual value found at tau = " + tau_opt);
