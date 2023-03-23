% Solves the Circuit problem in Example 4
close;
clear;
clc;

% Find delays
Ny      = 2;
delyf   = pi;
Nyp     = 10;
delypf  = 2*pi;
dely    = linspace(0, delyf, Ny+1);
delyp   = linspace(0, delypf, Nyp+1);
dely    = dely(2:end);
delyp   = delyp(2:end);

hist    = history_circ(-dely);

% Start and End Points
t0  = 0;
tf  = 5;

% Solve DDE using ddensd
sol = ddensd(@ddefun_circ, dely, delyp, @history_circ, [t0  tf]);

plotX   = [-dely, sol.x];
plotY   = [hist, sol.y];

% Plotting
figure(1);
clf;
plot(plotX, plotY);
