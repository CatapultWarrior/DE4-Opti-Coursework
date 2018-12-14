%% Non linear Constraint Functions
function [c,ceq]=nonlcon(x)
    %% Parameters
    %Ball properties
    mb=1.0; %Mass. Changed for parametric study
    rb=0.108; %Radius.
    
    %Motor properties
    Tmax=500; %Max torque.
    
    %Beam properties
    d=0.001; %Maximum allowable deflection 1mm
    mc=pi*x(4)^2*x(3)*x(2); %Mass of arm
    I=1/3*mc*x(2)^2; %Moment of inertia of arm
    
    %Oak Wood material properties
    %Oak was chosen because it has the highest yield strength and young's
    %modulus in comparison to other natural materials. It is also low in
    %cost and lightweight. Material Ashby plots are included in the github
    %repo.
    YM=15.6*10^9;% Oak Wood Young's Modulus
    YS=55*10^6; %Oak Wood Yield Strength
    
    %Other parameters
    g=9.81;%gravitational acceleration
    t=0.04;%duration of rotation

    
    %% Inequality Constraint Equations
    %Maximum stress of the beam
    g1= 2*(mb+mc)*g*x(2)/(pi*x(4)^3)-0.5*YS;
    
    %Maxmimum mass of rod to be 10kg
    g2= x(2)*x(3)*x(4)^2-10/pi; 
    
    %Mimimum initial height 2m 
    g3= -(x(2)*sin(x(1))-2); 
    
    %Minimum speed of the motor
    g4= -(x(1)/t-25);
    
    %Maximum torque required must not exceed 
    g6= (1/3*mc*x(2)^2+mb*x(2)^2)*(2*x(1)/t)-Tmax; 
    
    %Maximum deflection of the beam
    g7=(mb*g*x(2)^3)/(3*YM*I)-d;
    
    %Active constraints
    c=[g1;g3;g4;g7];
    ceq=[];
end

