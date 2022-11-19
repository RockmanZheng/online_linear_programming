# Online Linear Programming
Online linear programming considers the problem where the objective coefficients 
and the columns of the left hand side matrix are arriving in a sequential manner.
Each time new coefficients come in the operator has to make an irreversible 
decision. This problem has seen applications in online knapsack/secretary problem, 
online adwords problem, and online routing problem.

This repository contains the implementation of three algorithms for online linear
programming, namely one-time learning (OTL), dynamic learning (DL), and 
action-history-dependent learning (AHDL). The OTL and DL algorithms are based on the 
following paper:

Shipra Agrawal, Zizhuo Wang, Yinyu Ye (2014) A Dynamic Near-Optimal Algorithm for Online 
Linear Programming. Operations Research 62(4):876--890.

The AHDL algorithm is based on the following paper:

Xiaocheng Li, Yinyu Ye (2021) Online Linear Programming: Dual Convergence, New Algorithms, 
and Regret Bounds. Operations Research.

All three alogrithms are based on the same principle: learning the dual solution and
then use it to guide the decision making process. 

The OTL is a benchmark algorithm which learns the dual solution once and then keep using it for the following steps. 

The DL algorithm dynamically relearns the dual solution everytime the history doubles. It is 
proven to have near-optimal competitive ratio as the right hand side scales up. 

The AHDL also dynamic relearns the dual solution, but at a higher frequency. It relearns the dual
solution everytime new data comes in. But the most important difference between DL and AHDL
is that AHDL dynamically adjusts the right hand side coefficients. This allows AHDL to 
consume right hand side if it happens that previous actions do not spend too much right 
hand side, and to deter this consumption when it happens that the right hand side has 
already been overconsumed. AHDL is proven to have the smallest regret among the three algorithms
as the time step increases.

In a numerical experiment, we set time step to be 1,000, the number of constraints to be 10, and randomly 
generate the left hand side matrix (10 times 1,000), the right hand side (10 times 1), and the objective
coefficients (1,000 times 1). We set the maximal value of the right hand side to be 10, 20, 30, ..., 1,000,
so the resouces for the decision maker at each time step are increasing in different scenarios. For each
scenario, we run 100 independent experiments. We compute the competitive ratios of the three algorithms for
each experiments. 

For each scenario, we compute the average competitive ratio across 100 experiments for each algorithm, obtaining
the following figure.

![avg_competitive_ratio](https://user-images.githubusercontent.com/20985966/202831990-71d0ab35-c0d8-45f8-a717-75184c633091.jpg)

The x-axis represents the maximal right hand side and the y-axis represents the average competitive ratio.
From this figure, we can easily see that as the right hand side increases (more resources for the decision maker),
the average competitive ratios of all three algorithms increases. In particular, DL achieves relatively good performance while AHDL
improves upon DL by a significant margin.

We also plot histograms of all the competitive ratios across all experiments, resulting in the following figure.

![competitive_ratio](https://user-images.githubusercontent.com/20985966/202832091-9178b641-fe1e-48bc-8d11-d74d771d6a09.jpg)

This figure clearly shows the superiority of AHDL because most of experiments result in close-to-one competitive ratio. DL's performance
is also impressing in terms of concentration and the closeness-to-one of its competitive ratios.
