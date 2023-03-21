% Solves the Circuit problem in Example 4
close;
clear;
clc;

% Find delays
Ny      = 20;
delyf   = -3*pi;
Nyp     = 20;
delypf  = -2*pi;
dely    = linspace(delyf, 0, Ny);
delyp   = linspace(delypf, 0, Nyp);

% Start and End Points
t0  = 0;
tf  = 5;

% Solve DDE using ddensd
sol = ddesnd(@ddefun_circ, dely, delyp, @history_circ, [t0  tf]);

% Plotting
figure(1);
clf;
plot(sol.x, sol.y);
