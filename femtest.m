clear

for N=2:4
n=2^N;
% Returns uniform triangulation of unit square
[X,Y] = meshgrid(0:1/n:1,0:1/n:1);
X = reshape(X,[],1);
Y = reshape(Y,[],1);
% we have a vector of X- and Y- coordinates of our vertices
P = [X,Y];
%Doing the triangulation

tri = delaunay(X,Y);
%For plotting
TR = triangulation(tri,P);
% triplot(TR)

%Displyaing Vertices
% hold on
% vxlabels = arrayfun(@(n) {sprintf('P%d', n)}, (1:length(X))');
% Hpl = text(X, Y, vxlabels, 'FontWeight', 'bold', 'HorizontalAlignment',...
%    'center', 'BackgroundColor', 'none');
% ic = incenter(TR);
% numtri = size(TR,1);
% trilabels = arrayfun(@(x) {sprintf('T%d', x)}, (1:numtri)');
% Htl = text(ic(:,1), ic(:,2), trilabels, 'FontWeight', 'bold', ...
%    'HorizontalAlignment', 'center', 'Color', 'blue');



%Initial Values
S=zeros(length(P));
M=zeros(length(P));
F=zeros(length(P),1);


%Defining F
f = @(x,y) (2*pi^2 + 1)*cos(pi*x)*sin(pi*y); 
%Barycentric coordinates
%ADD THEM LATER
% miniMassMatrix = computeMiniMassMatrix();
%Phi = [eye(2),-ones(2,1)]';
Phi = [-ones(2,1),eye(2)]';

for i=1:length(tri)
    v1=P(tri(i,1),:);
    v2=P(tri(i,2),:);
    v3=P(tri(i,3),:);
    J = [v2(1) - v1(1) , v3(1) - v1(1);
        v2(2) - v1(2) , v3(2) - v1(2)];
    G=Phi*mldivide(J,eye(2));
    %Setting up the stiffness matrix
    Ak=det(J)/2*(G*G');
    %Setting up the mass Matrix
    Mk = det(J)*computeMiniMassMatrix(v1',v2',v3');
    %Setting up the right hand side(NOT SURE ABOUT DET OF J)
%     Fk(1:3,1) = estimateRhs(P(tri(i,1),:)', P(tri(i,2),:)', P(tri(i,3),:)'); 
    
%     bary =[v1',v2',v3']*lambda;
%     f1 = lambda*f(bary(1),bary(2))*det(J)/2;
     f1 = getrhs(v1',v2',v3',f)*det(J)/2;
    
   %Transporting local matrix to the global matrix
    S(tri(i,:),tri(i,:)) = S(tri(i,:),tri(i,:)) + Ak;
    M(tri(i,:),tri(i,:)) = M(tri(i,:),tri(i,:)) + Mk;
%     F(tri(i,:),1) = F(tri(i,:),1) + Fk;
    F(tri(i,:),1) = F(tri(i,:),1) + f1;
          clear Ak f1 Mk;
end

%Implementing the Boundary Conditions
A=S+M;

%Finding boundary nodes for Dirichlet Left and Right
boundary = freeBoundary(TR);
p=[boundary(1:n+1,1);boundary(2*n+1:3*n+1,1)];
for i=1:length(p)
    A(p(i,1),:)=0;
    A(p(i,1),p(i,1))=1;
    F(p(i,1))=0;
end

%Solution
U = A\F;
%exact Solution
exact = cos(pi*X).*sin(pi*Y);
%Error
error(N-1)=norm( U - exact )/n;
end

%% plots

%Convergence Plot
H=[4,8,16];
loglog(H,error)
grid on
title('Convergence Plots')
%Plots of exact vs Numerical
figure
pn = [P,U];
TRn = triangulation(tri,pn);
pe = [P,exact];
TRe = triangulation(tri,pe);
subplot(1,2,1)
 trisurf(TRn)
 title('Numerical')
 subplot(1,2,2)
 trisurf(TRe)
 title('exact')