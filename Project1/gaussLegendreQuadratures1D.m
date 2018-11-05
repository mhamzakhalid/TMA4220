function integral = gaussLegendreQuadratures1D(f, a, b, N) 
    ksiBar = (a+b) / 2;
    I = abs(b-a);
    [ksi, omega] = getQuadratures(ksiBar, I, N);
    integral = 0;
    for i = 1:length(ksi)
       integral = integral + f(ksi(i))*omega(i);
    end
end

function [ksi, omega] = getQuadratures(ksiBar,I,N)
    switch N
        case 1
            ksi = ksiBar;
            omega = I;
        case 2
            ksi = [ksiBar + I*sqrt(3)/6, ksiBar - I*sqrt(3)/6];
            omega = [0.5*I, 0.5*I];
        case 3
            ksi = [ksiBar + I*sqrt(15)/10, ksiBar - I*sqrt(15)/10, ...
                ksiBar];
            omega = [5/18*I, 5/18*I, 8/18*I];
        case 4
            ksi = [ksiBar + I*sqrt(525+70*sqrt(30))/70, ...
                ksiBar - I*sqrt(525+70*sqrt(30))/70, ...
                ksiBar + I*sqrt(525-70*sqrt(30))/70, ...
                ksiBar - I*sqrt(525-70*sqrt(30))/70];
            omega = [(18-sqrt(30))/36 * I, (18-sqrt(30))/36 * I,...
                (18+sqrt(30))/36 * I, (18+sqrt(30))/36 * I] * 1/2; %error in project descripton
        otherwise
            error("N = %d, is not supported",N);
    end
end