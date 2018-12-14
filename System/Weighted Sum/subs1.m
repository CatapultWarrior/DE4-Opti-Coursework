function [E1]=subs1(x)
 %Subsystem 1
    d_r = 1000; % kg/m^3 - rod features
    a_v = 25; %angular_velocity rad/s - catapult initial statistic
    k_2 = 0.041; % (parameter based on b and a - window - minor length 1m)
    b = 2; % meters - window height
    impact_time = 0.01; % seconds
    p_ratio = 0.18; % poisson_ratio
    g_th = 0.012; % meters glass_thickness
    rad_b = 0.108; % radius of the ball
    
    m_r = d_r*x(5)^2*pi*x(4);
    moi_r = (m_r*x(4)^2)/3;
    r_KE = 0.5*moi_r*(a_v)^2;
    n_i = x(2) * pi * (g_th)^2;
    d_i = ((1 + p_ratio)*log((2*b)/(pi*rad_b)));
    r_i_f = n_i/(1.5*(d_i+1-k_2));
    v_req = r_i_f * impact_time / x(3); % final velocity
    
    
    v_i_speed_to_travel = sqrt(100*9.81/(2*cos(90-x(1)*sin(90-x(1)))));
    v_i = v_i_speed_to_travel + v_req;
    v_sq = v_i^2;
    b_KE = v_sq/2*x(3);
    E1 = -(b_KE + r_KE);
    

end