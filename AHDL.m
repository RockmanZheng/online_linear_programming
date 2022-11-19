function cr = AHDL(A,b,c)
    b_rem=b;% remaining resources
    options=optimoptions('linprog','Display','off');
    [n_const,n_time]=size(A);
    x=linprog(-c,A,b,[],[],zeros(n_time,1),ones(n_time,1),options);% solve offline LP

    x_hat=zeros(n_time,1);
    x_hat(1)= c(1)>0;
    if any(A(:,1)*x_hat(1)>b)
        x_hat(1)=0;
    end

    b_rem=b_rem-A(:,1)*x_hat(1);
    P_hat=linprog([b_rem/(n_time-1);1],-[A(:,1)' 1],-c(1),[],[],zeros(n_const+1,1),[],options);
    p_hat=P_hat(1:n_const);
    for t=2:n_time
        x_hat(t) = c(t)>p_hat'*A(:,t);
        if any(A(:,t)*x_hat(t)>b-A(:,1:t-1)*x_hat(1:t-1))
            x_hat(t)=0;
        end
        b_rem=b_rem-A(:,t)*x_hat(t);
        if t<n_time
            P_hat=linprog([b_rem/(n_time-t);ones(t,1)/t],-[A(:,1:t)' eye(t)],-c(1:t),[],[],zeros(n_const+t,1),[],options);
            p_hat=P_hat(1:n_const);
        end
    end
    cr=(c'*x_hat)/(c'*x);
end

