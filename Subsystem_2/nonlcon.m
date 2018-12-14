%% Constraint Function
function [c,ceq]=nonlcon(x)
    %% Parameters
    %Ball properties
    mb=1.0; %mass 
    rb=0.108;%radius
    
    %Motor properties
    Tmax=500; %Max torque
    
    %Beam properties
    d=0.001; %Maximum allowable deflection 1mm
    mc=pi*x(5)^2*x(6)*x(4); %Mass of arm
    I=1/3*mc*x(4)^2; %Moment of inertia of arm
    
    %Oak Wood material properties. Oak was chosen because it has the
    %highest yield strength and young's modulus (stiffness) among other
    %natural materials. It is also low in density (lightweight) and cost.
    %Material comparison charts are availible in github repo.
    YM=15.6*10^9;% Oak Wood Young's Modulus
    YS=55*10^6; %Oak Wood Yield Strength
    
    %Other parameters
    g=9.81; %Gravitational Acceleration
    t=0.04; %Duration of rotation

    
    %% Inequality Constraint Equations
    %Maximum stress of the beam should be less than half its yield strength
    g1= 2*(mb+mc)*g*x(4)/(pi*x(5)^3)-0.5*YS;
    
    %Maxmimum mass of rod to be 10kg
    g2= x(4)*x(6)*x(5)^2-10/pi; 
    
    %Mimimum initial height 2m 
    g3= -(x(4)*sin(x(1))-2); 
    
    %Minimum speed of the motor must be 25 rads-1
    g4= -(x(1)/t-25);
    
    %Maximum torque required must not exceed 500Nm
    g6= (1/3*mc*x(4)^2+mb*x(4)^2)*(2*x(1)/t)-Tmax; 
    
    %Maximum deflection of the beam must not exceed 0.001mm
    g7=(mb*g*x(4)^3)/(3*YM*I)-d;
    
    %Add only active non-linear constraints
    c=[g1;g3;g4;g7];
    ceq=[];
end

