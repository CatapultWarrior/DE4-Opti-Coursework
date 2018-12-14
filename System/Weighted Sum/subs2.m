function [E2]=subs2(x)
    %Subsystem 2
    g=9.81; t=0.04;
    
    theta=x(1);l=x(4);p=x(6);r=x(5);

    A=pi*r^2;
    mc=pi*r^2*p*l;
    w=theta/t;
    I=1/3*mc*l^2;
    
    KE=0.5*I*w^2;
    GPE=mc*g*l*sin(theta);
    
    E2=KE+GPE;
end