function contourSlice(P,U,vsurf, vrod)
    % Removing boundary:
    pTemp = P;
    pTemp(vsurf,:) = 0;
    pTemp(vrod,:) = 0;
    pTemp = pTemp(any(pTemp,2),:);

    uTemp = U(:,end);
    uTemp(vsurf,:) = 0;
    uTemp(vrod,:) = 0;
    uTemp = uTemp(any(uTemp,2),:);

    F = scatteredInterpolant(pTemp,uTemp,'natural','none');
    xint = -1:0.05:1;
    yint = -1:0.05:1;
    zint = 0:0.05:1;
    [x,y,z] = meshgrid(xint,yint,zint);
    V = F(x,y,z);
    contourslice(x,y,z,V,[],[],[0.25 0.5 0.75])
    view(3)
end