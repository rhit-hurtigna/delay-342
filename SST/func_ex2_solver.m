% Optimizes System of Exercise 5 for optimal tau and alpha values to
% compare the known 10-year history with a projected history.
close;
clear;
clc;

% Initial guesses
alpha0  = 1.5;
tau0    = 8;

% Finding history                                                                   
curr_yr    = 1990;
fut_end     = curr_yr + 10;

% Optimizing
optim   = 1;
if (optim)
    alpha_rng   = [1.5; 6];
    tau_rng     = [6; 9];
    [alpha_opt, tau_opt]    = func_grid_ex5(alpha_rng, tau_rng, curr_yr);
else
    alpha_opt   = alpha0;
    tau_opt     = tau0;
end
beta = 0;
gamma = 1;
kappa = 100;
tau2_0 = 0;
% 
% Finding Optimized Models
hist_start = curr_yr - max(tau_opt);
[t_hist, T_hist]    = func_ex3_history_pts(hist_start, curr_yr, curr_yr);
hist_func   = @(v)CubicSpline(t_hist, T_hist, v);
options = ddeset('RelTol', 1e-6, 'AbsTol', 1e-6);
sol1     = dde23(@(t, y, ydel)ddefun_SST1(t, y, ydel, alpha_opt(1), beta, gamma, kappa, tau2_0), tau_opt(1), hist_func, [0, 10], options);
sol2     = dde23(@(t, y, ydel)ddefun_SST1(t, y, ydel, alpha_opt(2), beta, gamma, kappa, tau2_0), tau_opt(2), hist_func, [0, 10], options);
sol3     = dde23(@(t, y, ydel)ddefun_SST1(t, y, ydel, alpha_opt(3), beta, gamma, kappa, tau2_0), tau_opt(3), hist_func, [0, 10], options);
sol4     = dde23(@(t, y, ydel)ddefun_SST1(t, y, ydel, alpha_opt(4), beta, gamma, kappa, tau2_0), tau_opt(4), hist_func, [0, 10], options);
% sol5     = dde23(@(t, y, ydel)ddefun_SST1(t, y, ydel, alpha_opt(5)), tau_opt(5), hist_func, [0, 10], options);
t_optim1  = (sol1.x)';
T_optim1  = (sol1.y)';
t_optim2  = (sol2.x)';
T_optim2  = (sol2.y)';
t_optim3  = (sol3.x)';
T_optim3  = (sol3.y)';
t_optim4  = (sol4.x)';
T_optim4  = (sol4.y)';
% t_optim5  = (sol5.x)';
% T_optim5  = (sol5.y)';

% Finding history
[t_fut, T_fut]      = func_ex3_history_pts(curr_yr, fut_end, curr_yr);

% Plotting and Analysis
figure(1);
clf;
plot(t_optim1, T_optim1);
hold on;
plot(t_optim2, T_optim2);
plot(t_optim3, T_optim3);
plot(t_optim4, T_optim4);
% plot(t_optim5, T_optim5);
plot(t_fut, T_fut, 'k+');

xlabel("Time (t) - Yearly Index");
ylabel("Temperature");
if (optim)
    legend("Using 1-norm", "Using 2-norm", "Using inf-norm", "Modified 2-norm", "Measured History");
else
    legend("Alpha = " + alpha_opt(1), "Alpha = " + alpha_opt(2), "Alpha = " + alpha_opt(3), "Alpha = " + alpha_opt(4), "Alpha = " + alpha_opt(5), "Measured History");
end
title("Temperature over " + curr_yr + " to " + fut_end);
% title("Temperature over " + curr_yr + " to " + fut_end + ", tau = " + tau_opt(1));

disp("Optimal residual value found at alpha = " + alpha_opt);
disp("Optimal residual value found at tau = " + tau_opt);
