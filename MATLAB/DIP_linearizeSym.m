function [Asym,Bsym] = DIP_linearizeSym(qdd, thetaIn, phiIn)
    syms x theta phi xD thetaD phiD real % coordinates
    syms r l11 l1t l0 l2 real % physical dimensions
    syms m1 m2 mw J1 J2 Jw tau g real % physical parameters

    
    % Define state vectors and matrices
    y = [x xD theta thetaD phi phiD]';
    yd = [xD qdd(1) thetaD qdd(2) phiD qdd(3)]';

    % Equilibrium states
    xD = 0;
    thetaD = 0;
    phiD = 0;
    x = 0;
    theta = thetaIn;
    phi = phiIn;

    Asym = simplify(subs(jacobian(yd, y)));
    Bsym = simplify(subs(jacobian(yd, tau)));
end