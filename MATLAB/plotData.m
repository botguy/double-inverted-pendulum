function plotData( data )
    t = data(:,1);
    bottomPot = data(:,2);
    topPot = data(:,3);
    control = data(:,4);
    
    %unwrap time)
    wrapIndx = find([1; diff(t)] <0);    
    t(wrapIndx) = t(wrapIndx) + (2^16);
    
    t = (1:2:2*length(data));
    
    %plot
    figure;
    plotyy(t, [bottomPot], t, control);
end
    