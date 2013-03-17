% state vector q = [x, theta]
% x = linear distance
% theta = bottom angle

function qdd = SIP_nonlinearModel()
    syms x theta  xD thetaD  real % coordinates
    syms r l1 real % physical dimensions
    syms m1 mw J1 Jw v g real % physical parameters
    syms kt R % DC motor parameters

    q  = [x, theta]';
    qD = [xD, thetaD]';

    % Global (Fixed) Coordinate System
    ex = [1 0]';
    ey = [0 1]';

    % Body Fixed Coordinate System
    e1 = -ex*sin(theta) + ey*cos(theta); % wheels to pivot

    % Position Definitions
    rw = x*ex;          % wheel position
    rm1 = rw + l1*e1;   % bottom link center of mass
    
    % Velocity Definitions
    rwD  = jacobian(rw,  q)*qD;
    rm1D = jacobian(rm1, q)*qD;

    rwDsq  = rwD'  * rwD;
    rm1Dsq = rm1D' * rm1D;

    % Kinetic and Potential Energy
    T = (1/2) * (  mw*rwDsq + Jw*(xD^2/(r^2)) ...
                +  m1*rm1Dsq + J1*(thetaD^2));

    V = g*m1*rm1'*ey;

    % Lagrangian mechanics
    Mqd = jacobian(T,qD);
    M = simplify( jacobian(Mqd ,qD)); % mass matrix
    Mdqd = simplify( jacobian(Mqd,q)*qD); %constraint forces
    dTdq = simplify(jacobian(T,q)');
    dVdq = simplify(jacobian(V,q)');
    dW = kt/R * (v*[1/r; 1] - [xD/r; thetaD]*kt); % virtual work from motors;
    qdd = simplify(inv(M)*(dW -Mdqd + dTdq - dVdq));
end