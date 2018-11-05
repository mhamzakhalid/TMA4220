function phi = shapeFunctions(xHat,i)
    if length(xHat) ~= 2
        error("Shape functions are in 2D");
    end
    switch i
        case 0
            phi = 1 - xHat(1) - xHat(2);
        case 1
            phi = xHat(1);
        case 2
            phi = xHat(2);
        otherwise
                error("Shape functions from 0 to 2 only.");
    end
end