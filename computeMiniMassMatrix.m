function Mk = computeMiniMassMatrix()
    Mk = zeros(3,3);
    Phi = {@(x,y) 1-x-y, @(x,y) x, @(x,y) y};
    v0 = [0;0];
    v1 = [1;0];
    v2 = [0;1];
    for mj=1:3
        for mi=1:3
            g =@(x,y) Phi{mj}(x,y) * Phi{mi}(x,y);
            Mk(mj,mi) = gaussLegendreQuadratures2D(g,v0,v1,v2,7);
        end
    end
end