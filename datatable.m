%% Increasing the number of constraints
ratio_DL=readmatrix("ratio_DL.csv");
ratio_OTL=readmatrix("ratio_OTL.csv");
m=10:10:2000;
figure
plot(m,mean(1-ratio_DL,1))
hold on
fun = @(x,xdata)(x(2)+x(1)*sqrt(log(xdata)));% fit best asymptotic
x0 = [1 1];
x = lsqcurvefit(fun,x0,m,mean(1-ratio_DL,1));
y=fun(x,m);
plot(m,y)
fun = @(x,xdata)(x(2)+x(1)*sqrt(xdata));% fit theorectical asymptotic
x0 = [1 1];
x = lsqcurvefit(fun,x0,m,mean(1-ratio_DL,1));
y=fun(x,m);
plot(m,y)

figure
plot(m,mean(1-ratio_OTL,1))
hold on
fun = @(x,xdata)(x(2)+x(1)*sqrt(log(xdata)));% fit best asymptotic
x0 = [1 1];
x = lsqcurvefit(fun,x0,m,mean(1-ratio_OTL,1));
y=fun(x,m);
plot(m,y)
fun = @(x,xdata)(x(2)+x(1)*xdata.^(1/3));% fit theoretical asymptotic
x0 = [1 1];
x = lsqcurvefit(fun,x0,m,mean(1-ratio_OTL,1));
y=fun(x,m);
plot(m,y)

%% Increasing the number of times
ratio_DL=readmatrix("ratio_DL_3.csv");
ratio_OTL=readmatrix("ratio_OTL_3.csv");
m=10:10:2000;
figure
plot(m,mean(ratio_DL,1))
hold on
fun = @(x,xdata)(x(2)+x(1)*sqrt(log(xdata)));% fit best asymptotic
x0 = [1 1];
x = lsqcurvefit(fun,x0,m,mean(ratio_DL,1));
y=fun(x,m);
plot(m,y)
% figure
plot(m,mean(ratio_OTL,1))
% hold on
fun = @(x,xdata)(x(2)+x(1)*log(xdata).^(1/3));% fit best asymptotic
x0 = [1 1];
x = lsqcurvefit(fun,x0,m,mean(ratio_OTL,1));
y=fun(x,m);
plot(m,y)

%% Increasing the number of times
ratio_DL=readmatrix("ratio_DL_4.csv");
ratio_OTL=readmatrix("ratio_OTL_4.csv");
ratio_AHDL=readmatrix("ratio_AHDL_4.csv");
m=1000:-10:10;
figure
plot(m,mean(ratio_AHDL,1))
hold on

plot(m,mean(ratio_DL,1))

plot(m,mean(ratio_OTL,1))
legend('AHDL','DL','OTL')

figure
histogram(ratio_AHDL(:))
hold on
histogram(ratio_DL(:))
histogram(ratio_OTL(:))
legend('AHDL','DL','OTL')
