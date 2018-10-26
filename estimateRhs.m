function rhs = estimateRhs(v0, v1, v2)
    f = @(x,y) (2*pi^2 + 1)*cos(pi*x)*sin(pi*y);
    Phi = {@(x,y) 1-x-y, @(x,y) x, @(x,y) y};
    rhs = 0;
    for i = 1:3
        rhs = rhs + specialQuad2D(f,Phi{i},v0,v1,v2,6); 
    end
end 