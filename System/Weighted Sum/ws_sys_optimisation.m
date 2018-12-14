clear all
clc
close all

%% Optimize with a weighted sum
tic
n = 100;     % Number of Pareto points to produce
% wsweights = linspace(0,1,n); % Note that this only results in 2 points...
wsweights = linspace(0.4,1,n);
xws = zeros(n,6); 
fws = zeros(n,3); % 1st col V, 2nd col F, 3rd col weighted obj

A=[];
b=[];
Aeq=[];
beq=[];

%Design Variables
% x=(theta,UTS,mb,l,r,p)

%x0_s1=[0.785398;65000000;2;0.5;0.05];
%x0_s2=[1.5;2.0;700;0.01];
x0=[0.785398;65000000;2.0;0.5;0.01;700]

%lb_s1 = [0.523599;65000000;0.1;0.001;0.001];
%lb_s2=[0;0;690;0];
lb=[0.523599;65000000;0.1;0.001;0.001;690];

%ub_s1 = [1.571;+inf;7.26;5;2.5];
%ub_s2=[1.571;5.0;840;0.2];
ub=[1.571;+inf;7.26;5.0;0.2;840];

options = optimset('Algorithm','sqp');

%x = fmincon('obj',x0,A,b,Aeq,beq,lb,ub,'nonlcon',opts)

for i = 1:n
    w = [wsweights(i), 1-wsweights(i)];
    [xopt,fopt] = fmincon(@(x)func(x,w),x0,A,b,Aeq,beq,lb,ub,@nonlcon,options);
    xws(i,:) = xopt; 
    fws(i,3) = fopt;
    fws(i,1) = subs1(xws(i,:));
    fws(i,2) = subs2(xws(i,:));
end
toc

%% Plot Pareto frontiers
plot(fws(:,1),fws(:,2),'ro')
xlabel('Subsystem1'); ylabel('Subsystem2');

legend('Weighted-sum')