function contourSlice(P,U,vsurf, vrod, time)
    pTemp = P;
    uTemp = U(:,time);
    F = scatteredInterpolant(pTemp,uTemp,'natural','none');
    xint = -1:0.05:1;
    yint = -1:0.05:1;
    zint = 0:0.05:1;
    [x,y,z] = meshgrid(xint,yint,zint);
    V = F(x,y,z);
    contourslice(x,y,z,V,[0],[0],[0.5],5)
    view(3)
    colorbar;
    caxis([20 220])
end
    % Removing boundary:
    %     pTemp(vsurf,:) = 0;
    %     pTemp(vrod,:) = 0;
    %     pTemp = pTemp(any(pTemp,2),:);
%     uTemp(vsurf,:) = 0;
    %     uTemp(vrod,:) = 0;
    %     uTemp = uTemp(any(uTemp,2),:);
