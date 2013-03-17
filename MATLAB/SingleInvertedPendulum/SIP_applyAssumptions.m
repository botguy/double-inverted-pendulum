function qdd_simplified = SIP_applyAssumptions(qdd)
    syms x theta xD thetaD real % coordinates
    syms r l1 real % physical dimensions
    syms m1 mw J1 Jw v g real % physical parameters
    syms kt R % DC motor parameters

    qdd_simplified = qdd;
    
    % apply solid disk assumption to wheels
    qdd_simplified = subs(qdd_simplified, Jw, 1/2* mw * r^2);
    
    qdd_simplified = simplify(qdd_simplified);
end