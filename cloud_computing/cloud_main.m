function [time_domain,V] = cloud_main(g,rho,u,connected,kappa,V0,T,tstep)
%CLOUD_MAIN Runs a cloud computing model
%INPUTS
%g -- packet-sending function
%rho -- column vector of resource pools, N-by-1
%u -- matrix of connection delays, N-by-N. Use anything for no connection,
%probably 0 as it's the most efficient. Symmetric.
%connected -- matrix of connections, N-by-N. 1 if two vertices are
%connected, 0 if not. Symmetric.
%kappa -- vector cost of processing packets
%V0 -- column vector of initial packet counts, N-by-1
%T -- how far to simulate in the future
%tstep -- Forward Euler step size
%OUTPUTS
%time_domain -- M discrete time points in [0,T]
%V -- matrix that's M-by-N representing packet counts over time

% make numbers work out nice for later indexing
tper = ceil(tstep^(-1));
tstep = tper^(-1);
T = ceil(T);

N = size(rho,1);
delays = reshape(u,1,N*N); % matrix to row vector. Reads across the rows
origu = u;
u = u * tper;
u = round(u);
% first, then columns.
delays = [delays, 2*delays]; % now 2*N*N row vector
y0 = [V0;zeros(N,1)];

% History
SendHist = zeros(N,N,T*tper);

    function ygrad = ddefun(t,y,Z)
        t = round(t*tper) + 1;
        if sum(y(N+1:2*N)) >= sum(V0)
            ygrad = zeros(2*N,1);
            return;
        end
        % ignore the processings
        y = y(1:N);
        Z = Z(1:N,:);
        % Z comes in as a N-by-(2*N*N) row vector. We would like to split
        % ALL of those dimensions.
        newZ = reshape(Z,N,N,N,2);
        % First dimension: old Z's row. Z provides snapshots of histories.
        % This dimension decides whose history we are getting.

        % Second dimension: Column of the u matrix
        % Third dimension: Row of the u matrix
        % Note: second and third dimensions can be swapped without any pain
        % because u is symmetric

        % Last dimension: Whether we get one delay or two delays.

        Sending = zeros(N,N); % Sending(i,j)
        % is how many to send from i to j, before scaling.
        for i = 1:N
            for j = 1:N
                if connected(i,j) ~= 1
                    continue;
                end
                % i,j are connected.
                % first param: current i. This is y(i).
                % second param: queue at j, u_{i j} units ago. This is
                % newZ(j,i,j,1).
                % third, fourth params: rho(i), rho(j).
                % fifth param: u(i)(j) = u(j)(i).
                Sending(i,j) = g(y(i),newZ(j,i,j,1),...
                    rho(i),rho(j),kappa(i),kappa(j),origu(i,j));
            end
        end
        S = sum(Sending,2); % S(i) is how many the processor is sending out
        Sending = Sending .* rho ./ (max(rho,S)); % scale to fit pools

        % update history
        SendHist(:,:,t) = Sending;

        ygrad = zeros(2*N,1);
        % calculate ygrad
        for i=1:N
            % calculate ygrad(i)
            received = 0;
            for j=1:N % loop through adjacent processors
                if connected(i,j) ~= 1
                    continue;
                end
                % i,j are connected.
                if t-u(i,j) > 0
                    Sent = SendHist(:,:,t-u(i,j)); % use history
                else
                    Sent = zeros(N,N);
                end
                received = received + Sent(j,i);
            end
            ygrad(i) = received;
            if y(i) > 0
                ygrad(i) = ygrad(i) - min(rho(i),S(i)); % send packets
                packets_processed = (rho(i) - min(rho(i),S(i)))/kappa(i);
                ygrad(i) = ygrad(i) - packets_processed; % use 
                % remaining resources to process
                ygrad(N+i) = packets_processed; % record that
            end
        end
    end

[time_domain, V] = mydde(@(t,y,Z) ddefun(t,y,Z),delays,y0,T,tstep);


end

