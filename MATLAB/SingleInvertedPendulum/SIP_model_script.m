% q = [x, theta]
% find nonlinear model
qdd = SIP_nonlinearModel();
qdd_simplified = SIP_applyAssumptions(qdd);

% plug parameters into nonlinear model
qdd_real = SIP_nonlinearReal(qdd_simplified, sip);

% state vector x = [xDot, theta, thetaDot]
% find linearized model
theta = 0;
[Asym,Bsym] = SIP_linearizeSym(qdd_simplified, theta);
[Areal,Breal] = SIP_linearizeReal(Asym, Bsym, sip);

% calculate LQR gains
Q = eye(3);
R = 1;
K = lqrGains(Areal, Breal, Q, R);

% simulate
x0 = 0;
xD0 = 0;
theta0 = pi/4;
thetaD0 = 0;
SIP_Simulation(K, x0, xD0, theta0, thetaD0);