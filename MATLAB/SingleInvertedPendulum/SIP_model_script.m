%q = [x, theta]
% find nonlinear model
qdd = SIP_nonlinearModel();
qdd_simplified = SIP_applyAssumptions(qdd);

%plug parameters into nonlinear model
qdd_real = SIP_nonlinearReal(qdd_simplified);

% state vector x = [xDot, theta, thetaDot]
%find linearized model
theta = 0;
[Asym,Bsym] = SIP_linearizeSym(qdd_simplified, theta);
[Areal,Breal] = SIP_linearizeReal(Asym, Bsym);

% calculate LQR gains
Q = eye(3);
R = 1;
K = lqrGains(Areal, Breal, Q, R);

%SIP_Simulation(qdd_real, K);