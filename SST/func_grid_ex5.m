function [alpha_optim, tau_optim] = func_grid_ex5(alpha_rng, tau_rng, curr_yr)
    % Function optimizes the ex5 function based on a grid search.
    % INPUTS
    % alpha_rng -- 2x1 vector representing desired range of alpha values
    %              the function will optimize over. 
    % tau_rng -- 2x1 vector representing desired range of tau values the 
    %            function will optimize over.
    % hist_rng -- 1x2 vector representing the history range
    % OUTPUTS
    % alpha_optim -- alpha value which gave lowest residual
    % tau_optim -- tau value which gave lowest residual
    
    % Split apart inputs
    alpha_min   = alpha_rng(1);
    alpha_max   = alpha_rng(2);
    tau_min     = tau_rng(1);
    tau_max     = tau_rng(2);

    % Define number of points for alpha and tau
    alpha_pts = 25;
    tau_pts = 25;
    num_optim   = 1;

    % Optimize
    while (num_optim > 0)
        R_min   = 10000000000*ones(4,1);
        alpha_optim = zeros(4,1);
        tau_optim = zeros(4,1);
        for alph = linspace(alpha_min, alpha_max, alpha_pts)
            for tau = linspace(tau_min, tau_max, tau_pts)
                x_curr      = [alph; tau];
                hist_rng    = [curr_yr-tau; curr_yr];       
                R_curr  = func_ex5_resid(x_curr, hist_rng);
                alph_curr   = alph*ones(4,1);
                tau_curr    = tau*ones(4,1);
                alpha_optim(R_curr < R_min)     = alph_curr(R_curr < R_min);
                tau_optim(R_curr < R_min)       = tau_curr(R_curr < R_min);
                R_min(R_curr < R_min)           = R_curr(R_curr < R_min);
            end
        end

%         % Setting up for next iteration
%         if (num_optim ~= 1)
%             del_alpha = (alpha_max-alpha_min)/(alpha_pts-1);
%             del_tau = (tau_max-tau_min)/(tau_pts-1);
%             disp("Changing alpha by " + del_alpha);
%             disp("Changing tau by " + del_tau);
%             alpha_max1   = alpha_optim + del_alpha;
%             alpha_min1   = alpha_optim - del_alpha;
%             tau_max1     = tau_optim + del_tau;
%             tau_min1     = tau_optim - del_tau;
% 
%             % Check edge cases
%             if (alpha_max1 > alpha_max)
%                 alpha_min   = alpha_min1 - (alpha_max1 - alpha_max);
%             elseif (alpha_min1 < alpha_min)
%                 alpha_max   = alpha_max1 + (alpha_min - alpha_min1);
%             else
%                 alpha_min   = alpha_min1;
%                 alpha_max   = alpha_max1;
%             end
%             if (tau_max1 > tau_max)
%                 tau_min   = tau_min1 - (tau_max1 - tau_max);
%             elseif (tau_min1 < tau_min)
%                 tau_max   = tau_max1 + (tau_min - tau_min1);
%             else
%                 tau_min   = tau_min1;
%                 tau_max   = tau_max1;
%             end
%         end

        num_optim = num_optim - 1;
    end

end