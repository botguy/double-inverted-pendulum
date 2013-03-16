%q = [x, theta, phi]
% find nonlinear model
qdd = DIP_nonlinearModel();
qdd_simplified = DIP_applyAssumptions(qdd);

%plug parameters into nonlinear model
qdd_real = DIP_nonlinearReal(qdd_simplified);

% state vector x = [x, xDot, theta, thetaDot, phi, phiDot]
%find linearized model
theta = 0;
phi = 0;
[Asym,Bsym] = DIP_linearizeSym(qdd, theta, phi);
[Areal,Breal] = DIP_linearizeReal(Asym, Bsym);

% calculate LQR gains
Q = eye(6);
R = 1;
K = lqrGains(Areal, Breal, Q, R);

%DIP_Simulation(qdd_real, K);