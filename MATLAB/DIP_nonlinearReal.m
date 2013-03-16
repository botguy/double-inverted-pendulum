function qdd_real = DIP_nonlinearReal(qdd_simplified)
    syms x theta phi xD thetaD phiD real % coordinates

    % System parameters
    g = 9.8;
    l11 = .5;
    l1t = 0;
    l0 = 1;
    l2 = 1;
    m1 = .1;
    m2 = .1;
    mw = 1;
    r = .1;
    J1 = m1*l0^2; %Fix
    J2 =  1/3 * m2 * (2*l2)^2; % Slender Rod assumption, Inertia taken about pivot
    Jw = mw*r^2/2;
    tau = 20;

    qdd_real = simplify(subs(qdd_simplified));
end