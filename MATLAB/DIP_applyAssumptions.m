function qdd_simplified = DIP_applyAssumptions(qdd)
    syms x theta phi xD thetaD phiD real % coordinates
    syms r l11 l1t l0 l2 real % physical dimensions
    syms m1 m2 mw J1 J2 Jw tau g real % physical parameters

    qdd_simplified = qdd;
    
    % apply Slender Rod assumption to the top link.
    qdd_simplified = subs(qdd_simplified, J2, 1/3 * m2 * (2*l2)^2);
    
    qdd_simplified = simplify(qdd_simplified);
end