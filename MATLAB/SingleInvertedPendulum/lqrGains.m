%Areal, Breal: numeric evaluations of linearized Single Inverted Pendulum
%model

%Ts: Sampling time

%Q: Controller state cost function weighting
%R: Controller control cost function weighting

%Qn: Model process noise covariance matrix
%Rn: Sensor noise covariance matrix

%state feedback vector: x = [xD, theta, thetaD]
function [K, est, lqg, ctlr]  = lqrGains(Areal, Breal, Ts, Q, R, Qn, Rn)
    % define continuous time SIP plant
    C = [0 1 0; 0 1 -Ts]; % output is theta[n] and theta[n-1]
    D = [0; 0];
    plant = ss(Areal, [Breal, eye(3)], C, [D, zeros(2,3)]);
    set(plant, 'staten', {'xD', 'theta', 'thetaD'});
    set(plant, 'inputn', {'u_v', 'w_xD', 'w_theta', 'w_thetaD'});
    set(plant, 'outputn', {'theta_n', 'theta_n-1'});

    % design descrete time controller u[n] = -K*x[n]
    [K,S,E] = lqrd(Areal,Breal,Q,R, Ts);
    
    %design descrete time Kalman Filter observer
    [est,L,P,M,Z] = kalmd(plant,Qn,Rn,Ts);
    
    % combine LQR and Kalman filter into LQG
    lqg = lqgreg(est, K, 'current');
    
    % convert into tf from potentiometer reading theta to control output u_v
    tf_lqg = tf(lqg);
    delay = tf(1, [1 0],Ts);
    set(delay, 'outputn', {'theta_n-1'});
    set(delay, 'inputn', {'theta_n'});
    ctlr = tf_lqg(1) + series(delay, tf_lqg(2));  
end