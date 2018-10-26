function rhs = estimateRhs(v0, v1, v2)
    if ~(iscolumn(v0) && iscolumn(v1) && iscolumn(v2))
        error('Vectors must be column vectors')
    end
    f = @(x,y) (2*pi^2 + 1)*cos(pi*x)*sin(pi*y);
    Phi = {@(x,y) 1-x-y, @(x,y) x, @(x,y) y};
    rhs = 0;
    for i = 1:3
        rhs = rhs + specialQuad2D(f,Phi{i},v0,v1,v2,7); 
    end
end 