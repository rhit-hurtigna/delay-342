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
hist_start  = 1940;
hist_end    = hist_start + 10;
fut_end     = hist_end + 10;
hist_range  = [hist_start, hist_end];

% Inequality conditions
A       = -eye(length(x0));
b       = [-0.3; -5];

% Optimizing
optim   = 0;
if (optim)
    x_optim     = fmincon(@(x)func_ex5_resid(x, hist_range), x0, A, b);
    alpha_opt   = x_optim(1);
    tau_opt     = x_optim(2);
else
    alpha_opt   = alpha0;
    tau_opt     = tau0;
end


% Finding Optimized Model
[t_hist, T_hist]    = func_ex3_history_pts(hist_start, hist_end, hist_end);
hist_func   = @(v)CubicSpline(t_hist, T_hist, v);
options = ddeset('RelTol', 1e-6, 'AbsTol', 1e-6);
sol     = dde23(@(t, y, ydel)ddefun_SST3(t, y, ydel, alpha_opt), tau_opt, hist_func, [0, 10], options);
t_optim  = (sol.x)';
T_optim  = (sol.y)';

% Finding history
[t_fut, T_fut]      = func_ex3_history_pts(hist_end, fut_end, hist_end);

% Plotting and Analysis
figure(1);
clf;
plot(t_optim, T_optim, 'b', t_fut, T_fut, 'k+');
xlabel("Time (t) - Yearly Index");
ylabel("Temperature");
legend("Optimized DDE Model", "Measured History");
title("Temperature over " + hist_end + " to " + fut_end);

disp("Optimal residual value found at alpha = " + alpha_opt);
disp("Optimal residual value found at tau = " + tau_opt);
