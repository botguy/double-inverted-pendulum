function qdd_real = SIP_nonlinearReal(qdd_simplified, sip)
    syms x theta xD thetaD real % coordinates
    syms v real %input voltage

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
    
    qdd_real = simplify(subs(qdd_simplified));
    
    %Print function out to file
    fid=fopen('SIP_ode.m','wt');
    
    % simultion vector y = [x, xD, theta, thetaD]
    fprintf(fid,'function ydot = SIP_ode(t,y,K)\n');
    fprintf(fid,'x = y(1);\n');
    fprintf(fid,'xD = y(2);\n');
    fprintf(fid,'theta = y(3);\n');
    fprintf(fid,'thetaD = y(4);\n');
    fprintf(fid,'v = -K*[xD; theta; thetaD];\n');
    fprintf(fid,'ydot(1) = xD;\n');
    fprintf(fid,'ydot(2) = %s;\n', char(qdd_real(1)));
    fprintf(fid,'ydot(3) = thetaD;\n');
    fprintf(fid,'ydot(4) = %s;\n', char(qdd_real(2)));
    fprintf(fid,'ydot = ydot(:);');
    
    fclose(fid);
    
end