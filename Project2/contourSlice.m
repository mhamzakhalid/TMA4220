function contourSlice(P,U,vsurf, vrod)
    % Removing boundary:
    figure
    for i = 1:30:4000
        pTemp = P;
    %     pTemp(vsurf,:) = 0;
    %     pTemp(vrod,:) = 0;
    %     pTemp = pTemp(any(pTemp,2),:);

        uTemp = U(:,i);
    %     uTemp(vsurf,:) = 0;
    %     uTemp(vrod,:) = 0;
    %     uTemp = uTemp(any(uTemp,2),:);

        F = scatteredInterpolant(pTemp,uTemp,'natural','none');
        xint = -1:0.05:1;
        yint = -1:0.05:1;
        zint = 0:0.05:1;
        [x,y,z] = meshgrid(xint,yint,zint);
        V = F(x,y,z);
%         figure
        contourslice(x,y,z,V,[],[],[0.25 0.5 0.75])
        view(3)
        colorbar;
        pause(0.01)
        clf
    end
end