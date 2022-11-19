function cr= OTL(A,b,c,epsilon)
    options=optimoptions('linprog','Display','off');
    [n_const,n_time]=size(A);
    x=linprog(-c,A,b,[],[],zeros(n_time,1),ones(n_time,1),options);% solve offline LP


    n_learn=round(n_time*epsilon);
    P_hat=linprog([b*epsilon*(1-epsilon);ones(n_learn,1)],-[A(:,1:n_learn)' eye(n_learn)],-c(1:n_learn),[],[],zeros(n_const+n_learn,1),[],options);
    p_hat=P_hat(1:n_const);
    x_hat=zeros(n_time,1);
    for t=n_learn+1:n_time
        x_hat(t)= c(t)>p_hat'*A(:,t);
        if any(A(:,t)*x_hat(t)>b-A(:,1:t-1)*x_hat(1:t-1))
            x_hat(t)=0;
        end
    end
    cr=(c'*x_hat)/(c'*x);
end

