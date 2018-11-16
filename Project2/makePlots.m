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

%% Plot four different times
time = [1, 20, 10, 200];
for i = 1:4
    h = figure;
    contourSlice(P, U, time(i))
    str_title = sprintf('Time = %.0f seconds',abs(time(i)*dt-1));
    title(str_title)
end

%% Plot aluminium and Dough
load('meshCakeVariablesAluminium.mat')
savePrecisionAlu = savePrecision;
tmaxAlu = tmax;
UAlu = U;
alphaAlu = getPhysicalConstant('Aluminium');

load('meshCakeVariablesDough.mat')
savePrecisionDough = savePrecision;
tmaxDough = tmax;
UDough = U;
alphaDough = getPhysicalConstant('Dough2');

ratio = alphaAlu/alphaDough


%%
figure
hold on
plot3(P(vrod,1),P(vrod,2),P(vrod,3),'*r')
% plot3(P(vsurf,1),P(vsurf,2),P(vsurf,3),'*b')
