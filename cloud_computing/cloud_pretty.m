function cloud_pretty(g,rho,u,connected,kappa,V0,T,tstep)
%CLOUD_PRETTY Runs cloud_main and prettily graphs it
%INPUTS
%see inputs of cloud_main

N = size(rho,1);
legend_names = strings(2*N+3,1);
for num=1:N
    legend_names(num) = sprintf('queue_%d',num);
end
for num=1:N
    legend_names(num+N) = sprintf('proc_%d',num);
end
legend_names(end-2) = "packets in transit";
legend_names(end-1) = "packets accounted for";
legend_names(end) = "packets processed";

[time_domain,V] = cloud_main(g,rho,u,connected,kappa,V0,T,tstep);

plot(time_domain,V(1:N,:));
hold on;
set(gca,'ColorOrderIndex',1);
plot(time_domain,V(N+1:2*N,:),'LineStyle','--');
sumV = sum(V);
plot(time_domain, sum(V0)-sumV,'LineStyle',':','Color','Red');
plot(time_domain, sumV,'LineStyle',':','Color','Black');
plot(time_domain, sum(V(N+1:2*N,:)),'LineStyle',':','Color','Magenta');
legend(legend_names);

end

