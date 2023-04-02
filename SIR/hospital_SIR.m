function [time_domain,X,Saved] = hospital_SIR(alpha,fI,tI,kQ,kH,tA,lambda,B,tQ,eH,eC,tS,X0,D0,Dhist,T,tstep)
%HOSPITAL_SIR Uses a delay differential to model vaccines with limited
%hospital beds
%INPUTS
% see the paper :)
% X0 -- initial vector
% D0 -- initial ''saved'' vector
% T -- max
% tstep -- granularity
%OUTPUTS
% time_domain -- steps of time in [0,T]
% X -- matrix with same shape as time_domain, one for each state

NUM_STATES = 8;
NUM_SAVED = 6;
% delays: I, Q, S, A
% saved(1,x): P(t)
% saved(2,x): Rin(t)
% saved(3,x): Ain(t)
% saved(4,x): Qin(t)
% saved(5,x): Hin(t)
% saved(6,x): Cin(t)
    function [ygrad, saved] = ddefun(y,Z,saved_hist)
        ygrad = zeros(NUM_STATES,1);
        saved = zeros(NUM_SAVED,1);
        ygrad(2) = saved_hist(2,3);
        infected = alpha * fI(saved_hist(1,1)) * y(2) * (y(3) + kQ*(y(4)+y(6)) + kH*y(5));
        ygrad(2) = ygrad(2) - infected; % Sout(t)
        ygrad(3) = infected; % Ain(t)
        saved(3) = infected;
        ygrad(3) = ygrad(3) - saved_hist(3,4); % Aout(t)
        ygrad(4) = (1-lambda)*saved_hist(3,4); % Qin(t)
        saved(4) = ygrad(4);
        ygrad(4) = ygrad(4) - saved_hist(4,2); % Qout(t)
        if y(5) < B
            ygrad(5) = lambda*saved_hist(3,4); % Hin(t)
        else
            ygrad(6) = lambda*saved_hist(3,4); % Cin(t)
        end
        saved(5) = ygrad(5);
        saved(6) = ygrad(6);
        ygrad(5) = ygrad(5) - saved_hist(5,2); % Hout(t)
        ygrad(6) = ygrad(6) - saved_hist(6,2); % Cout(t)
        ygrad(7) = saved_hist(4,2) + (1-eH)*saved_hist(5,2) + (1-eC)*saved_hist(6,2);
        saved(2) = ygrad(7); % Rin(t)
        ygrad(7) = ygrad(7) - saved_hist(2,3); % Rout(t)
        ygrad(8) = eH*saved_hist(5,2) + eC*saved_hist(6,2);
        saved(1) = sum(y(4:6)) / sum(y); % P(t)
    end

delays = [tI;tQ;tS;tA];

[time_domain,X,Saved] = mydde(@(y,Z,saved) ddefun(y,Z,saved),delays,X0,T,tstep,D0,Dhist);

end
