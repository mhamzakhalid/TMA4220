function plotMeshPoints(P, vsurf, vrod)
h = figure;
hold on
plot3(P(vrod,1),P(vrod,2),P(vrod,3),'*')
plot3(P(vsurf,1),P(vsurf,2),P(vsurf,3),'*')
P(vsurf,:) = 0;
P(vrod,:) = 0;
b = P(any(P,2),:);
plot3(b(:,1),b(:,2),b(:,3),'*')
end

