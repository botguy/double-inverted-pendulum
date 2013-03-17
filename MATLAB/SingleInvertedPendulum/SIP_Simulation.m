function SIP_Simulation(K, x0_in, xD0_in, theta0_in, thetaD0_in)
    x0 = x0_in;
    xD0 = xD0_in;
    theta0 = theta0_in;
    thetaD0 = thetaD0_in;

    % Set up values for ode23
    t0 = 0;
    tf = 3;
    t = (t0:.05:tf)';
    y0 = [x0, xD0, theta0, thetaD0]';
    [t,Y] = ode45(@(t,y) SIP_ode(t,y,K),t,y0);

    % Plot position vs. time for both coordinates
    figure(1)
    x = Y(:,1);
    xD  = Y(:,2);
    theta  = Y(:,3);
    plotyy(t,xD, t,theta);
    ylabel('xDot (m/s), theta (rad)');
    xlabel('Time in seconds');

    figure(2)
    hold on
    axis([-5 5 -1 9]);
    axis('square');
    axis('off');
    r = 0.5;
    l = 5;
    for i=1:length(Y)
        cla
        pts = [ [x(i), r]; [x(i), r] + l*[-sin(theta(i)), cos(theta(i))] ];
         plot(pts(1,1), pts(1,2),'go','LineWidth',23); % green circle
        plot(pts(:,1), pts(:,2),'LineWidth',5,'Color',[.8 0 0]); % two red pendulums
        plot(pts(:,1), pts(:,2),'yo','LineWidth',1); % yellow circles
        plot([-5 5]',[0 0]','LineWidth',3,'Color',[0 0 .8]); % blue ground
        pause(.05);
    end
end