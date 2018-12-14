%% Objective function: Energy of catapult arm
function f=obj(x)
    %% Parameters
    g=9.81; %gravitational acceleration
    t=0.04; %duration of rotation
    
    %% Design Variables
    %Initial angle, length, density and radius of arm.
    theta=x(1);l=x(2);p=x(3);r=x(4);
    
    %% Objective Equation Formulation
    
    A=pi*r^2; %Cross-sectional area of arm
    mc=pi*r^2*p*l; %Mass of arm 
    
    w=theta/t; %Angular velocity of arm
    I=1/3*mc*l^2; %Moment of inertia of arm (rod with pivot at one end) 
    
    KE=0.5*I*w^2;%Rotational kinetic energy
    GPE=mc*g*l*sin(theta);%Gravitational potential energy
    
    E=KE+GPE; %Sum of kinetic and gravitational energy
    f=E;
end

