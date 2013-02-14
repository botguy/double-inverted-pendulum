clc
clear all
syms x theta phi xD thetaD phiD real % coordinates
syms r l11 l1t l0 l2 real % physical dimensions
syms m1 m2 J1 J2 tau g real % physical parameters

q  = [x, theta, phi]';
qD = [xD, thetaD, phiD]';

% globally fixed coordiante system
ex = [1 0]';
ey = [0 1]';

% body fixed coordiante system
e1 = -ex*sin(theta) + ey*cos(theta); %wheels to pivot
etheta = -ex*cos(theta) - ey*sin(theta); %perpendicular to e1
e2 = -ex*sin(theta+phi) + ey*cos(theta+phi); %pivot to top Center of Mass

%position definitions
rw = x*ex;                      % wheel position
rp = rw + l0*e1;                % pivot position
rm1 = rw + l11*e1 + l1t*etheta; % bottom link center of mass
rm2 = rp + l2*e2;               % top link center of mass

% velocity definitions
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
            );

V = g*(m1*rm1'*ey + m1*rm2'*ey);

% Lagrangian mechanics
Mqd = jacobian(T,qD);
M = simplify( jacobian(Mqd ,qD));
Mdqd = simplify( jacobian(Mqd,q)*qD);
dTdq = simplify(jacobian(T,q)');
dVdq = simplify(jacobian(V,q)');
qdd = simplify(inv(M)*([1/r; 1; 0]*tau -Mdqd + dTdq - dVdq))