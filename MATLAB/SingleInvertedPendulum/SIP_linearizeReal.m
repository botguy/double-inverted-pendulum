function [Areal,Breal] = SIP_linearizeReal(Asym, Bsym, sip)
    syms x theta xD thetaD real % coordinates

    % System parameters
    g = sip.g;
    l1 = sip.l1; % 20cm
    m1 = sip.m1;
    mw = sip.mw;
    r = sip.r; % 58mm wheel diameter
    J1 = sip.J1; %Fix
    Jw = sip.Jw;
    kt = sip.kt;
    R = sip.R;

    Areal = double(subs(Asym));
    Breal = double(subs(Bsym));
end