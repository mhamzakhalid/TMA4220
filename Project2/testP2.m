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
P(:,1) = [];
fclose(fileID); 
 
fileID = fopen(strcat('cake_tetr.m'), 'r');         %Tetrahedral elements
formatSpec = '%d %d %d %d %d %d';
sizeB = [6 inf];
tet = fscanf(fileID, formatSpec, sizeB);
tet = tet';

fclose(fileID);

fileID = fopen(strcat('cake_tri.m'), 'r');          %Surface elements
formatSpec = '%d %d %d %d %d';
sizeC = [5 inf];
tri = fscanf(fileID, formatSpec, sizeC);
tri = tri';
tri(:,4:5) = [];
% tetramesh(tet,P)



%% Implementation

A = zeros(length(P));
M = zeros(length(P));
Phi ={@(x,y,z) 1-x-y-z, @(x,y,z) x, @(x,y,z) y,@(x,y,z) z};
gradphi = [-1 -1 -1; eye(3)];

for i=1:size(tet,1)
    %Vertices of Tetrahedrals
    v1 = tet(i,1);
    v2 = tet(i,2);
    v3 = tet(i,3);
    v4 = tet(i,4);
    %CHECK!
    J = [P(v1,1)-P(v4,1),P(v2,1)-P(v4,1),P(v3,1)-P(v4,1);
       P(v1,2)-P(v4,2),P(v2,2)-P(v4,2),P(v3,2)-P(v4,2);
       P(v1,3)-P(v4,3),P(v2,3)-P(v4,3),P(v3,3)-P(v4,3)];
    G = gradphi*mldivide(J,eye(3));
    %Setting up the stiffness matrix
    Ak = abs(det(J))/(6)*(G*G');
    A(tet(i,1:4),tet(i,1:4)) =  A(tet(i,1:4),tet(i,1:4)) + Ak;
    
    %Setting Mass Matrix
    Mk = computeMiniMassMatrix(P(tet(i,1),:),P(tet(i,2),:)',P(tet(i,3),:)',P(tet(i,4),:))';
    M(tet(i,1:4),tet(i,1:4)) =  M(tet(i,1:4),tet(i,1:4)) + Mk;
       
end
       
%%  Boundary Conditions
%Rod points
rodindex = find(tet(:,5)==1001);
vrod = tet(rodindex,1:4);
Prod = P(vrod,:);
%Surface Points
vsurf = tri;
%Dirichlet homogenoeus
id = eye(size(A,1));
A(vrod,:) = id(vrod,:);
A(vsurf,:) = id(vsurf,:);

       