function [Areal,Breal] = SIP_linearizeReal(Asym, Bsym)
    syms x theta xD thetaD real % coordinates

    % System parameters
    g = 9.81;
    l1 = 0.5;
    m1 = .1;
    mw = 1;
    r = .1;
    J1 = m1*l1^2; %Fix
    Jw = mw*r^2/2;
    kt = 1;
    R = 5;

    Areal = double(subs(Asym));
    Breal = double(subs(Bsym));
end