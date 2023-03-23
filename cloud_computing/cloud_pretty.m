function cloud_pretty(g,rho,u,connected,kappa,V0,T)
%CLOUD_PRETTY Runs cloud_main and prettily graphs it
%INPUTS
%see inputs of cloud_main

N = size(rho,1);
legend_names = strings(2*N+1,1);
for num=1:N
    legend_names(num) = sprintf('queue_%d',num);
end
for num=1:N
    legend_names(num+N) = sprintf('proc_%d',num);
end
legend_names(end) = "packets accounted for";

[time_domain,V] = cloud_main(g,rho,u,connected,kappa,V0,T);

plot(time_domain,V(1:N,:));
hold on;
set(gca,'ColorOrderIndex',1);
plot(time_domain,V(N+1:2*N,:),'LineStyle','--');
plot(time_domain, sum(V),'LineStyle',':','Color','Black');
legend(legend_names);

end

