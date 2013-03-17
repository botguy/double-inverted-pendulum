function qdd_real = SIP_nonlinearReal(qdd_simplified)
    syms x theta xD thetaD real % coordinates
    syms v real %input voltage

    % System parameters
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
    
    qdd_real = simplify(subs(qdd_simplified));
end