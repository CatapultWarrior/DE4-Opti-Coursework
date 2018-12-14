close all
clc
clear all

%% Optimisation using Interior Point

tic
%Linear Inequality constraints
%g5 %Length of arm must be greater than diameter of ball
A=[0 -1 0 2];b=[0]; 

%Linear Equality constraints
Aeq=[];beq=[];

%Boundary conditions (theta,L,p,r)
lb=[0,0,690,0];ub=[1.571,5.0,840,0.2];

%Intial point guessed
x0=[1,2.0,700,0.02];

%Interior Point using fmincon
opts = optimset('Display','iter','MaxFunEvals',5000);
x = fmincon('obj',x0,A,b,Aeq,beq,lb,ub,'nonlcon',opts)


disp(['Initial Objective:' num2str(obj(x0))]) %f(x0)whereby x0 is guessed point
disp(['Final Objective:' num2str(obj(x))]) %f(x) whereby x is minimum point
disp(['Mass of catapult arm:' num2str(pi*x(2)*x(3)*x(4)^2)]) %calculates mass of the arm

[c,ceq]=nonlcon(x); %whereby c should be <=0 and ceq=0. 


toc
