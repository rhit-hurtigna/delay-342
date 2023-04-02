% Solves the Circuit problem in Example 4
close;
clear;
clc;

% Find delays, which are linearly spaced constants. 
delay   = 18;
Ny      = 1;
delyf   = delay;
Nyp     = 1;
delypf  = delay;
dely    = linspace(0, delyf, Ny+1);
delyp   = linspace(0, delypf, Nyp+1);

dely    = dely(2:end);
delyp   = delyp(2:end);

y_hist_need = linspace(-delyf, 0, 100);

hist    = history_circ(y_hist_need);

% Start and End Points
t0  = 0;
tf  = 36;

% Solve DDE using ddensd
sol = ddensd(@ddefun_circ, dely, delyp, @history_circ, [t0  tf]);

plotX   = [y_hist_need, sol.x];
plotY   = [hist, sol.y];

% Plotting
figure(1);
clf;
plot(plotX, plotY);
xlabel("Time t");
ylabel("y(t)");
legend("y_1(t)", "y_2(t)", "y_3(t)");
% title("Tau = " + delay);
