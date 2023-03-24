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
h_val   = [ 1, 0];

for j = 1:2
    % Plotting
    figure(j);
    clf;
    hold on;
    for i = 1:length(alphas)
        Exercise_2_Solver(alphas(i), betas(i), gammas(i), kappas(i), tau1s(i), tau2s(i), h_val(j));
    end
    hold off;
    
    title(" History = " + h_val(j));
    legend("Instance 1", "Instance 2", "Instance 3", "Instance 4", "Instance 5");
end

