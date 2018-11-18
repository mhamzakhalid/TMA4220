function alpha = getPhysicalConstant(elementType)
    switch elementType
        case 'Aluminium'
            k = 237;
            rho = 2700;
            cp = 910;
            alpha = k / (rho*cp);
        case 'Dough'
            k = 1.03;
            rho = 1100;
            cp = 1760;
            alpha = k / (rho*cp);
        otherwise
            error('Only Aluminium and Dough are supported')
    end
end

