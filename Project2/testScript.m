%%TestScript
clear all 
close all
clc
%% 3D quadrature:
p1 = [0;0;0];
p2 = [0;2;0];
p3 = [0;0;2];
p4 = [2;0;0];
g = @(x,y,z) exp(x);
f = @(x) 0.5*exp(x)*(x^2-6*x+10);
analytic = f(2) - f(0); %Most likely wrong.
N = [1 4 5];
numerical = zeros(1,length(N));
for i = 1:length(N)
    numerical(i) = quadrature3D(p1,p2,p3,p4,N(i),g);
end
error = abs(numerical - analytic);
figure
semilogy(N,error,'*-')
xlabel('N')
ylabel('Error')
title('Error plot \int_k e^x dx dy dz')
set(gca,'fontsize',16)
%% 
clear all
close all 
clc
p1 = [0;0;0];
p2 = [0;2;0];
p3 = [0;0;2];
p4 = [2;0;0];
p = [p1,p2,p3,p4]';
a = [1,2,3,4];
figure
tetramesh(a,p)
xlabel('x')
ylabel('y')
zlabel('z')
