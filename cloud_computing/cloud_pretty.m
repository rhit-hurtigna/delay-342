function cloud_pretty(g,rho,u,connected,kappa,V0,T,tstep)
%CLOUD_PRETTY Runs cloud_main and prettily graphs it
%INPUTS
%see inputs of cloud_main

N = size(rho,1);
legend_names = strings(2*N+2,1);
for num=1:N
    legend_names(num) = sprintf('queue_%d',num);
end
for num=1:N
    legend_names(num+N) = sprintf('proc_%d',num);
end
legend_names(end-1) = "packets in transit";
legend_names(end) = "packets processed";

[time_domain,V] = cloud_main(g,rho,u,connected,kappa,V0,T,tstep);

figure();
hold on;
plot(time_domain,V(1:N,:));
set(gca,'ColorOrderIndex',1);
plot(time_domain,V(N+1:2*N,:),'LineStyle','--');
sumV = sum(V);
plot(time_domain, sum(V0)-sumV,'LineStyle',':','Color','Black', ...
    'LineWidth',1.5);
plot(time_domain, sum(V(N+1:2*N,:)),'LineStyle',':','Color','Magenta', ...
    'LineWidth',1.5);
legend(legend_names,'Location','north');
xlim([0 T]);
hold off;

%fprintf("is %f\n", time_domain(find(sum(V0) - sum(V(N+1:2*N,:)) <= 0,1)));

end

