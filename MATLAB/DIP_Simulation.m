function DIP_Simulation()
clc;

% System parameters
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
m1 = .1;
m2 = .1;
mw = 1;
r = .1;
J1 = m1*l0^2; %Fix
J2 = m2*l2^2; %Fix
Jw = mw*r^2/2;

% Set up values for ode23
t0 = 0;
tf = 15;
t = (t0:.05:tf)';
y0 = [0 .99*pi/2 0 0 0 0]';
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
axis([-5 5 -5 5]);
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

%   tau = 0;

     tau = -1*[2.2361   11.6645  -13.9676    2.6601    2.5892   -0.3224]*(y-[0 pi/2 0 0 0 0]');
%    tau = -[0  396.9809   0   87.2548]*(y-[0 pi/2 0 0]');
%     if( tau > 40 ), tau = 40; end
%     if( tau < -40 ), tau = -40; end
    q1dd = r*(m1^2*l1t^2*m2*l2^2*thetaD^2*l11*sin(theta)*r+m1^2*l1t^3*m2*l2^2*thetaD^2*cos(theta)*r+m1*l1t^2*m2^2*l2^2*thetaD^2*l0*sin(theta)*r+m1*l1t^2*m2^2*l2^3*sin(theta+phi)*thetaD^2*r+2*m1*l1t^2*m2^2*l2^3*thetaD*sin(theta+phi)*phiD*r+m1*l1t^2*m2^2*l2^3*phiD^2*sin(theta+phi)*r-r*m1*l11*cos(theta)*m2*l2^2*tau-m1*l11^2*m2*l2^2*tau-m1*l1t^2*m2*l2^2*tau-r*m1*l11*cos(theta)*J2*tau+r*m1^2*l1t^2*sin(theta)*m2*l2^2*g*cos(theta)+2*r*m1*l1t*sin(theta)*J2*m2*l2*phiD*sin(theta+phi)*thetaD*l0*cos(theta)+r*m1*l1t*sin(theta)*J2*m2*phiD^2*l2*sin(theta+phi)*l0*cos(theta)+r*m2^2*l2^2*cos(theta+phi)*m1*l1t^2*thetaD^2*l0*cos(theta)*sin(theta+phi)-r*m2^2*l2^2*cos(theta+phi)^2*m1*l1t^2*thetaD^2*l0*sin(theta)-r*m2^2*l2^2*cos(theta+phi)*m1*l1t^2*g*sin(theta+phi)+r*m2^2*l2^2*cos(theta+phi)*m1*l11^2*thetaD^2*l0*cos(theta)*sin(theta+phi)-r*m2^2*l2^2*cos(theta+phi)^2*m1*l11^2*thetaD^2*l0*sin(theta)-r*m2^2*l2^2*cos(theta+phi)*m1*l11^2*g*sin(theta+phi)-r*m2^2*l2^2*cos(theta+phi)*J1*g*sin(theta+phi)+m1^2*l11^3*m2*l2^2*thetaD^2*sin(theta)*r+m1*l11^2*m2^2*l2^2*thetaD^2*l0*sin(theta)*r+m1*l11^2*m2^2*l2^3*sin(theta+phi)*thetaD^2*r+2*m1*l11^2*m2^2*l2^3*thetaD*sin(theta+phi)*phiD*r+m1*l11^2*m2^2*l2^3*phiD^2*sin(theta+phi)*r+J1*J2*m1*thetaD^2*l11*sin(theta)*r+J1*J2*m1*thetaD^2*l1t*cos(theta)*r+J1*J2*m2*thetaD^2*l0*sin(theta)*r+J1*J2*m2*l2*sin(theta+phi)*thetaD^2*r+2*J1*J2*thetaD*m2*l2*sin(theta+phi)*phiD*r-r*m2^2*l2*l0^2*cos(theta)^2*J2*thetaD^2*sin(theta+phi)+r*m2^2*l2*l0^2*cos(theta)*J2*cos(theta+phi)*thetaD^2*sin(theta)-m2^2*l0^2*cos(theta)^2*l2^2*tau-2*r*m1*l11*cos(theta)^2*m2^2*l2^3*phiD*sin(theta+phi)*thetaD*l0+2*r*m1*l11*cos(theta)*m2^2*l2^3*phiD*cos(theta+phi)*thetaD*l0*sin(theta)+r*m1*l11*cos(theta)*m2^2*l2^3*phiD^2*cos(theta+phi)*l0*sin(theta)-r*m1^2*l11^2*cos(theta)*m2*l2^2*g*sin(theta)-2*r*m1^2*l11*cos(theta)^2*m2*l2^2*g*l1t-r*m1*l11*cos(theta)*m2^2*l2^2*g*l0*sin(theta)-2*r*m1*l11*cos(theta)^2*J2*m2*l2*phiD*sin(theta+phi)*thetaD*l0-r*m1*l11*cos(theta)^2*J2*m2*phiD^2*l2*sin(theta+phi)*l0+2*r*m1*l11*cos(theta)*J2*m2*l2*phiD*cos(theta+phi)*thetaD*l0*sin(theta)+r*m1*l11*cos(theta)*J2*m2*phiD^2*l2*cos(theta+phi)*l0*sin(theta)+r*m1^2*l1t^2*sin(theta)*J2*g*cos(theta)-m2^2*l0^2*l2^2*tau*cos(theta+phi)^2-r*m2^2*l2^3*m1*l1t*cos(theta+phi)*thetaD^2*l0+m2^2*l0^2*l2^2*m1*thetaD^2*l11*sin(theta)*r*cos(theta+phi)^2+r*m1*l1t*J2*m2*phiD^2*l2*cos(theta+phi)*l0*cos(theta)^2-r*m1*l1t*J2*m2*phiD^2*l2*cos(theta+phi)*l0+2*r*m1*l1t*J2*m2*l2*phiD*cos(theta+phi)*thetaD*l0*cos(theta)^2-2*r*m1*l1t*J2*m2*l2*phiD*cos(theta+phi)*thetaD*l0+r*m2^2*l2^2*cos(theta+phi)*l0*sin(theta+phi)*g*m1*l11+r*m1*l1t*m2^2*l2^2*g*l0*cos(theta+phi)^2-r*m2^2*l2^2*m1*l1t*sin(theta)*l0^2*sin(theta+phi)*cos(theta+phi)*thetaD^2+r*m2^2*l2^3*m1*l1t*cos(theta+phi)*thetaD^2*l0*cos(theta)^2+r*m1*l1t*m2^2*l2^3*phiD^2*cos(theta+phi)*l0*cos(theta)^2-r*m1*l1t*m2^2*l2^3*phiD^2*cos(theta+phi)*l0-r*m2^2*l0*cos(theta)^2*l2^2*g*m1*l1t-2*r*m2^2*l0^2*cos(theta)^2*J2*l2*phiD*sin(theta+phi)*thetaD-r*m2^2*l0^2*cos(theta)^2*J2*phiD^2*l2*sin(theta+phi)+2*r*m2^2*l0^2*cos(theta)*J2*l2*phiD*cos(theta+phi)*thetaD*sin(theta)+r*m2^2*l0^2*cos(theta)*J2*phiD^2*l2*cos(theta+phi)*sin(theta)-2*r*m2*l0*cos(theta)^2*J2*g*m1*l1t-r*m2^2*l0^2*cos(theta)*J2*g*sin(theta)-r*m2*l2*m1*l11*cos(theta)^2*J2*thetaD^2*l0*sin(theta+phi)+r*m2*l2*m1*l11*cos(theta)*J2*cos(theta+phi)*thetaD^2*l0*sin(theta)-r*m1^2*l11^2*cos(theta)*J2*g*sin(theta)-2*r*m1^2*l11*cos(theta)^2*J2*g*l1t-2*r*m1*l11*cos(theta)*J2*g*m2*l0*sin(theta)+2*r*m1*l1t*sin(theta)*m2^2*l2^3*phiD*sin(theta+phi)*thetaD*l0*cos(theta)+r*m1*l1t*sin(theta)*m2^2*l2^3*phiD^2*sin(theta+phi)*l0*cos(theta)-r*m2*l2*m1*l1t*J2*cos(theta+phi)*thetaD^2*l0-r*m2^2*l2^2*m1*l1t*l0^2*cos(theta)*cos(theta+phi)^2*thetaD^2+2*r*m1*l1t*m2^2*l2^3*phiD*cos(theta+phi)*thetaD*l0*cos(theta)^2-2*r*m1*l1t*m2^2*l2^3*phiD*cos(theta+phi)*thetaD*l0-m2^2*l0^2*cos(theta)*l2^2*cos(theta+phi)*sin(theta+phi)*m1*thetaD^2*l11*r+r*m2*l2*m1*l1t*J2*cos(theta+phi)*thetaD^2*l0*cos(theta)^2-J1*J2*tau-J1*m2*l2^2*tau-m2*l0^2*J2*tau-m1*l1t^2*J2*tau-m1*l11^2*J2*tau-r*m1*l11*cos(theta)^2*m2^2*l2^3*phiD^2*sin(theta+phi)*l0+r*m2^2*l2^2*cos(theta+phi)*J1*thetaD^2*l0*cos(theta)*sin(theta+phi)-r*m2^2*l2^2*cos(theta+phi)^2*J1*thetaD^2*l0*sin(theta)+r*m2^2*l2^3*m1*l1t*sin(theta)*thetaD^2*l0*cos(theta)*sin(theta+phi)+r*m2*l2*m1*l1t*sin(theta)*J2*thetaD^2*l0*cos(theta)*sin(theta+phi)-r*m2^2*l2^3*m1*l11*cos(theta)^2*thetaD^2*l0*sin(theta+phi)+r*m2^2*l2^3*m1*l11*cos(theta)*cos(theta+phi)*thetaD^2*l0*sin(theta)+m1^2*l11^2*J2*thetaD^2*l1t*cos(theta)*r+m1*l11^2*J2*m2*thetaD^2*l0*sin(theta)*r+m1*l11^2*J2*m2*l2*sin(theta+phi)*thetaD^2*r+2*m1*l11^2*J2*thetaD*m2*l2*sin(theta+phi)*phiD*r+m1*l11^2*J2*m2*phiD^2*l2*sin(theta+phi)*r+2*m2^2*l0^2*cos(theta)^2*l2^2*cos(theta+phi)^2*tau+2*m2^2*l0^2*cos(theta)*l2^2*cos(theta+phi)*sin(theta)*sin(theta+phi)*tau+m2^2*l0^2*l2^2*m1*thetaD^2*l1t*cos(theta)*r+m1^2*l1t^2*J2*thetaD^2*l11*sin(theta)*r+m1^2*l1t^3*J2*thetaD^2*cos(theta)*r+m1*l1t^2*J2*m2*thetaD^2*l0*sin(theta)*r+m1*l1t^2*J2*m2*l2*sin(theta+phi)*thetaD^2*r+2*m1*l1t^2*J2*thetaD*m2*l2*sin(theta+phi)*phiD*r+m1*l1t^2*J2*m2*phiD^2*l2*sin(theta+phi)*r+J1*J2*m2*phiD^2*l2*sin(theta+phi)*r+J1*m2*l2^2*m1*thetaD^2*l11*sin(theta)*r+J1*m2*l2^2*m1*thetaD^2*l1t*cos(theta)*r+J1*m2^2*l2^2*thetaD^2*l0*sin(theta)*r+J1*m2^2*l2^3*sin(theta+phi)*thetaD^2*r+2*J1*m2^2*l2^3*thetaD*sin(theta+phi)*phiD*r+J1*m2^2*l2^3*phiD^2*sin(theta+phi)*r+m2*l0^2*J2*m1*thetaD^2*l11*sin(theta)*r+m2*l0^2*J2*m1*thetaD^2*l1t*cos(theta)*r+m2^2*l0^3*J2*thetaD^2*sin(theta)*r+m2^2*l0^2*J2*l2*sin(theta+phi)*thetaD^2*r+2*m2^2*l0^2*J2*thetaD*l2*sin(theta+phi)*phiD*r+m2^2*l0^2*J2*phiD^2*l2*sin(theta+phi)*r+r*m1*l1t*sin(theta)*m2*l2^2*tau+r*m1*l1t*sin(theta)*J2*tau-r*m2^2*l0*cos(theta)*l2^2*tau-r*m2*l0*cos(theta)*J2*tau+r*m2^2*l2^2*cos(theta+phi)^2*l0*cos(theta)*tau+r*m2^2*l2^2*cos(theta+phi)*l0*sin(theta)*sin(theta+phi)*tau+m1^2*l11^2*m2*l2^2*thetaD^2*l1t*cos(theta)*r+m1^2*l11^3*J2*thetaD^2*sin(theta)*r+r*m1^2*l1t*m2*l2^2*g*l11+r*m1^2*l1t*J2*g*l11+r*m1*l1t*J2*g*m2*l0)/(-Jw*m1*l11^2*J2-mw*r^2*J1*J2-m1*r^2*J1*J2-Jw*J1*J2-mw*r^2*m1*l1t^2*J2-mw*r^2*m1*l11^2*J2-mw*r^2*m1*l1t^2*m2*l2^2-mw*r^2*m1*l11^2*m2*l2^2-mw*r^2*J1*m2*l2^2-mw*r^2*m2*l0^2*J2-mw*r^2*m2^2*l0^2*l2^2*cos(theta+phi)^2-m1^2*r^2*l1t^2*m2*l2^2*cos(theta)^2-m1*r^2*m2^2*l0^2*l2^2*cos(theta+phi)^2-m1^2*r^2*l11^2*m2*l2^2-m1*r^2*J1*m2*l2^2-m1*r^2*m2*l0^2*J2-m1*r^2*m2^2*l0^2*cos(theta)^2*l2^2-Jw*m2^2*l0^2*l2^2*cos(theta+phi)^2-Jw*m2^2*l0^2*cos(theta)^2*l2^2-m1^2*r^2*l1t^2*J2*cos(theta)^2-mw*r^2*m2^2*l0^2*cos(theta)^2*l2^2-2*r^2*m1*l1t*m2^2*l2^2*cos(theta+phi)*l0*sin(theta+phi)*cos(theta)^2+2*r^2*m1*l1t*m2^2*l2^2*cos(theta+phi)*l0*sin(theta+phi)+r^2*m2^2*l0^2*cos(theta)^2*J2+r^2*m1^2*l11^2*cos(theta)^2*J2+r^2*m1^2*l11^2*cos(theta)^2*m2*l2^2-m1^2*r^2*l11^2*J2-2*r^2*m1^2*l11*cos(theta)*l1t*sin(theta)*m2*l2^2-2*r^2*m1^2*l11*cos(theta)*l1t*sin(theta)*J2+2*r^2*m1*l11*cos(theta)^2*m2^2*l0*l2^2+2*r^2*m1*l11*cos(theta)^2*m2*l0*J2-2*r^2*m1*l11*cos(theta)^2*m2^2*l2^2*cos(theta+phi)^2*l0-2*r^2*m1*l11*cos(theta)*m2^2*l2^2*cos(theta+phi)*l0*sin(theta)*sin(theta+phi)+2*mw*r^2*m2^2*l0^2*cos(theta)*l2^2*cos(theta+phi)*sin(theta)*sin(theta+phi)+2*mw*r^2*m2^2*l0^2*cos(theta)^2*l2^2*cos(theta+phi)^2+m2^2*l2^2*cos(theta+phi)^2*r^2*m1*l11^2-m2^2*r^2*m1*l1t^2*l2^2-m2^2*r^2*m1*l11^2*l2^2-m2*r^2*J1*J2-m2^2*r^2*J1*l2^2-m2^2*r^2*l0^2*J2-Jw*J1*m2*l2^2-2*r^2*m1*l1t*sin(theta)*m2^2*l0*cos(theta)*l2^2-2*r^2*m1*l1t*sin(theta)*m2*l0*cos(theta)*J2+2*r^2*m1*l1t*sin(theta)*m2^2*l2^2*cos(theta+phi)^2*l0*cos(theta)+m2^2*l2^2*cos(theta+phi)^2*r^2*m1*l1t^2+2*Jw*m2^2*l0^2*cos(theta)^2*l2^2*cos(theta+phi)^2+m2^2*l2^2*cos(theta+phi)^2*r^2*J1+2*m1*r^2*m2^2*l0^2*cos(theta)^2*l2^2*cos(theta+phi)^2+2*m1*r^2*m2^2*l0^2*cos(theta)*l2^2*cos(theta+phi)*sin(theta)*sin(theta+phi)+2*Jw*m2^2*l0^2*cos(theta)*l2^2*cos(theta+phi)*sin(theta)*sin(theta+phi)-m2*r^2*m1*l1t^2*J2-m2*r^2*m1*l11^2*J2-Jw*m1*l11^2*m2*l2^2-Jw*m2*l0^2*J2-Jw*m1*l1t^2*J2-Jw*m1*l1t^2*m2*l2^2);
    q2dd = -(-m2*l2*m1*r^2*J2*cos(theta+phi)*thetaD^2*l0*sin(theta)-m2^2*l2^2*Jw*l0*cos(theta)*cos(theta+phi)*g*sin(theta+phi)+r*m1*l11*cos(theta)*m2*l2^2*tau+m1^2*l1t*J2*thetaD^2*l11*r^2+m1*l1t*m2^2*l2^2*thetaD^2*l0*r^2+m1*r^2*J2*tau+m2*r^2*J2*tau+m2^2*r^2*l2^2*tau+Jw*m2*l2^2*tau+m1^2*l1t*m2*l2^2*thetaD^2*l11*r^2+m1*l1t*J2*m2*thetaD^2*l0*r^2+r*m1*l11*cos(theta)*J2*tau+m2^2*l2^3*m1*r^2*thetaD^2*l0*cos(theta)*sin(theta+phi)-m2^2*l2^3*m1*r^2*cos(theta+phi)*thetaD^2*l0*sin(theta)-m2^2*l2*r^2*J2*cos(theta+phi)*thetaD^2*l0*sin(theta)+mw*r^2*m2*l2^2*tau+m1*r^2*m2*l2^2*tau+mw*r^2*m2^2*l2^2*g*l0*sin(theta)*cos(theta+phi)^2+m2^2*l2^2*m1*r^2*l0^2*sin(theta)*thetaD^2*cos(theta)-m2^2*l2^2*Jw*l0^2*sin(theta+phi)*cos(theta+phi)*thetaD^2-2*m2^2*l2^2*cos(theta+phi)*r^2*m1*l11*cos(theta)^2*thetaD^2*l0*sin(theta+phi)+m2^2*l2^2*cos(theta+phi)*r^2*m1*l11*cos(theta)*g*sin(theta+phi)-m2^2*l2^2*cos(theta+phi)*r^2*m1*l1t*sin(theta)*g*sin(theta+phi)-2*m1*l11*cos(theta)*m2^2*l2^2*thetaD^2*l0*sin(theta)*r^2-m1*l11*cos(theta)*m2^2*l2^3*sin(theta+phi)*thetaD^2*r^2-2*m1*l11*cos(theta)*m2^2*l2^3*thetaD*sin(theta+phi)*phiD*r^2-m1^2*l11^2*cos(theta)*J2*thetaD^2*sin(theta)*r^2-m1^2*l11^2*cos(theta)*m2*l2^2*thetaD^2*sin(theta)*r^2-2*m1^2*l11*cos(theta)^2*J2*thetaD^2*l1t*r^2-m1*l11*cos(theta)*m2^2*l2^3*phiD^2*sin(theta+phi)*r^2-2*m1*l11*cos(theta)*J2*thetaD*m2*l2*sin(theta+phi)*phiD*r^2-2*m1^2*l11*cos(theta)^2*m2*l2^2*thetaD^2*l1t*r^2-2*m1*l11*cos(theta)*J2*m2*thetaD^2*l0*sin(theta)*r^2-m1*l11*cos(theta)*J2*m2*l2*sin(theta+phi)*thetaD^2*r^2+m1*r^2*m2^2*l2^2*g*l0*sin(theta)*cos(theta+phi)^2+m2^2*l2^2*mw*r^2*l0^2*sin(theta)*thetaD^2*cos(theta)+Jw*m2^2*l2^2*g*l0*sin(theta)*cos(theta+phi)^2-m2^2*l2^2*cos(theta+phi)^2*r^2*m1*l1t*thetaD^2*l0+Jw*J2*tau-m1*l11*cos(theta)*J2*m2*phiD^2*l2*sin(theta+phi)*r^2+m1^2*l1t^2*sin(theta)*m2*l2^2*thetaD^2*cos(theta)*r^2+m1*l1t*sin(theta)*m2^2*l2^3*sin(theta+phi)*thetaD^2*r^2+2*m1*l1t*sin(theta)*m2^2*l2^3*thetaD*sin(theta+phi)*phiD*r^2+m1*l1t*sin(theta)*m2^2*l2^3*phiD^2*sin(theta+phi)*r^2-m2^2*l2^2*mw*r^2*l0^2*sin(theta+phi)*cos(theta+phi)*thetaD^2-m2^2*l2^2*m1*r^2*l0^2*sin(theta+phi)*cos(theta+phi)*thetaD^2+m2^2*l2^2*Jw*l0^2*sin(theta)*thetaD^2*cos(theta)+m2^2*l2^2*cos(theta+phi)*l0*sin(theta+phi)*m1*thetaD^2*l11*r^2+m1^2*l1t^2*sin(theta)*J2*thetaD^2*cos(theta)*r^2+m1*l1t*sin(theta)*J2*m2*l2*sin(theta+phi)*thetaD^2*r^2-m2^2*l0^2*cos(theta)*J2*thetaD^2*sin(theta)*r^2+2*m2^2*l2^2*cos(theta+phi)^2*l0*cos(theta)*m1*thetaD^2*l11*sin(theta)*r^2+2*m1*l1t*sin(theta)*J2*thetaD*m2*l2*sin(theta+phi)*phiD*r^2+m1*l1t*sin(theta)*J2*m2*phiD^2*l2*sin(theta+phi)*r^2-2*m2^2*l0*cos(theta)^2*l2^2*m1*thetaD^2*l1t*r^2-2*m2*l0*cos(theta)^2*J2*m1*thetaD^2*l1t*r^2+2*m2^2*l2^2*cos(theta+phi)^2*l0*cos(theta)^2*m1*thetaD^2*l1t*r^2-m2^2*l2^2*cos(theta+phi)^2*r^2*g*m1*l11*sin(theta)-m2^2*l2^2*cos(theta+phi)^2*r^2*g*m1*l1t*cos(theta)+m2^2*r^2*J2*g*l0*sin(theta)+2*mw*r^2*J2*m2*phiD*l2*sin(theta+phi)*thetaD*l0*cos(theta)+mw*r^2*J2*m2*phiD^2*l2*sin(theta+phi)*l0*cos(theta)-m2^2*r^2*J2*phiD^2*l2*cos(theta+phi)*l0*sin(theta)-2*m2^2*r^2*J2*phiD*thetaD*l0*sin(theta)*l2*cos(theta+phi)+2*m2^2*l2^2*cos(theta+phi)*l0*sin(theta)*sin(theta+phi)*m1*thetaD^2*l1t*cos(theta)*r^2+m2*r^2*J2*g*m1*l11*sin(theta)+m2*r^2*J2*g*m1*l1t*cos(theta)+m2^2*r^2*l2^2*g*m1*l11*sin(theta)+m2^2*r^2*l2^2*g*m1*l1t*cos(theta)+2*Jw*m2^2*l2^3*phiD*sin(theta+phi)*thetaD*l0*cos(theta)+Jw*m2^2*l2^3*phiD^2*sin(theta+phi)*l0*cos(theta)-2*Jw*m2^2*l2^3*phiD*thetaD*l0*sin(theta)*cos(theta+phi)-Jw*m2^2*l2^3*phiD^2*cos(theta+phi)*l0*sin(theta)+Jw*m2*l2^2*g*m1*l11*sin(theta)+Jw*m2*l2^2*g*m1*l1t*cos(theta)-2*mw*r^2*J2*m2*phiD*thetaD*l0*sin(theta)*l2*cos(theta+phi)-mw*r^2*J2*m2*phiD^2*l2*cos(theta+phi)*l0*sin(theta)+mw*r^2*J2*g*m1*l11*sin(theta)+mw*r^2*J2*g*m1*l1t*cos(theta)+mw*r^2*J2*g*m2*l0*sin(theta)-m2^2*l2^2*cos(theta+phi)^2*r^2*tau-r*m1*l1t*sin(theta)*m2*l2^2*tau-r*m1*l1t*sin(theta)*J2*tau+r*m2^2*l0*cos(theta)*l2^2*tau+r*m2*l0*cos(theta)*J2*tau-r*m2^2*l2^2*cos(theta+phi)^2*l0*cos(theta)*tau-r*m2^2*l2^2*cos(theta+phi)*l0*sin(theta)*sin(theta+phi)*tau+2*m1*r^2*J2*m2*phiD*l2*sin(theta+phi)*thetaD*l0*cos(theta)+m1^2*r^2*J2*g*l11*sin(theta)+m1*r^2*J2*m2*phiD^2*l2*sin(theta+phi)*l0*cos(theta)-2*m1*r^2*J2*m2*phiD*thetaD*l0*sin(theta)*l2*cos(theta+phi)-m1*r^2*J2*m2*phiD^2*l2*cos(theta+phi)*l0*sin(theta)+m1^2*r^2*J2*g*l1t*cos(theta)+m1*r^2*J2*g*m2*l0*sin(theta)+mw*r^2*J2*tau+2*Jw*J2*m2*phiD*l2*sin(theta+phi)*thetaD*l0*cos(theta)+Jw*J2*m2*phiD^2*l2*sin(theta+phi)*l0*cos(theta)-2*Jw*J2*m2*phiD*thetaD*l0*sin(theta)*l2*cos(theta+phi)-Jw*J2*m2*phiD^2*l2*cos(theta+phi)*l0*sin(theta)+Jw*J2*g*m1*l11*sin(theta)+Jw*J2*g*m1*l1t*cos(theta)+Jw*J2*g*m2*l0*sin(theta)+2*mw*r^2*m2^2*l2^3*phiD*sin(theta+phi)*thetaD*l0*cos(theta)+mw*r^2*m2^2*l2^3*phiD^2*sin(theta+phi)*l0*cos(theta)-2*mw*r^2*m2^2*l2^3*phiD*thetaD*l0*sin(theta)*cos(theta+phi)-mw*r^2*m2^2*l2^3*phiD^2*cos(theta+phi)*l0*sin(theta)+mw*r^2*m2*l2^2*g*m1*l11*sin(theta)+mw*r^2*m2*l2^2*g*m1*l1t*cos(theta)+2*m1*r^2*m2^2*l2^3*phiD*sin(theta+phi)*thetaD*l0*cos(theta)+m1*r^2*m2^2*l2^3*phiD^2*sin(theta+phi)*l0*cos(theta)-m1*r^2*m2^2*l2^3*phiD^2*cos(theta+phi)*l0*sin(theta)-2*m2^2*l2^2*mw*r^2*l0^2*cos(theta)*cos(theta+phi)^2*thetaD^2*sin(theta)-m2^2*l2^2*mw*r^2*l0*cos(theta)*cos(theta+phi)*g*sin(theta+phi)+2*m2^2*l2^2*mw*r^2*l0^2*cos(theta)^2*cos(theta+phi)*thetaD^2*sin(theta+phi)+m2^2*l2^3*mw*r^2*thetaD^2*l0*cos(theta)*sin(theta+phi)+m2^2*l2^3*Jw*thetaD^2*l0*cos(theta)*sin(theta+phi)-m2^2*l2^3*Jw*cos(theta+phi)*thetaD^2*l0*sin(theta)+m2*l2*Jw*J2*thetaD^2*l0*cos(theta)*sin(theta+phi)-m2*l2*Jw*J2*cos(theta+phi)*thetaD^2*l0*sin(theta)+2*m2^2*l2^2*m1*r^2*l0^2*cos(theta)^2*cos(theta+phi)*thetaD^2*sin(theta+phi)-2*m1*r^2*m2^2*l2^3*phiD*thetaD*l0*sin(theta)*cos(theta+phi)+m1^2*r^2*m2*l2^2*g*l11*sin(theta)+m1^2*r^2*m2*l2^2*g*l1t*cos(theta)-2*m2^2*l2^2*m1*r^2*l0^2*cos(theta)*cos(theta+phi)^2*thetaD^2*sin(theta)-m2^2*l2^2*m1*r^2*l0*cos(theta)*cos(theta+phi)*g*sin(theta+phi)-m2^2*l2^3*mw*r^2*cos(theta+phi)*thetaD^2*l0*sin(theta)+m2*l2*mw*r^2*J2*thetaD^2*l0*cos(theta)*sin(theta+phi)-m2*l2*mw*r^2*J2*cos(theta+phi)*thetaD^2*l0*sin(theta)+2*m2^2*l2^2*Jw*l0^2*cos(theta)^2*cos(theta+phi)*thetaD^2*sin(theta+phi)-2*m2^2*l2^2*Jw*l0^2*cos(theta)*cos(theta+phi)^2*thetaD^2*sin(theta)+m2*l2*m1*r^2*J2*thetaD^2*l0*cos(theta)*sin(theta+phi))/(-Jw*m1*l11^2*J2-mw*r^2*J1*J2-m1*r^2*J1*J2-Jw*J1*J2-mw*r^2*m1*l1t^2*J2-mw*r^2*m1*l11^2*J2-mw*r^2*m1*l1t^2*m2*l2^2-mw*r^2*m1*l11^2*m2*l2^2-mw*r^2*J1*m2*l2^2-mw*r^2*m2*l0^2*J2-mw*r^2*m2^2*l0^2*l2^2*cos(theta+phi)^2-m1^2*r^2*l1t^2*m2*l2^2*cos(theta)^2-m1*r^2*m2^2*l0^2*l2^2*cos(theta+phi)^2-m1^2*r^2*l11^2*m2*l2^2-m1*r^2*J1*m2*l2^2-m1*r^2*m2*l0^2*J2-m1*r^2*m2^2*l0^2*cos(theta)^2*l2^2-Jw*m2^2*l0^2*l2^2*cos(theta+phi)^2-Jw*m2^2*l0^2*cos(theta)^2*l2^2-m1^2*r^2*l1t^2*J2*cos(theta)^2-mw*r^2*m2^2*l0^2*cos(theta)^2*l2^2-2*r^2*m1*l1t*m2^2*l2^2*cos(theta+phi)*l0*sin(theta+phi)*cos(theta)^2+2*r^2*m1*l1t*m2^2*l2^2*cos(theta+phi)*l0*sin(theta+phi)+r^2*m2^2*l0^2*cos(theta)^2*J2+r^2*m1^2*l11^2*cos(theta)^2*J2+r^2*m1^2*l11^2*cos(theta)^2*m2*l2^2-m1^2*r^2*l11^2*J2-2*r^2*m1^2*l11*cos(theta)*l1t*sin(theta)*m2*l2^2-2*r^2*m1^2*l11*cos(theta)*l1t*sin(theta)*J2+2*r^2*m1*l11*cos(theta)^2*m2^2*l0*l2^2+2*r^2*m1*l11*cos(theta)^2*m2*l0*J2-2*r^2*m1*l11*cos(theta)^2*m2^2*l2^2*cos(theta+phi)^2*l0-2*r^2*m1*l11*cos(theta)*m2^2*l2^2*cos(theta+phi)*l0*sin(theta)*sin(theta+phi)+2*mw*r^2*m2^2*l0^2*cos(theta)*l2^2*cos(theta+phi)*sin(theta)*sin(theta+phi)+2*mw*r^2*m2^2*l0^2*cos(theta)^2*l2^2*cos(theta+phi)^2+m2^2*l2^2*cos(theta+phi)^2*r^2*m1*l11^2-m2^2*r^2*m1*l1t^2*l2^2-m2^2*r^2*m1*l11^2*l2^2-m2*r^2*J1*J2-m2^2*r^2*J1*l2^2-m2^2*r^2*l0^2*J2-Jw*J1*m2*l2^2-2*r^2*m1*l1t*sin(theta)*m2^2*l0*cos(theta)*l2^2-2*r^2*m1*l1t*sin(theta)*m2*l0*cos(theta)*J2+2*r^2*m1*l1t*sin(theta)*m2^2*l2^2*cos(theta+phi)^2*l0*cos(theta)+m2^2*l2^2*cos(theta+phi)^2*r^2*m1*l1t^2+2*Jw*m2^2*l0^2*cos(theta)^2*l2^2*cos(theta+phi)^2+m2^2*l2^2*cos(theta+phi)^2*r^2*J1+2*m1*r^2*m2^2*l0^2*cos(theta)^2*l2^2*cos(theta+phi)^2+2*m1*r^2*m2^2*l0^2*cos(theta)*l2^2*cos(theta+phi)*sin(theta)*sin(theta+phi)+2*Jw*m2^2*l0^2*cos(theta)*l2^2*cos(theta+phi)*sin(theta)*sin(theta+phi)-m2*r^2*m1*l1t^2*J2-m2*r^2*m1*l11^2*J2-Jw*m1*l11^2*m2*l2^2-Jw*m2*l0^2*J2-Jw*m1*l1t^2*J2-Jw*m1*l1t^2*m2*l2^2);
    q3dd = -(-m2*l2*Jw*m1*l1t^2*cos(theta+phi)*thetaD^2*l0*sin(theta)-m2*l2*Jw*m1*l1t^2*g*sin(theta+phi)+m2*l2*Jw*m1*l11^2*thetaD^2*l0*cos(theta)*sin(theta+phi)-r*m2*l2*cos(theta+phi)*m1*l11^2*tau-2*mw*r^2*m2^2*l0^2*cos(theta)*l2^2*cos(theta+phi)^2*phiD^2*sin(theta)+mw*r^2*m2*l0*cos(theta)*l2*cos(theta+phi)*g*m1*l11*sin(theta)+mw*r^2*m2*l0*cos(theta)^2*l2*cos(theta+phi)*g*m1*l1t+mw*r^2*m2^2*l0^2*cos(theta)*l2*cos(theta+phi)*g*sin(theta)-m2*l2*m1*r^2*J2*cos(theta+phi)*thetaD^2*l0*sin(theta)-m2^2*l2^2*Jw*l0*cos(theta)*cos(theta+phi)*g*sin(theta+phi)+r*m1*l11*cos(theta)*m2*l2^2*tau+m1*l1t*m2^2*l0*l2^2*phiD^2*r^2+m1^2*l1t*J2*thetaD^2*l11*r^2+2*m1*l1t*m2^2*l2^2*thetaD^2*l0*r^2+2*m1*l1t*m2^2*l0*l2^2*thetaD*phiD*r^2+m1*r^2*J2*tau+m2*r^2*J2*tau+m2^2*r^2*l2^2*tau+Jw*m2*l2^2*tau+m1^2*l1t*m2*l2^2*thetaD^2*l11*r^2+m1*l1t*J2*m2*thetaD^2*l0*r^2+m1*r^2*m2^2*l0^2*sin(theta)*l2^2*phiD^2*cos(theta)+r*m1*l11*cos(theta)*J2*tau+mw*r^2*m2*l0*sin(theta)*l2*sin(theta+phi)*g*m1*l1t*cos(theta)-m2*l2*Jw*m1*l11^2*cos(theta+phi)*thetaD^2*l0*sin(theta)-m2*l2*Jw*m1*l11^2*g*sin(theta+phi)+m2^2*l2*Jw*l0^3*thetaD^2*cos(theta)*sin(theta+phi)+m2^2*l2^3*m1*r^2*thetaD^2*l0*cos(theta)*sin(theta+phi)-m2^2*l2^3*m1*r^2*cos(theta+phi)*thetaD^2*l0*sin(theta)-m2^2*l2*r^2*J2*cos(theta+phi)*thetaD^2*l0*sin(theta)-m1*l1t*m2^2*l0*l2^2*phiD^2*r^2*cos(theta)^2+2*m1*l1t*m2^2*l0*l2^2*phiD^2*r^2*cos(theta)^2*cos(theta+phi)^2-2*m1*l1t*m2^2*l0*l2^2*thetaD*phiD*r^2*cos(theta)^2-2*mw*r^2*m2^2*l0^2*l2^2*sin(theta+phi)*phiD*thetaD*cos(theta+phi)-m2*l2*m1^2*r^2*l1t^2*g*sin(theta+phi)*cos(theta)^2+m1^2*l1t*sin(theta)*m2*l0*l2*sin(theta+phi)*thetaD^2*l11*r^2+mw*r^2*m2*l2^2*tau+m1*r^2*m2*l2^2*tau-m2^2*l2*Jw*l0^3*cos(theta+phi)*thetaD^2*sin(theta)+m2*l2*m1*r^2*J1*thetaD^2*l0*cos(theta)*sin(theta+phi)-m2*l2*m1*r^2*J1*cos(theta+phi)*thetaD^2*l0*sin(theta)-m2*l2*m1*r^2*J1*g*sin(theta+phi)-2*Jw*m2^2*l0^2*l2^2*sin(theta+phi)*phiD*thetaD*cos(theta+phi)+mw*r^2*m2^2*l0^2*sin(theta)*l2^2*phiD^2*cos(theta)+2*m1*r^2*m2^2*l0^2*sin(theta)*l2^2*phiD*thetaD*cos(theta)+2*mw*r^2*m2^2*l0^2*sin(theta)*l2^2*phiD*thetaD*cos(theta)-2*m1*l1t*m2^2*l0*l2^2*phiD^2*r^2*cos(theta+phi)^2+mw*r^2*m2^2*l2^2*g*l0*sin(theta)*cos(theta+phi)^2+2*m2^2*l2^2*m1*r^2*l0^2*sin(theta)*thetaD^2*cos(theta)-2*m2^2*l2^2*Jw*l0^2*sin(theta+phi)*cos(theta+phi)*thetaD^2-4*m2^2*l2^2*cos(theta+phi)*r^2*m1*l11*cos(theta)^2*thetaD^2*l0*sin(theta+phi)+m2^2*l2^2*cos(theta+phi)*r^2*m1*l11*cos(theta)*g*sin(theta+phi)-m2^2*l2^2*cos(theta+phi)*r^2*m1*l1t*sin(theta)*g*sin(theta+phi)-3*m1*l11*cos(theta)*m2^2*l2^2*thetaD^2*l0*sin(theta)*r^2-m1*l11*cos(theta)*m2^2*l2^3*sin(theta+phi)*thetaD^2*r^2-2*m1*l11*cos(theta)*m2^2*l2^3*thetaD*sin(theta+phi)*phiD*r^2-m1^2*l11^2*cos(theta)*J2*thetaD^2*sin(theta)*r^2-m1^2*l11^2*cos(theta)*m2*l2^2*thetaD^2*sin(theta)*r^2-2*m1^2*l11*cos(theta)^2*J2*thetaD^2*l1t*r^2-m1*l11*cos(theta)*m2^2*l2^3*phiD^2*sin(theta+phi)*r^2-2*m1*l11*cos(theta)*J2*thetaD*m2*l2*sin(theta+phi)*phiD*r^2-2*m1^2*l11*cos(theta)^2*m2*l2^2*thetaD^2*l1t*r^2-2*m1*l11*cos(theta)*J2*m2*thetaD^2*l0*sin(theta)*r^2-m1*l11*cos(theta)*J2*m2*l2*sin(theta+phi)*thetaD^2*r^2+Jw*m2^2*l0^2*sin(theta)*l2^2*phiD^2*cos(theta)+m2*l2*cos(theta+phi)*r^2*m1^2*l1t*g*l11-m2^2*l2*m1*r^2*l0^2*g*sin(theta+phi)*cos(theta)^2-r*m1*l1t*m2*l0*l2*sin(theta+phi)*tau+r*m1*l1t*m2*l0*l2*sin(theta+phi)*tau*cos(theta)^2+m2^2*l2*cos(theta+phi)*r^2*m1*l1t*g*l0-m2*l2*mw*r^2*m1*l11^2*cos(theta+phi)*thetaD^2*l0*sin(theta)+4*Jw*m2^2*l0^2*cos(theta)^2*l2^2*cos(theta+phi)*phiD*sin(theta+phi)*thetaD+2*Jw*m2^2*l0^2*cos(theta)^2*l2^2*cos(theta+phi)*phiD^2*sin(theta+phi)-4*Jw*m2^2*l0^2*cos(theta)*l2^2*cos(theta+phi)^2*phiD*thetaD*sin(theta)-2*Jw*m2^2*l0^2*cos(theta)*l2^2*cos(theta+phi)^2*phiD^2*sin(theta)+Jw*m2*l0*cos(theta)*l2*cos(theta+phi)*g*m1*l11*sin(theta)+Jw*m2*l0*cos(theta)^2*l2*cos(theta+phi)*g*m1*l1t+m2^2*l2*r^2*J1*thetaD^2*l0*cos(theta)*sin(theta+phi)-m2^2*l2*r^2*J1*g*sin(theta+phi)+m1*r^2*m2^2*l2^2*g*l0*sin(theta)*cos(theta+phi)^2+2*m2^2*l2^2*mw*r^2*l0^2*sin(theta)*thetaD^2*cos(theta)+Jw*m2^2*l2^2*g*l0*sin(theta)*cos(theta+phi)^2-3*m2^2*l2^2*cos(theta+phi)^2*r^2*m1*l1t*thetaD^2*l0+Jw*J2*tau-m1*l11*cos(theta)*J2*m2*phiD^2*l2*sin(theta+phi)*r^2+m1^2*l1t^2*sin(theta)*m2*l2^2*thetaD^2*cos(theta)*r^2+m1*l1t*sin(theta)*m2^2*l2^3*sin(theta+phi)*thetaD^2*r^2+2*m1*l1t*sin(theta)*m2^2*l2^3*thetaD*sin(theta+phi)*phiD*r^2+m1*l1t*sin(theta)*m2^2*l2^3*phiD^2*sin(theta+phi)*r^2-2*m1*l11*cos(theta)*m2^2*l0^2*l2*sin(theta+phi)*thetaD^2*r^2-4*m2^2*l2^2*cos(theta+phi)^2*r^2*m1*l1t*phiD*thetaD*l0-m1*r^2*m2^2*l0^2*l2^2*sin(theta+phi)*phiD^2*cos(theta+phi)+4*m2^2*l2^2*cos(theta+phi)^2*r^2*m1*l1t*phiD*thetaD*l0*cos(theta)^2-2*m1*l11*cos(theta)*m2^2*l0*sin(theta)*l2^2*thetaD*phiD*r^2-2*m2^2*l2^2*mw*r^2*l0^2*sin(theta+phi)*cos(theta+phi)*thetaD^2-2*m2^2*l2^2*m1*r^2*l0^2*sin(theta+phi)*cos(theta+phi)*thetaD^2+2*m2^2*l2^2*Jw*l0^2*sin(theta)*thetaD^2*cos(theta)+m2^2*l2^2*cos(theta+phi)*l0*sin(theta+phi)*m1*thetaD^2*l11*r^2+Jw*m2^2*l0^2*cos(theta)*l2*cos(theta+phi)*g*sin(theta)-mw*r^2*m2^2*l0^2*l2^2*sin(theta+phi)*phiD^2*cos(theta+phi)+m1*l1t*sin(theta)*m2^2*l0^2*l2*sin(theta+phi)*thetaD^2*r^2+m1^2*l1t^2*sin(theta)*J2*thetaD^2*cos(theta)*r^2+m1*l1t*sin(theta)*J2*m2*l2*sin(theta+phi)*thetaD^2*r^2-m2^2*l0^2*cos(theta)*J2*thetaD^2*sin(theta)*r^2+4*m2^2*l2^2*cos(theta+phi)^2*l0*cos(theta)*m1*thetaD^2*l11*sin(theta)*r^2+2*m1*l1t*sin(theta)*J2*thetaD*m2*l2*sin(theta+phi)*phiD*r^2+m1^2*r^2*m2*l0*l2*sin(theta+phi)*g*l11-m1^2*r^2*m2*l0*l2*sin(theta+phi)*g*l11*cos(theta)^2-Jw*m2^2*l0^2*l2^2*sin(theta+phi)*phiD^2*cos(theta+phi)+Jw*m2*l0*l2*sin(theta+phi)*g*m1*l11-Jw*m2*l0*l2*sin(theta+phi)*g*m1*l11*cos(theta)^2-m1^2*l1t*m2*l0*cos(theta)*l2*cos(theta+phi)*thetaD^2*l11*r^2+2*Jw*m2^2*l0^2*sin(theta)*l2^2*phiD*thetaD*cos(theta)-m1*l11*cos(theta)*m2^2*l0*sin(theta)*l2^2*phiD^2*r^2+m2^2*r^2*l0*l2*sin(theta+phi)*g*m1*l11+m1*l1t*sin(theta)*J2*m2*phiD^2*l2*sin(theta+phi)*r^2-3*m2^2*l0*cos(theta)^2*l2^2*m1*thetaD^2*l1t*r^2-2*m2*l0*cos(theta)^2*J2*m1*thetaD^2*l1t*r^2+4*m2^2*l2^2*cos(theta+phi)^2*l0*cos(theta)^2*m1*thetaD^2*l1t*r^2-m2^2*l2^2*cos(theta+phi)^2*r^2*g*m1*l11*sin(theta)-m2^2*l2^2*cos(theta+phi)^2*r^2*g*m1*l1t*cos(theta)-r*m2*l2*cos(theta+phi)*J1*tau-m2*l2*mw*r^2*m1*l11^2*g*sin(theta+phi)+m2^2*l2*mw*r^2*l0^3*thetaD^2*cos(theta)*sin(theta+phi)-m2^2*l2*mw*r^2*l0^3*cos(theta+phi)*thetaD^2*sin(theta)+m2^2*l2*r^2*m1*l1t^2*thetaD^2*l0*cos(theta)*sin(theta+phi)-m2^2*l2*r^2*m1*l1t^2*g*sin(theta+phi)+m2^2*l2*m1*r^2*l0^3*thetaD^2*cos(theta)*sin(theta+phi)-m2^2*l2*m1*r^2*l0^3*cos(theta+phi)*thetaD^2*sin(theta)+m2^2*r^2*J2*g*l0*sin(theta)+m2^2*l2*r^2*m1*l11^2*thetaD^2*l0*cos(theta)*sin(theta+phi)+m2*l2*m1^2*r^2*l1t^2*thetaD^2*l0*cos(theta)*sin(theta+phi)-m2^2*l2*r^2*m1*l11^2*g*sin(theta+phi)+2*mw*r^2*J2*m2*phiD*l2*sin(theta+phi)*thetaD*l0*cos(theta)+mw*r^2*J2*m2*phiD^2*l2*sin(theta+phi)*l0*cos(theta)-m2^2*r^2*J2*phiD^2*l2*cos(theta+phi)*l0*sin(theta)-2*m2^2*r^2*J2*phiD*thetaD*l0*sin(theta)*l2*cos(theta+phi)+4*m2^2*l2^2*cos(theta+phi)*l0*sin(theta)*sin(theta+phi)*m1*thetaD^2*l1t*cos(theta)*r^2+m2*r^2*J2*g*m1*l11*sin(theta)+m2*r^2*J2*g*m1*l1t*cos(theta)+m2^2*r^2*l2^2*g*m1*l11*sin(theta)+m2^2*r^2*l2^2*g*m1*l1t*cos(theta)+2*Jw*m2^2*l2^3*phiD*sin(theta+phi)*thetaD*l0*cos(theta)+Jw*m2^2*l2^3*phiD^2*sin(theta+phi)*l0*cos(theta)-2*Jw*m2^2*l2^3*phiD*thetaD*l0*sin(theta)*cos(theta+phi)+m2*l2*mw*r^2*m1*l11^2*thetaD^2*l0*cos(theta)*sin(theta+phi)+m2*l2*mw*r^2*m1*l1t^2*thetaD^2*l0*cos(theta)*sin(theta+phi)-m2*l2*mw*r^2*m1*l1t^2*cos(theta+phi)*thetaD^2*l0*sin(theta)-m2*l2*mw*r^2*m1*l1t^2*g*sin(theta+phi)-m2*l2*Jw*J1*g*sin(theta+phi)+Jw*m2*l0*sin(theta)*l2*sin(theta+phi)*g*m1*l1t*cos(theta)-2*m2*l2*r^2*m1^2*l11*cos(theta)*l1t*sin(theta)*g*sin(theta+phi)+4*m1*r^2*m2^2*l0^2*cos(theta)^2*l2^2*cos(theta+phi)*phiD*sin(theta+phi)*thetaD+2*m1*r^2*m2^2*l0^2*cos(theta)^2*l2^2*cos(theta+phi)*phiD^2*sin(theta+phi)-4*m1*r^2*m2^2*l0^2*cos(theta)*l2^2*cos(theta+phi)^2*phiD*thetaD*sin(theta)-2*m1*r^2*m2^2*l0^2*cos(theta)*l2^2*cos(theta+phi)^2*phiD^2*sin(theta)+m1^2*r^2*m2*l0*cos(theta)*l2*cos(theta+phi)*g*l11*sin(theta)+m1^2*r^2*m2*l0*cos(theta)^2*l2*cos(theta+phi)*g*l1t+m1^2*r^2*m2*l0*sin(theta)*l2*sin(theta+phi)*g*l1t*cos(theta)+m1*r^2*m2^2*l0^2*cos(theta)*l2*cos(theta+phi)*g*sin(theta)-Jw*m2^2*l2^3*phiD^2*cos(theta+phi)*l0*sin(theta)+Jw*m2*l2^2*g*m1*l11*sin(theta)+Jw*m2*l2^2*g*m1*l1t*cos(theta)-2*mw*r^2*J2*m2*phiD*thetaD*l0*sin(theta)*l2*cos(theta+phi)-mw*r^2*J2*m2*phiD^2*l2*cos(theta+phi)*l0*sin(theta)+mw*r^2*J2*g*m1*l11*sin(theta)+mw*r^2*J2*g*m1*l1t*cos(theta)+mw*r^2*J2*g*m2*l0*sin(theta)-m2^2*l2^2*cos(theta+phi)^2*r^2*tau-r*m1*l1t*sin(theta)*m2*l2^2*tau-r*m1*l1t*sin(theta)*J2*tau+r*m2^2*l0*cos(theta)*l2^2*tau+r*m2*l0*cos(theta)*J2*tau-r*m2^2*l2^2*cos(theta+phi)^2*l0*cos(theta)*tau-r*m2^2*l2^2*cos(theta+phi)*l0*sin(theta)*sin(theta+phi)*tau-m2^2*r^2*l0*sin(theta)*l2*sin(theta+phi)*g*m1*l1t*cos(theta)-m2^2*l2*cos(theta+phi)*r^2*m1*l1t*g*l0*cos(theta)^2-m2^2*l2*mw*r^2*l0^2*g*sin(theta+phi)*cos(theta)^2+mw*r^2*m2*l0*l2*sin(theta+phi)*g*m1*l11-mw*r^2*m2*l0*l2*sin(theta+phi)*g*m1*l11*cos(theta)^2+4*m1*l1t*sin(theta)*m2^2*l0*cos(theta)*l2^2*cos(theta+phi)*thetaD*sin(theta+phi)*phiD*r^2+2*m1*l1t*sin(theta)*m2^2*l0*cos(theta)*l2^2*cos(theta+phi)*phiD^2*sin(theta+phi)*r^2+4*m2^2*l2^2*cos(theta+phi)^2*r^2*m1*l11*cos(theta)*phiD*thetaD*l0*sin(theta)+2*m2^2*l2^2*cos(theta+phi)^2*r^2*m1*l11*cos(theta)*phiD^2*l0*sin(theta)-m2*l2*cos(theta+phi)*r^2*m1^2*l11^2*cos(theta)*g*sin(theta)-2*m2*l2*cos(theta+phi)*r^2*m1^2*l11*cos(theta)^2*g*l1t-m2^2*l2*cos(theta+phi)*r^2*m1*l11*cos(theta)*g*l0*sin(theta)-m2^2*l2*Jw*l0^2*g*sin(theta+phi)*cos(theta)^2-2*m1*r^2*m2^2*l0^2*l2^2*sin(theta+phi)*phiD*thetaD*cos(theta+phi)+2*m1*r^2*J2*m2*phiD*l2*sin(theta+phi)*thetaD*l0*cos(theta)+m1^2*r^2*J2*g*l11*sin(theta)+m1*r^2*J2*m2*phiD^2*l2*sin(theta+phi)*l0*cos(theta)-2*m1*r^2*J2*m2*phiD*thetaD*l0*sin(theta)*l2*cos(theta+phi)-m1*r^2*J2*m2*phiD^2*l2*cos(theta+phi)*l0*sin(theta)+m1^2*r^2*J2*g*l1t*cos(theta)+m1*r^2*J2*g*m2*l0*sin(theta)+m2*l2*cos(theta+phi)*r^2*m1^2*l1t^2*sin(theta)*g*cos(theta)+mw*r^2*J2*tau+2*Jw*J2*m2*phiD*l2*sin(theta+phi)*thetaD*l0*cos(theta)+Jw*J2*m2*phiD^2*l2*sin(theta+phi)*l0*cos(theta)-2*Jw*J2*m2*phiD*thetaD*l0*sin(theta)*l2*cos(theta+phi)-Jw*J2*m2*phiD^2*l2*cos(theta+phi)*l0*sin(theta)+Jw*J2*g*m1*l11*sin(theta)+Jw*J2*g*m1*l1t*cos(theta)+Jw*J2*g*m2*l0*sin(theta)+2*mw*r^2*m2^2*l2^3*phiD*sin(theta+phi)*thetaD*l0*cos(theta)-m2*l2*m1^2*r^2*l11^2*cos(theta+phi)*thetaD^2*l0*sin(theta)-m2*l2*m1^2*r^2*l11^2*g*sin(theta+phi)-r*m2^2*l2*cos(theta+phi)*l0^2*tau+mw*r^2*m2*l0*cos(theta)*l2*cos(theta+phi)*tau+mw*r^2*m2*l0*sin(theta)*l2*sin(theta+phi)*tau+Jw*m2*l0*cos(theta)*l2*cos(theta+phi)*tau+Jw*m2*l0*sin(theta)*l2*sin(theta+phi)*tau+m1*r^2*m2*l0*cos(theta)*l2*cos(theta+phi)*tau+m1*r^2*m2*l0*sin(theta)*l2*sin(theta+phi)*tau+m2^2*r^2*l0*sin(theta)*l2*sin(theta+phi)*tau-m2*l2*cos(theta+phi)*r^2*m1*l11*cos(theta)*tau+m2*l2*cos(theta+phi)*r^2*m1*l1t*sin(theta)*tau+m2^2*l2*r^2*m1*l11*cos(theta)^2*l0*g*sin(theta+phi)+m2*l2*r^2*m1^2*l11^2*cos(theta)^2*g*sin(theta+phi)+m2*l2*Jw*J1*thetaD^2*l0*cos(theta)*sin(theta+phi)-m2*l2*Jw*J1*cos(theta+phi)*thetaD^2*l0*sin(theta)+r*m1*l11*cos(theta)*m2*l0*sin(theta)*l2*sin(theta+phi)*tau-r*m1*l1t*sin(theta)*m2*l0*cos(theta)*l2*cos(theta+phi)*tau+mw*r^2*m2^2*l2^3*phiD^2*sin(theta+phi)*l0*cos(theta)-2*mw*r^2*m2^2*l2^3*phiD*thetaD*l0*sin(theta)*cos(theta+phi)-mw*r^2*m2^2*l2^3*phiD^2*cos(theta+phi)*l0*sin(theta)+mw*r^2*m2*l2^2*g*m1*l11*sin(theta)+mw*r^2*m2*l2^2*g*m1*l1t*cos(theta)+2*m1*r^2*m2^2*l2^3*phiD*sin(theta+phi)*thetaD*l0*cos(theta)+m1*r^2*m2^2*l2^3*phiD^2*sin(theta+phi)*l0*cos(theta)-m1*r^2*m2^2*l2^3*phiD^2*cos(theta+phi)*l0*sin(theta)-4*m2^2*l2^2*mw*r^2*l0^2*cos(theta)*cos(theta+phi)^2*thetaD^2*sin(theta)-m2^2*l2^2*mw*r^2*l0*cos(theta)*cos(theta+phi)*g*sin(theta+phi)+4*m2^2*l2^2*mw*r^2*l0^2*cos(theta)^2*cos(theta+phi)*thetaD^2*sin(theta+phi)+m2^2*l2^2*cos(theta+phi)*J1*phiD^2*sin(theta+phi)*r^2-4*m1*l11*cos(theta)^2*m2^2*l0*l2^2*cos(theta+phi)*thetaD*sin(theta+phi)*phiD*r^2+m2^2*l2^3*mw*r^2*thetaD^2*l0*cos(theta)*sin(theta+phi)+m2^2*l2^3*Jw*thetaD^2*l0*cos(theta)*sin(theta+phi)-m2^2*l2^3*Jw*cos(theta+phi)*thetaD^2*l0*sin(theta)+m2*l2*Jw*J2*thetaD^2*l0*cos(theta)*sin(theta+phi)-m2*l2*Jw*J2*cos(theta+phi)*thetaD^2*l0*sin(theta)+4*m2^2*l2^2*m1*r^2*l0^2*cos(theta)^2*cos(theta+phi)*thetaD^2*sin(theta+phi)+m2^2*l2^2*cos(theta+phi)*m1*l1t^2*phiD^2*sin(theta+phi)*r^2+m2*l2*cos(theta+phi)*m1^2*l11^3*thetaD^2*sin(theta)*r^2+m2*l2*cos(theta+phi)*m1^2*l11^2*thetaD^2*l1t*cos(theta)*r^2+m2^2*l2^2*cos(theta+phi)*m1*l11^2*sin(theta+phi)*thetaD^2*r^2+2*m2^2*l2^2*cos(theta+phi)*m1*l11^2*thetaD*sin(theta+phi)*phiD*r^2+m2^2*l2^2*cos(theta+phi)*J1*sin(theta+phi)*thetaD^2*r^2-2*m1*r^2*m2^2*l2^3*phiD*thetaD*l0*sin(theta)*cos(theta+phi)+m1^2*r^2*m2*l2^2*g*l11*sin(theta)+m1^2*r^2*m2*l2^2*g*l1t*cos(theta)-4*m2^2*l2^2*m1*r^2*l0^2*cos(theta)*cos(theta+phi)^2*thetaD^2*sin(theta)+m2^2*l2^2*cos(theta+phi)*m1*l11^2*phiD^2*sin(theta+phi)*r^2+m2*l2*cos(theta+phi)*m1^2*l1t^3*thetaD^2*cos(theta)*r^2+m2*l2*cos(theta+phi)*m1^2*l1t^2*thetaD^2*l11*sin(theta)*r^2+m2^2*l2^2*cos(theta+phi)*m1*l1t^2*sin(theta+phi)*thetaD^2*r^2+2*m2^2*l2^2*cos(theta+phi)*m1*l1t^2*thetaD*sin(theta+phi)*phiD*r^2+m2*l2*cos(theta+phi)*J1*m1*thetaD^2*l11*sin(theta)*r^2+m2*l2*cos(theta+phi)*J1*m1*thetaD^2*l1t*cos(theta)*r^2+4*mw*r^2*m2^2*l0^2*cos(theta)^2*l2^2*cos(theta+phi)*phiD*sin(theta+phi)*thetaD+2*mw*r^2*m2^2*l0^2*cos(theta)^2*l2^2*cos(theta+phi)*phiD^2*sin(theta+phi)-4*mw*r^2*m2^2*l0^2*cos(theta)*l2^2*cos(theta+phi)^2*phiD*thetaD*sin(theta)+2*m2^2*l2^2*cos(theta+phi)*J1*thetaD*sin(theta+phi)*phiD*r^2+m2^2*l2*cos(theta+phi)*l0^2*m1*thetaD^2*l11*sin(theta)*r^2-2*m1*l11*cos(theta)^2*m2^2*l0*l2^2*cos(theta+phi)*phiD^2*sin(theta+phi)*r^2+r*m1*l11*cos(theta)^2*m2*l0*l2*cos(theta+phi)*tau-m2^2*l2^2*m1*r^2*l0*cos(theta)*cos(theta+phi)*g*sin(theta+phi)-m2^2*l2^3*mw*r^2*cos(theta+phi)*thetaD^2*l0*sin(theta)+m2*l2*mw*r^2*J2*thetaD^2*l0*cos(theta)*sin(theta+phi)-m2*l2*mw*r^2*J2*cos(theta+phi)*thetaD^2*l0*sin(theta)+4*m2^2*l2^2*Jw*l0^2*cos(theta)^2*cos(theta+phi)*thetaD^2*sin(theta+phi)-4*m2^2*l2^2*Jw*l0^2*cos(theta)*cos(theta+phi)^2*thetaD^2*sin(theta)+m2*l2*m1*r^2*J2*thetaD^2*l0*cos(theta)*sin(theta+phi)+r*m2^2*l0^2*cos(theta)^2*l2*cos(theta+phi)*tau+r*m2^2*l0^2*cos(theta)*sin(theta)*l2*sin(theta+phi)*tau-r*m2*l2*cos(theta+phi)*m1*l1t^2*tau+m2*l2*mw*r^2*J1*thetaD^2*l0*cos(theta)*sin(theta+phi)-m2*l2*mw*r^2*J1*cos(theta+phi)*thetaD^2*l0*sin(theta)-m2*l2*mw*r^2*J1*g*sin(theta+phi)+m2*l2*Jw*m1*l1t^2*thetaD^2*l0*cos(theta)*sin(theta+phi))/(Jw*m1*l11^2*J2+mw*r^2*J1*J2+m1*r^2*J1*J2+Jw*J1*J2+mw*r^2*m1*l1t^2*J2+mw*r^2*m1*l11^2*J2+mw*r^2*m1*l1t^2*m2*l2^2+mw*r^2*m1*l11^2*m2*l2^2+mw*r^2*J1*m2*l2^2+mw*r^2*m2*l0^2*J2+mw*r^2*m2^2*l0^2*l2^2*cos(theta+phi)^2+m1^2*r^2*l1t^2*m2*l2^2*cos(theta)^2+m1*r^2*m2^2*l0^2*l2^2*cos(theta+phi)^2+m1^2*r^2*l11^2*m2*l2^2+m1*r^2*J1*m2*l2^2+m1*r^2*m2*l0^2*J2+m1*r^2*m2^2*l0^2*cos(theta)^2*l2^2+Jw*m2^2*l0^2*l2^2*cos(theta+phi)^2+Jw*m2^2*l0^2*cos(theta)^2*l2^2+m1^2*r^2*l1t^2*J2*cos(theta)^2+mw*r^2*m2^2*l0^2*cos(theta)^2*l2^2+2*r^2*m1*l1t*m2^2*l2^2*cos(theta+phi)*l0*sin(theta+phi)*cos(theta)^2-2*r^2*m1*l1t*m2^2*l2^2*cos(theta+phi)*l0*sin(theta+phi)-r^2*m2^2*l0^2*cos(theta)^2*J2-r^2*m1^2*l11^2*cos(theta)^2*J2-r^2*m1^2*l11^2*cos(theta)^2*m2*l2^2+m1^2*r^2*l11^2*J2+2*r^2*m1^2*l11*cos(theta)*l1t*sin(theta)*m2*l2^2+2*r^2*m1^2*l11*cos(theta)*l1t*sin(theta)*J2-2*r^2*m1*l11*cos(theta)^2*m2^2*l0*l2^2-2*r^2*m1*l11*cos(theta)^2*m2*l0*J2+2*r^2*m1*l11*cos(theta)^2*m2^2*l2^2*cos(theta+phi)^2*l0+2*r^2*m1*l11*cos(theta)*m2^2*l2^2*cos(theta+phi)*l0*sin(theta)*sin(theta+phi)-2*mw*r^2*m2^2*l0^2*cos(theta)*l2^2*cos(theta+phi)*sin(theta)*sin(theta+phi)-2*mw*r^2*m2^2*l0^2*cos(theta)^2*l2^2*cos(theta+phi)^2-m2^2*l2^2*cos(theta+phi)^2*r^2*m1*l11^2+m2^2*r^2*m1*l1t^2*l2^2+m2^2*r^2*m1*l11^2*l2^2+m2*r^2*J1*J2+m2^2*r^2*J1*l2^2+m2^2*r^2*l0^2*J2+Jw*J1*m2*l2^2+2*r^2*m1*l1t*sin(theta)*m2^2*l0*cos(theta)*l2^2+2*r^2*m1*l1t*sin(theta)*m2*l0*cos(theta)*J2-2*r^2*m1*l1t*sin(theta)*m2^2*l2^2*cos(theta+phi)^2*l0*cos(theta)-m2^2*l2^2*cos(theta+phi)^2*r^2*m1*l1t^2-2*Jw*m2^2*l0^2*cos(theta)^2*l2^2*cos(theta+phi)^2-m2^2*l2^2*cos(theta+phi)^2*r^2*J1-2*m1*r^2*m2^2*l0^2*cos(theta)^2*l2^2*cos(theta+phi)^2-2*m1*r^2*m2^2*l0^2*cos(theta)*l2^2*cos(theta+phi)*sin(theta)*sin(theta+phi)-2*Jw*m2^2*l0^2*cos(theta)*l2^2*cos(theta+phi)*sin(theta)*sin(theta+phi)+m2*r^2*m1*l1t^2*J2+m2*r^2*m1*l11^2*J2+Jw*m1*l11^2*m2*l2^2+Jw*m2*l0^2*J2+Jw*m1*l1t^2*J2+Jw*m1*l1t^2*m2*l2^2);
    
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