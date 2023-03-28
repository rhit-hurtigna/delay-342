close;
clear;
clc;

figure(1);
clf;
hold on;

% Defining Variables
alphas  = [ 1, 1, 1, 1, 1.2];
betas   = [ 0, 0, 0, 1, 0.8];
gammas  = [ 1, 1, 1, 1, 1];
kappas  = [ 100, 100, 100, 10, 10];
tau1s   = [ 0.01, 0.15, 0.995, 0.9, 0.6];
tau2s   = [ 0, 0, 0, 0.1, 0.6];
h_val   = [ 1, 0, 0, 0];
hist_modes  = [ 1, 1, 2, 3];
titles  = ["History = 1", "History = 0", "Sinusoidal History", "Spline History"];

for j = 1:4
    % Plotting
    figure(j);
    clf;
    hold on;
    for i = 1:length(alphas)
        Exercise_2_Solver(alphas(i), betas(i), gammas(i), kappas(i), tau1s(i), tau2s(i), h_val(j), hist_modes(j));
    end
    hold off;
    
    title(titles(j));
    legend("Instance 1", "Instance 2", "Instance 3", "Instance 4", "Instance 5", 'location', 'southwest');
end

%% Recreating fig 10.7
[t_black, T_black]  = func_ex3_history_pts(1948, 2003);
[t_red, T_red]      = func_ex3_history_pts(2003, 2013);
alpha_7     = 1.2;
tau_7       = 10;
hist_func   = @(v)CubicSpline(t_red, T_red, v);
t0      = 0;
tf      = 30;
sol = dde23(@(t, y, ydel)ddefun_SST3(t, y, ydel, alpha_7), tau_7, hist_func, [t0  tf]);

figure(7);
clf;
plot(sol.x, sol.y, "b");
hold on;
plot(t_red, T_red, "r+");
plot(t_black, T_black, "k+");
xlabel("Time (t) - Yearly Index");
ylabel("Temperature");

%% Testing func_ex5_resid function
alpha0  = 1.2;
tau0    = 10;
x0      = [alpha0; tau0];
hist_range  = [1940, 1950];
resid   = func_ex5_resid([alpha0; tau0], hist_range);
A       = -eye(length(x0));
b       = x0*0;
[t_optim, T_optim]  = fmincon(@(x)func_ex5_resid(x, hist_range), x0, A, b);


