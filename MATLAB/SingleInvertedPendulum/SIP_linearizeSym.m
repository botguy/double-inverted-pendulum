function [Asym,Bsym] = SIP_linearizeSym(qdd, thetaIn)
    syms theta xD thetaD real % coordinates
    syms r l1 l0 real % physical dimensions
    syms m1 mw J1 Jw v g real % physical parameters
    syms kt R % DC motor parameters

    
    % Define state vectors and matrices
    y = [xD theta thetaD]';
    yd = [qdd(1) thetaD qdd(2)]';

    % Equilibrium states
    xD = 0;
    thetaD = 0;
    theta = thetaIn;

    Asym = simplify(subs(jacobian(yd, y)));
    Bsym = simplify(subs(jacobian(yd, v)));
end