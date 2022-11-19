n_time=1000;
n_const=10;
B=n_time:-10:10;

% rng(1000)
n_trial=100;
n_exp=length(B);
ratio_OTL=zeros(n_trial,n_exp);
ratio_DL=zeros(n_trial,n_exp);
ratio_AHDL=zeros(n_trial,n_exp);
numIterations = n_exp;
ppm=ParforProgressbar(numIterations,'showWorkerProgress', true);
parfor i=1:n_exp
    for j=1:n_trial
        A=rand(n_const,n_time);
        c=rand(n_time,1);
        b=rand(n_const,1)*B(i);

        
        % one time learning
        ratio_OTL(j,i)=OTL(A,b,c,0.01);
        % dynamic learning
        ratio_DL(j,i)=DL(A,b,c,0.01);
        % action history dependent learning
        ratio_AHDL(j,i)=AHDL(A,b,c);
    
    end
    ppm.increment();
end
delete(ppm);
writematrix(ratio_DL,"ratio_DL_4.csv")
writematrix(ratio_OTL,"ratio_OTL_4.csv")
writematrix(ratio_AHDL,"ratio_AHDL_4.csv")