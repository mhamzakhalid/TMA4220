clear
clc

%% adding geometry
geometry = 'meshcake';
addpath(geometry);
fileID = fopen(strcat('cake_nodes.m'), 'r');        %All node coordinates
formatSpec = '%d %f %f %f';
sizeA = [4 inf];
P = fscanf(fileID, formatSpec, sizeA);
P = P'; 
fclose(fileID); 
 
fileID = fopen(strcat('cake_tetr.m'), 'r');         %Tetrahedral elements
formatSpec = '%d %d %d %d %d %d';
sizeB = [6 inf];
tet = fscanf(fileID, formatSpec, sizeB);
tet = tet';
tet(:, 5:6) = [];
fclose(fileID);

fileID = fopen(strcat('cake_tri.m'), 'r');          %Surface elements
formatSpec = '%d %d %d %d %d';
sizeC = [5 inf];
tri = fscanf(fileID, formatSpec, sizeC);
tri = tri';

tr = tri(:,2:end);


