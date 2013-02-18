function DIP_Simulation()
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

% Set up values for ode23
t0 = 0;
tf = 15;
t = (t0:.05:tf)';
y0 = [0 pi/2 0 0 0 0]';
[t,Y] = ode23(@fofx,t,y0);

% Plot position vs. time for both coordinates
figure(1)
x  = Y(:,1);
theta  = Y(:,2);
phi = Y(:,3);
plot(t,[x theta phi]);
ylabel('x (m), theta (rad), phi (rad)')
xlabel('Time in seconds')

figure(2)
hold on
axis([-2.1 2.1 -2.1 2.1]);
axis('square');
axis('off');
for i=1:length(Y)
    cla
    q1 = Y(i,1);
    q2 = Y(i,2);
    q3 = Y(i,3);
    pts = [ [q1 r 0]', [q1 r 0]' + l0*[cos(q2) sin(q2) 0]', [q1 r 0]' + l0*[cos(q2) sin(q2) 0]' + l2*[cos(q2+q3) sin(q2+q3) 0]'];
    plot(q1,r,'go','LineWidth',23); % green circle
    plot(pts(1,:)',pts(2,:)','LineWidth',5,'Color',[.8 0 0]); % two red pendulums
    plot(pts(1,:)',pts(2,:)','yo','LineWidth',1); % yellow circles
    plot([-5 5]',[0 0]','LineWidth',3,'Color',[0 0 .8]); % blue ground
    pause(.1);
end

function ydot = fofx(t,y)
    q1  = y(1);
    q2  = y(2);
    q3  = y(3);
    q1d = y(4);
    q2d = y(5);
    q3d = y(6);

%    tau = 0;
     tau = -[1.0000 19.8194 0.0000 1.0459 0.7192 0]*(y-[0 pi/2 0 0 0 0]');
%    tau = -[0  396.9809   0   87.2548]*(y-[0 pi/2 0 0]');
%     if( tau > 40 ), tau = 40; end
%     if( tau < -40 ), tau = -40; end
    q1dd = -r*(J1*tau-J1*m2*l0*sin(q2)*q2d^2*r+m2*l0^2*tau-m2^2*l0^3*sin(q2)*q2d^2*r+m2*l0*cos(q2)*r*tau+m2*l0*cos(q2)*r*g*m1*l11*sin(q2)+m2*l0*cos(q2)^2*r*g*m1*l1t+m2*l0^2*cos(q2)*r*g*m1*sin(q2))/(-m1*r^2*J1-m1*r^2*m2*l0^2-m2*r^2*J1-m2^2*r^2*l0^2-mw*r^2*J1-mw*r^2*m2*l0^2-Jw*J1-Jw*m2*l0^2+m2^2*l0^2*cos(q2)^2*r^2);
    q2dd = -(mw*r^2*g*m1*l11*sin(q2)+mw*r^2*g*m1*l1t*cos(q2)+mw*r^2*g*m1*l0*sin(q2)+Jw*g*m1*l11*sin(q2)+Jw*g*m1*l1t*cos(q2)+Jw*g*m1*l0*sin(q2)+m2*l0*cos(q2)*r*tau+Jw*tau+m1*r^2*tau+m2*r^2*tau+mw*r^2*tau-m2^2*l0^2*cos(q2)*r^2*sin(q2)*q2d^2+m1^2*r^2*g*l11*sin(q2)+m1^2*r^2*g*l1t*cos(q2)+m1^2*r^2*g*l0*sin(q2)+m2*r^2*g*m1*l11*sin(q2)+m2*r^2*g*m1*l1t*cos(q2)+m2*r^2*g*m1*l0*sin(q2))/(-m1*r^2*J1-m1*r^2*m2*l0^2-m2*r^2*J1-m2^2*r^2*l0^2-mw*r^2*J1-mw*r^2*m2*l0^2-Jw*J1-Jw*m2*l0^2+m2^2*l0^2*cos(q2)^2*r^2)
    q3dd = (-g*m1*l2*sin(q2+q3)*Jw*m2*l0^2+g*m1*l2*sin(q2+q3)*m2^2*l0^2*cos(q2)^2*r^2+J2*Jw*g*m1*l0*sin(q2)-g*m1^2*l2*sin(q2+q3)*r^2*J1-g*m1^2*l2*sin(q2+q3)*r^2*m2*l0^2-g*m1*l2*sin(q2+q3)*m2*r^2*J1-g*m1*l2*sin(q2+q3)*m2^2*r^2*l0^2-g*m1*l2*sin(q2+q3)*mw*r^2*J1-g*m1*l2*sin(q2+q3)*mw*r^2*m2*l0^2-g*m1*l2*sin(q2+q3)*Jw*J1-m2^2*l0^2*cos(q2)*r^2*J2*sin(q2)*q2d^2+m2*l0*cos(q2)*r*J2*tau+J2*m1^2*r^2*g*l11*sin(q2)+J2*m1^2*r^2*g*l1t*cos(q2)+J2*m1^2*r^2*g*l0*sin(q2)+J2*m2*r^2*g*m1*l11*sin(q2)+J2*m2*r^2*g*m1*l1t*cos(q2)+J2*m2*r^2*g*m1*l0*sin(q2)+J2*mw*r^2*g*m1*l11*sin(q2)+J2*mw*r^2*g*m1*l1t*cos(q2)+J2*mw*r^2*g*m1*l0*sin(q2)+J2*Jw*g*m1*l11*sin(q2)+J2*Jw*g*m1*l1t*cos(q2)+J2*m1*r^2*tau+J2*m2*r^2*tau+J2*mw*r^2*tau+J2*Jw*tau)/(-m1*r^2*J1-m1*r^2*m2*l0^2-m2*r^2*J1-m2^2*r^2*l0^2-mw*r^2*J1-mw*r^2*m2*l0^2-Jw*J1-Jw*m2*l0^2+m2^2*l0^2*cos(q2)^2*r^2)/J2
    
    % set the derivative of the state vector
    ydot(1) = q1d;
    ydot(2) = q2d;
    ydot(3) = q3d;
    ydot(4) = q1dd;
    ydot(5) = q2dd;
    ydot(6) = q3dd;
    ydot = ydot(:); % Make sure the vector is vertical
end
end