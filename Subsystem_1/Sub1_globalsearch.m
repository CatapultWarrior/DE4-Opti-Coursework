close all
clear
clc

x0 = [0.523599000003201,74574901.0582191,-41768.7659864410,597782.019937100,0.100000000000320,4.99999785921034,0.304332770928943,3851730.75390105,83004.0187311769,83004.0182691358];
lb = [0.523599,   65000000,   -inf,      0.1,    0.1,      0.001,     0.001,  100,   0.01,  0];
ub = [1.571,          +inf,      0,        +inf,   7.26,     5,         2.5,    +inf, +inf,    +inf];
nvars = 10

tic
rng default % For reproducibility
gs = GlobalSearch
problem = createOptimProblem('fmincon','x0',[0.785398,   65000000,   -10,      14,      2,        0.5,   0.05,   500, 25,       15],'objective',@objfun,'lb',[0.523599,   65000000,   -inf,      0.1,    0.1,      0.001,     0.001,  100,   0.01,  0],'ub',[1.571,          +inf,      0,        +inf,   7.26,     5,         2.5,    +inf, +inf,    +inf],'nonlcon',@confun);
[x,fval,eflag,output]  = run(gs,problem)
toc


function d = objfun(x)
d_r = 1000; % density of rod
a_v = 25; % angular_velocity 
k_2 = 0.041; % (parameter based on b and a - window - minor length 1m)
b = 2; % window height
impact_time = 0.01; % impact time of ball with window
p_ratio = 0.18; % poisson_ratio
g_th = 0.012; % glass_thickness
rad_b = 0.108 % radius of the ball

m_r = d_r*x(7)^2*pi*x(6); % mass of rod
moi_r = (m_r*x(6)^2)/3; % moment of inertia of rod
r_KE = 0.5*moi_r*(a_v)^2; % rotational kinetic energy
b_KE = x(8) - r_KE; % Kinetic Energy of ball
v_sq = b_KE*2/x(5); % velocity squared
v_i = sqrt(v_sq); % initial velocity 
n_i = x(2) * pi * (g_th)^2; 
d_i = ((1 + p_ratio)*log((2*b)/(pi*rad_b)));
r_i_f = n_i/(1.5*(d_i+1-k_2)); % required force to break window
x(9) = r_i_f * impact_time / x(5); % final velocity
x(10) = v_i*sin(x(1)); % horitonzal velocity
x(4) = v_i*cos(x(1)); % initial vertical velocity
x(3) = -(sqrt ((x(9))^2 - (x(10))^2)) %minimum final vertical velocity
d = -(x(10) * (x(3) - x (4))/-9.81) % max distance
end



function [c,ceq] = confun(x);
% parameters
d_r = 1000; % density of rod
a_v = 25; % angular_velocity 
k_2 = 0.041; % (parameter based on b and a - window - minor length 1m)
b = 2; % window height
impact_time = 0.01; % impact time of ball with window
p_ratio = 0.18; % poisson_ratio
g_th = 0.012; % glass_thickness
rad_b = 0.108 % radius of the ball

% Inequality constraints
c(1) = (x(3))^2 - (x(4))^2 + 588.6; 
% c1: final height must be above 30 meters 
% c1: (vvf^2-vvi^2<= -588.6) 
c(2) = x(10) - x(9); 
% c2: vh < required_velocity
c(3) = - x(3) - x(4);
% c3: vvi > - vvf
c(4) = 10*x(7) - x(6); 
% c4: 10*radius of the arm <= length of arm
c(5) = -(sqrt((x(8) - (0.5*(((d_r*x(7)^2*pi*x(6))*x(6)^2)/3)*(a_v)^2))*2/x(5)))
% c5: vvi > 0
% Equality constraints
ceq = [];  % None for this problem
end
