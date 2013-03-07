clc
clear all
syms x theta phi xD thetaD phiD real % coordinates
syms r l11 l1t l0 l2 real % physical dimensions
syms m1 m2 mw J1 J2 Jw tau g real % physical parameters

q  = [x, theta, phi]';
qD = [xD, thetaD, phiD]';

% Global (Fixed) Coordinate System
ex = [1 0]';
ey = [0 1]';

% Body Fixed Coordinate System
e1 = -ex*sin(theta) + ey*cos(theta); % wheels to pivot
etheta = -ex*cos(theta) - ey*sin(theta); % perpendicular to e1
e2 = -ex*sin(theta+phi) + ey*cos(theta+phi); % pivot to top Center of Mass

% Position Definitions
rw = x*ex;                      % wheel position
rp = rw + l0*e1;                % pivot position
rm1 = rw + l11*e1 + l1t*etheta; % bottom link center of mass
rm2 = rp + l2*e2;               % top link center of mass

% Velocity Definitions
rwD  = jacobian(rw,  q)*qD;
rpD  = jacobian(rp,  q)*qD;
rm1D = jacobian(rm1, q)*qD;
rm2D = jacobian(rm2, q)*qD;

rwDsq  = rwD'  * rwD;
rpDsq  = rpD'  * rpD;
rm1Dsq = rm1D' * rm1D;
rm2Dsq = rm2D' * rm2D;

% Kinetic and Potential Energy
T = (1/2) * (   m1*rwDsq + J1*(thetaD^2) ...
            +   m2*rpDsq + J2*((thetaD + phiD)^2) ...
            +   mw*rwDsq + Jw*(rwDsq/(r^2)) ...
            );

V = g*(m1*rm1'*ey + m1*rm2'*ey);

% Lagrangian mechanics
Mqd = jacobian(T,qD);
M = simplify( jacobian(Mqd ,qD)); % mass matrix
Mdqd = simplify( jacobian(Mqd,q)*qD); %constraint forces
dTdq = simplify(jacobian(T,q)');
dVdq = simplify(jacobian(V,q)');
qdd = simplify(inv(M)*([1/r; 1; 0]*tau -Mdqd + dTdq - dVdq));

% Define state vectors and matrices
x = [q(1)  q(2) q(3) qD(1) qD(2) qD(3)]';
xd = [qD(1) qD(2) qD(3) qdd(1) qdd(2) qdd(3)]';
Asymb = jacobian(xd,x);
Bsymb = jacobian(xd,tau);

% Equilibrium states
xD = 0;
thetaD = 0;
phiD = 0;
x = 0;
theta = pi/2;
phi = 0;
% System parameters
g = 9.8;
l11 = .5;
l1t = 0;
l0 = 1;
l2 = 1;
m1 = .25;
m2 = .25;
mw = .5;
r = (58e-3)/2;
J1 = m1*r^2/2;
J2 = m2*.5^2;
Jw = mw*r^2/2;
tau = 10;

% Substitute values into the matrices
A = double(subs(Asymb))
B = double(subs(Bsymb))

Q = eye(6);
R = 1;

% Solve the LQR problem
[K,S,E] = lqr(A,B,Q,R);
K