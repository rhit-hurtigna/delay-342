function cloud_test()
%CLOUD_TEST Tests cloud_main

gbasic = @(x1,x2,~,~,~) max(0,x1-x2);

% Three processors, connected 1 - 2 - 3.
rho = [1;1;1];
u = [0 3 0 ; 3 0 3 ; 0 3 0];
connected = [0 1 0 ; 1 0 1 ; 0 1 0];
kappa = 2;
V0 = [30;0;0];
T = 50;

N = size(rho,1);
legend_names = strings(2*N+1,1);
for num=1:N
    legend_names(num) = sprintf('queue_%d',num);
end
for num=1:N
    legend_names(num+N) = sprintf('proc_%d',num);
end
legend_names(end) = "packets accounted for";

[time_domain,V] = cloud_main(gbasic,rho,u,connected,kappa,V0,T);

plot(time_domain,V(1:N,:));
hold on;
set(gca,'ColorOrderIndex',1);
plot(time_domain,V(N+1:2*N,:),'LineStyle','--');
plot(time_domain, sum(V),'LineStyle',':');
legend(legend_names);

end

