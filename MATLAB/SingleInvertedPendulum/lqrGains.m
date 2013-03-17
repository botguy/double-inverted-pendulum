function K = lqrGains(Areal, Breal, Q, R)
    [K,S,E] = lqr(Areal,Breal,Q,R);
end