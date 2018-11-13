clear all
close all
clc
load('meshCakeVariables.mat');
%% Plot time
figure
dt = 3600/size(U,2);
stepSize = floor(size(U,2)/20);
for time = 1:stepSize:size(U,2)
    contourSlice(P,U,vsurf, vrod, time)
    str_title = sprintf('Time = %.0f seconds',abs(time*dt-1));
    title(str_title)
    pause(0.01)
    clf
end

%% Plot four different times
time = [1, 20, 10, 200];
for i = 1:4
    h = figure;
    contourSlice(P,U,vsurf, vrod, time(i))
    str_title = sprintf('Time = %.0f seconds',abs(time(i)*dt-1));
    title(str_title)
end

%%
figure
hold on
plot3(P(vrod,1),P(vrod,2),P(vrod,3),'*r')
% plot3(P(vsurf,1),P(vsurf,2),P(vsurf,3),'*b')
