clear all
clc
close all
%% Graphs of equations

%Plot shape of objective function
figure(1)
obj_plot
%Plot shape of constraints
figure(2)
g1_plot
figure(3)
g3_plot
figure(4)
g7_plot

function obj_plot

    g=9.81; t=0.8;mc=0.2;
    
    Theta= linspace(0,1.571,100);
    L= linspace(0,5.0,100);
    [theta,l]=meshgrid(Theta,L);
    w=theta/t;
    I=1/3*mc.*l.^2;
    
    KE=0.5.*I.*w.^2;
    GPE=mc.*g.*l.*sin(theta);
    
    E=KE+GPE;

    surf(theta,l,E);
    shading interp
    xlabel('Intial Angle,\theta(rad)')
    ylabel('Length of Arm, l (m)')
    zlabel('Energy')
    title('Objective Function')
    
end

function g1_plot
    R=linspace(0,0.02,100);
    L=linspace(0,5.0,100);
    [r,l]=meshgrid(R,L);   
    mb=1.0;g=9.81; p=690;
    mc=pi.*r.^2.*p.*l;
    g1= 2.*(mb+mc).*g.*l./(pi.*r.^3)/10.^6;
    
    surf(r,l,g1);
    shading interp
    xlabel('Radius, r (m)')
    ylabel('Length, l (m)')
    zlabel('Bending Stress, \sigma b (MPa)')
    title('Constraint g1')
end

function g3_plot
    theta=linspace(0,1.571,100);
    l=linspace(0,5.0,100);
    [x,y]=meshgrid(theta,l);

    z=4.0-y*sin(x);
    surf(x,y,z);
    shading interp
    xlabel('Initial Angle, \theta (rad)')
    ylabel('Length, l (m)')
    zlabel('Height of Ball Release, h(m)')
    title('Constraint g3')
end

function g7_plot
    mb=1.0;g=9.81; p=690;
    YM=15.6*10^9;
    
    R=linspace(0,0.02,100);
    L=linspace(0,5.0,100);
    [r,l]=meshgrid(R,L); 
    
    mc=pi.*r.^2.*p.*l;
    I=1/3.*mc.*l.^2; 
    g7=(mb.*g.*l.^3)./(3.*YM.*I);
    
    surf(r,l,g7);
    shading interp
    xlabel('Radius, r (m)')
    ylabel('Length, l (m)')
    zlabel('Deflection, \delta (m)')
    title('Constraint g7')
end
