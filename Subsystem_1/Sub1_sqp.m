close all
clear
clc

% d - distance maximum distance found
% x(1) - theta (constraint - rad)
% x(2) - UTS -(constraint - Pa)
% x(3) - vvf  - (constraint - m/s^2)
% x(4) - vvi  - (constraint - m/s^2)
% x(5) - mass ball - (variable - kg)
% x(6) - length of catapult - (variable - m)
% x(7) - radius of arm - (variable - m)
% x(8) - E - energy - (variable - J)
% x(9) - required final velocity - (constraint - m/s^2)
% x(10) - horizontal velocity - (constraint - m/s^2)

x0 = [0.785398,   65000000,   -10,      14,      2,        0.5,   0.05,   500, 25,       15];
lb = [0.523599,   65000000,   -inf,      0.1,    0.1,      0.001,     0.001,  100,   0.01,  0];
ub = [1.571,          +inf,      0,        +inf,   7.26,     5,         2.5,    +inf, +inf,    +inf];


tic
options = optimoptions(@fmincon,'Algorithm','sqp')
[out, fval,exitflag,output] = fmincon(@objfun ,x0,[],[],[],[],lb,ub,@confun,options)
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
% Inequality constraints
c(1) = (x(3))^2 - (x(4))^2 + 588.6; 
% c1 - final height must be above 30 meters 
% c1 - (vvf^2-vvi^2<= -588.6) 
c(2) = x(10) - x(9) % vh < required_velocity
c(3) = - x(3) - x(4) % vvi > - vvf
c(4) = 10*x(7) - x(6) % 10 x radius of the arm <= length of arm
% Equality constraints
ceq = [];  % None for this problem
end