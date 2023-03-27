function [t_vec_plot, temp_vec_plot] = func_ex3_history_pts()
% Read data
SST_data    = readmatrix("SST_data.csv");

% Constants
curr_yr     = 2013;
min_yr      = 1948;

% Organize Data
t           = SST_data(:,1) - curr_yr;
t_vec       = [ t;          % Jan
                t+1/12;     % Feb
                t+1/6;      % Mar
                t+1/4;      % Apr
                t+1/3;      % May
                t+5/12;     % Jun
                t+1/2;      % Jul
                t+7/12;     % Aug
                t+2/3;      % Sep
                t+3/4;      % Oct
                t+5/6;      % Nov
                t+11/12];   % Dec

temp_vec    = [ SST_data(:,2);      % Jan
                SST_data(:,3);      % Feb
                SST_data(:,4);      % Mar
                SST_data(:,5);      % Apr
                SST_data(:,6);      % May
                SST_data(:,7);      % Jun
                SST_data(:,8);      % Jul
                SST_data(:,9);      % Aug
                SST_data(:,10);     % Sep
                SST_data(:,11);     % Oct
                SST_data(:,12);     % Nov
                SST_data(:,13)];    % Dec

% Editing Range
temp_vec_plot   = temp_vec(t_vec > min_yr - curr_yr);
t_vec_plot      = t_vec(t_vec > min_yr - curr_yr);
temp_vec_plot   = temp_vec_plot(t_vec_plot < 0);
t_vec_plot      = t_vec_plot(t_vec_plot < 0);

% Plotting
% figure(1);
% clf;
% plot(t_vec_plot, temp_vec_plot, "k+");
% xlabel("Time (t) - Yearly Index");
% ylabel("Temperature");
