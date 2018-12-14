close all
clc
clear all

%% Optimisation using GA

tic
%Number of variables
nvars = 4;

%Linear inequality constraints
%g5: Length of arm must be greater than diameter of ball
A=[0 -1 0 2];b=0; 

%Linear equality constraints
Aeq=[];beq=[];

%Boundary conditions (theta,L,p,r)
lb=[0,0,690,0]; ub=[1.571,5.0,840,0.2];

%Call objective function and nonlinear constraints from m files
fun=@obj
cons=@nonlcon

%GA non-gradient-based algorithm
opts =optimoptions(@ga,'Display','iter');
x = ga(@obj,nvars,A,b,Aeq,beq,lb,ub,cons,opts)

disp(['Final Objective:' num2str(fun(x))]) %f(x) whereby x is minimum point
disp(['Minimum point x:' num2str(x)]) %f(x) whereby x is minimum point
disp(['Mass of catapult arm:' num2str(pi*x(2)*x(3)*x(4)^2)])%calculates mass of the arm

%Results shows that inequality and equality constraints are satisfied.
[c,ceq]=nonlcon(x); %whereby c should be <=0 and ceq=0. 

toc
