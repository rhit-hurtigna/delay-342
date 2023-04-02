function [cases,deaths] = hospital_death_analysis(alpha,fI,tI,kQ,kH,tA,lambda,B,tQ,eH,eC,tS,X0,D0,Dhist,T,tstep)
%HOSPITAL_DEATH_ANALYSIS Figures out how many people died

[~,X,Saved] = hospital_SIR(alpha,fI,tI,kQ,kH,tA,lambda,B,tQ,eH,eC,tS,X0,D0,Dhist,T,tstep);

cases = sum(sum(Saved(4:6,:)));
deaths = X(8,end);

end

