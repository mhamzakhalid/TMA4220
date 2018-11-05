function Mk = computeMiniMassMatrix(v0,v1,v2,v3)
    Mk = zeros(4,4);
    Phi ={@(x,y,z) 1-x-y-z, @(x,y,z) x, @(x,y,z) y,@(x,y,z) z};
%     v0 = [0;0];
%     v1 = [1;0];
%     v2 = [0;1];
    for mj=1:4
        for mi=1:4
            g =@(x,y,z) Phi{mj}(x,y,z) * Phi{mi}(x,y,z);
            Mk(mj,mi) = quadrature3D (v0,v1,v2,v3 ,5,g);
        end
    end
end