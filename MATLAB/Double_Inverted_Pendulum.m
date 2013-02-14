clc
clear all
syms q1 q2 q3 q1d q2d q3d real
syms L L1 L2 m1 m2 m3 I1 I2 I3 r tau g real

q  = [q1, q2, q3]';
qd = [q1d, q2d, q3d]';

P1 = [q1; 0];
P2 = [q1 + L1*cos(q2); L1*sin(q2)];
P3 = [q1 + L*cos(q2)+L2*cos(q2+q3); L*sin(q2)+L2*sin(q2+q3)];

V1 = jacobian(P1,q)*qd;
V2 = jacobian(P2,q)*qd;
V3 = jacobian(P3,q)*qd;
V1sq = V1'*V1;
V2sq = V2'*V2;
V3sq = V3'*V3;

% Kinetic and potential energies
KE = (1/2)*(m1*V1sq + m2*V2sq + m3*V3sq + ...
            I1*q1d^2/r^2 + I2*q2d^2 + I3*(q2d + q3d)^2);
PE = m2*g*P2(2)+m3*g*P3(2);

Mqd = jacobian(KE,qd);
M = simplify( jacobian(Mqd ,qd ) );
Mdqd = simplify( jacobian(Mqd,q)*qd );
dTdq = simplify(jacobian(KE,q)');
dVdq = simplify(jacobian(PE,q)');
qdd = simplify(inv(M)*([1/r; 1; 0]*tau -Mdqd + dTdq - dVdq))

x = [q1 q2 q3 q1d q2d q3d]';
xd = [q1d q2d q3d qdd(1) qdd(2) qdd(3)]';
Asymb = jacobian(xd,x);
Bsymb = jacobian(xd,tau);

% Equilibrium States
q1d = 0;
q2d = 0;
q3d = 0;
q1 = 0;
q2 = pi/2;
q3 = 0;
% System parameters
g = 9.8;
m1 = 10;
r = .25;
I1 = m1*r^2/2;
m2 = 80;
I2 = m2*.5^2;
L1 = .5;
m3 = 80;
I3 = m3*.5^2;
L2 = .5;
L = 1;

A = double(subs(Asymb))
B = double(subs(Bsymb))

Q = eye(6);
R = 1;

[K,S,E] = lqr(A,B,Q,R);
K