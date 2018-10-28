%% Test script
clear all
close all
clc
%% Tests
% testShapeFunctions();
% testAffineMapping();
% testComputeMesh();
% plotErrorGaussLegendreQuadratures1D()
% plotErrorGaussLegendreQuadratures2D()
% testSpecialQuad2d()
%% Shape functions
function testShapeFunctions()
    % Test for nodal basis:
    v = {[0,0],[1,0],[0,1]}; %vertices
    for i = 0:2
        for j = 0:2
            phi = shapeFunctions(v{j+1},i);
            if (round(phi,10) == 1 && i == j) || round(phi,10) == 0
                continue; 
            end
            error("Not a nodal basis. phi = %f, (i,j) = (%d,%d).",phi,i,j);
        end
    end
    fprintf("The shape functions form a nodal basis! \n");
    % then test that for any x in K, the sum of shape functions = 1:
    steplength = 0.001;
    for x = 0: steplength: 1
        for y = 0: steplength: 1-x
            sum = shapeFunctions([x y], 0) + shapeFunctions([x y], 1) ...
                + shapeFunctions([x y], 2);
            if round(sum,10) ~= 1
                error("Sum of shape functions are not 1, it is %f.",sum);
            end
        end
    end
    fprintf("The sum of shape functions equal 1 for all x in K! \n");
end

%% Affine mapping

function testAffineMapping()
    v0 = [1; 0];
    v1 = [3; 1];
    v2 = [3; 2];
    i = 1;
    step = 0.007;
    xMapped = zeros(1,5146);
    yMapped = zeros(1,5146);
    for x = 0:step:1
        for y = 0:step:1-x
            mapped = getAffineMapping(v0,v1,v2,[x;y],false);
            xMapped(i) = mapped(1);
            yMapped(i) = mapped(2);
            i = i + 1;
        end
    end
    h = figure;
    plot(xMapped,yMapped,"*b");
    hold on
    xHat = zeros(1,5146);
    yHat = zeros(1,5146);
    for i = 1:length(xMapped)
        nonMapped = getAffineMapping(v0,v1,v2,[xMapped(i); yMapped(i)],true);
        xHat(i) = nonMapped(1);
        yHat(i) = nonMapped(2);
    end
    plot(xHat,yHat,"*r")
    legend("Mapped to K_0","Reference element")
    set(gca,'fontsize', 16);
    xlim([0,3]);
    title('Test of Affine Mapping from k_0 to K')
%     saveTightFigure(h,'Figures/testAffineMapping.pdf');
end

%% Mesh
function testComputeMesh()
    Kx = 2;
    Ky = 2;
    [elements, vertices] = computeMesh(Kx, Ky);
    figure
    hold on
    for i = 1:length(elements)
        K = vertices(:,elements(:,i));
        K(:,4) = K(:,1);
        plot(K(1,:),K(2,:));
    end
    for i = 1:length(vertices)
        plot(vertices(1,i),vertices(2,i),'*r')
    end
end

%% Gauss-Legendre Quadratures

function plotErrorGaussLegendreQuadratures1D()
    f = @(x) exp(x);
    a = 1;
    b = 2;
    analyticSol = f(2) - f(1);
    error = zeros(1,4);
    for N = 1:4
        error(N) = abs(gaussLegendreQuadratures1D(f,a,b,N) - analyticSol);
    end
    h = figure;
    semilogy(1:4,error,'*')
    xlabel('N_q')
    ylabel('Error')    
    set(gca,'fontsize', 16);
    title('Error for quadrature approximation of \int_I exp(x)')
%     saveTightFigure(h,'Figures/ErrorQuadratures1D.pdf');
    disp(error)
end

function plotErrorGaussLegendreQuadratures2D()
    f = @(x,y) log(x + y);
    v0 = [1; 0];
    v1 = [3; 1];
    v2 = [3; 2];
    analyticSol = 1.16542;
    error = zeros(1,4);
    N = [1, 3, 4, 7];
    for i = 1:length(N)
        error(i) = abs(gaussLegendreQuadratures2D(f, v0, v1, v2, N(i)) - analyticSol);
    end
    h = figure;
    semilogy(N,error,'*')
    title('Error for quadrature approximation of \int_K log(x+y)')
    xlabel('N_q')
    ylabel('Error')
    set(gca,'fontsize', 16);
%     saveTightFigure(h,'Figures/ErrorQuadratures2D.pdf');
    disp(error)
end

%% Special Quadrature
function testSpecialQuad2d()
    v0 = [0.5; 0.5];
    v1 = [1; 0.5];
    v2 = [0.5; 1];
%     [xMapped, jacobian] = getAffineMapping(v0, v1, v2, [0;0], false);
    AnalyticIntegral = -0.287082 - 0.52533 - 0.238248;
    NumericalIntegral = estimateRhs(v0,v1,v2);
    fprintf("Analytic: %f \nNumerical: %f\n",AnalyticIntegral, NumericalIntegral);
    
end
