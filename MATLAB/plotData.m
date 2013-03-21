function plotData( data )
 %   t = data(:,1);
    bottomPot = data(:,1);
    topPot = data(:,2);
    control = data(:,3);
    
    %unwrap time)
    %wrapIndx = find([1; diff(t)] <0);    
   % t(wrapIndx) = t(wrapIndx) + (2^16);
    
    t = (1:2:2*length(data));
    
    %plot
    figure;
    plotyy(t, [bottomPot], t, [topPot, control]);
end
    