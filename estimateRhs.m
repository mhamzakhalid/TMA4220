function rhs = estimateRhs(v0, v1, v2,J)
    f = @(x,y) (2*pi^2 + 1)*cos(pi*x)*sin(pi*y);
    Phi = {@(x,y) 1-x-y, @(x,y) x, @(x,y) y};
    %Phi = {@(x,y)  x, @(x,y) y,@(x,y) 1-x-y};
    rhs = 0;
    for i = 1:3
        rhs = rhs + det(J)*specialQuad2D(f,Phi{i},v0,v1,v2,6); 
    end
end 