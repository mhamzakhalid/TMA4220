clear all
close all
clc
% load('Name');
%% Plot time
figure
dt = tmax/size(U,2);
stepSize = floor(size(U,2)/40);
for time = 1:stepSize:size(U,2)
    contourSlice(P, U, time)
    str_title = sprintf('Time = %.0f seconds',abs(time*dt-1));
    title(str_title)
    pause(0.01)
    clf
end

%% Plot four different times Dough
load('meshCakeVariablesDough2.mat')
dt = tmax/size(U,2);
time = [1, 200, 600, 1201];
for i = 1:4
    h = figure;
    contourSlice(P, U, time(i))
    str_title = sprintf('Dough at time = %.0f minutes',abs(time(i)*dt-1)/60);
    title(str_title)
    set(gca,'fontsize', 16);
end

%% Plot four different times Aluminium
load('meshCakeVariablesAluminium.mat')
dt = tmax/size(U,2);
time = [1, 20, 70, 250];
for i = 1:4
    h = figure;
    contourSlice(P, U, time(i))
    str_title = sprintf('Aluminium at time = %.0f seconds',abs(time(i)*dt-1));
    title(str_title)
    set(gca,'fontsize', 16);
end

%% Plot aluminium and Dough
load('meshCakeVariablesAluminium.mat')
savePrecisionAlu = savePrecision;
tmaxAlu = tmax;
UAlu = U;
alphaAlu = getPhysicalConstant('Aluminium');
dtAlu = tmaxAlu/size(UAlu,2);

load('meshCakeVariablesDough2.mat')
savePrecisionDough = savePrecision;
tmaxDough = tmax;
UDough = U;
alphaDough = getPhysicalConstant('Dough2');
dtDough = tmaxDough/size(UDough,2);

ratio = alphaAlu/alphaDough

plotAtAluTime = 40;
aluNum = floor(40/dtAlu);
doughNum = floor(40*ratio/dtDough);

figure
contourSlice(P, UAlu, aluNum)
str_title = sprintf('Aluminium at time = %.0f seconds with \\alpha = %.2e.',abs(aluNum*dtAlu-1),alphaAlu);
title(str_title);
set(gca,'fontsize', 16);

figure
contourSlice(P, UDough, doughNum)
str_title = sprintf('Dough at time = %.0f seconds with \\alpha = %.2e.',abs(doughNum*dtDough-1),alphaDough);
title(str_title);
set(gca,'fontsize', 16);

%%
figure
hold on
plot3(P(vrod,1),P(vrod,2),P(vrod,3),'*r')
% plot3(P(vsurf,1),P(vsurf,2),P(vsurf,3),'*b')
