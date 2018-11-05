clear

N=2;
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
 

%Displyaing Vertices
triplot(TR)
hold on
vxlabels = arrayfun(@(n) {sprintf('V%d', n)}, (1:length(X))');
Hpl = text(X, Y, vxlabels, 'FontWeight', 'bold', 'HorizontalAlignment',...
   'center', 'BackgroundColor', 'none');
ic = incenter(TR);
numtri = size(TR,1);
trilabels = arrayfun(@(x) {sprintf('K%d', x)}, (1:numtri)');
Htl = text(ic(:,1), ic(:,2), trilabels, 'FontWeight', 'bold', ...
   'HorizontalAlignment', 'center', 'Color', 'blue');



%Initial Values
S=zeros(length(P));
M=zeros(length(P));
F=zeros(length(P),1);


%Defining F
f = @(x,y) (2*pi^2 + 1)*cos(pi*x)*sin(pi*y); 
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
    %Setting up the right hand side
    
    Fk = getrhs(v1',v2',v3',f)*det(J)/2;
    
   %Transporting local matrix to the global matrix
    S(tri(i,:),tri(i,:)) = S(tri(i,:),tri(i,:)) + Ak;
    M(tri(i,:),tri(i,:)) = M(tri(i,:),tri(i,:)) + Mk;
    F(tri(i,:),1) = F(tri(i,:),1) + Fk;
          clear Ak Fk Mk;
end

%Implementing the Boundary Conditions
A =S+M;
%Finding boundary nodes for Dirichlet Left and Right
boundary = freeBoundary(TR);
p=[boundary(1:n+1,1);boundary(2*n+1:3*n+1,1)];
for i=1:length(p)
    S(p(i,1),:)=0;
    S(p(i,1),p(i,1))=1;
    M(p(i,1),:)=0;
    M(p(i,1),p(i,1))=1;
    F(p(i,1))=0;
end

%Solution
MS = M\(S);
MF = M\F;
dt = 1e-4;
sizet = length(0:dt:1);
U = zeros(length(S),sizet);
tol = 1e-9;
%Initial Condition
U(:,1)=sin(X.*cos(pi/4)+Y.*sin(pi/4));
for stp=1:sizet+1
    %     U(:,stp+1) = U(:,stp) + dt*(-MS*U(:,stp)); %Forward Euler
    e = 1.;
    U1 = zeros(length(S),1);
    while e>tol
    U2 = U(:,stp) + dt*(-MS*U1) ;
    U1 = U2;
    e = norm(U2 - U(:,stp) - dt*(-MS*U2 ));
    end   
    U(:,stp+1) = U2;
    clear U1 U2,
end




%exact Solution
t=0:dt:1;
exact = exp(-t).*sin(X.*cos(pi/4)+Y.*sin(pi/4));
%Error


%% plots

%Plots of exact vs Numerical
figure
pn = [P,U(:,41)];
TRn = triangulation(tri,pn);

pe = [P,exact(:,41)];
TRe = triangulation(tri,pe);

subplot(1,2,1)
 trisurf(TRn)

title('Numerical Solution')
  
subplot(1,2,2)
 
trisurf(TRe);
 
 title('Exact Solution')
