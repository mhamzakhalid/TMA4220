clear
n=3;
% Returns uniform triangulation of unit square
[X,Y] = meshgrid(0:1/n:1,0:1/n:1);
X = reshape(X,[],1);
Y = reshape(Y,[],1);
% we have a vector of X- and Y- coordinates of our vertices
P = [X,Y];
tri = delaunay(X,Y);
TR = triangulation(tri,P);
triplot(TR)
A=zeros(length(P));
M=zeros(length(P));
F=zeros(length(P),1);

%setting up the connectivity matrix
con = zeros(length(tri),3);
con(:,1:3) = tri(:,1:3);

%Defining F
f = @(x,y) (2*pi^2 + 1)*cos(pi*x)*sin(pi*x); 
%Barycentric coordinates
%Add them
Phi = [eye(2),-ones(2,1)];

for i=1:length(tri)
    J= [P(tri(i,1),:)'-P(tri(i,3),:)',P(tri(i,2),:)'-P(tri(i,3),:)'];
    G=J\Phi;
    %Setting up the stiffness matrix
    Ak=abs(det(J))*(G'*G)/2 ;
    A(tri(i,:),tri(i,:))= A(tri(i,:),tri(i,:))+Ak;
    %Setting up the mass Matrix
    for mj=1:3
        for mi=1:3
            if mi==mj && mi==1
                
                g = @(xhat,yhat) xhat*xhat;
            elseif mi==mj && mi==2
                 
                g = @(xhat,yhat) yhat*yhat;
            elseif mi==mj && mi==3
                
                g = @(xhat,yhat) (1-xhat-yhat)*(1-xhat-yhat);
            elseif (mj==mi+1 && mj==2 )|| (mj==mi-1 && mj==1)
               
                g = @(xhat,yhat) (yhat)*(xhat);
            elseif (mj==mi+1 && mj==3 )|| (mj==mi-1 && mj==2)
                
                g = @(xhat,yhat) (1-xhat-yhat)*(yhat);
            else 
                g = @(xhat,yhat) (1-xhat-yhat)*(xhat);
            end
            Mk(mj,mi) = abs(det(J))*quadrature2D (P(tri(i,1),:), P(tri(i,2),:), P(tri(i,3),:),4,g);
        end
    end
    %Setting up the right hand side(NOT SURE ABOUT DET OF J)
            Fk =abs(det(J))*quadrature2D (P(tri(i,1),:), P(tri(i,2),:), P(tri(i,3),:),4,f);
   %Transporting local matrix to the global matrix
            M(tri(i,:),tri(i,:)) = M(tri(i,:),tri(i,:))+Mk;
            F(tri(i,:),1) = F(tri(i,:),1) + Fk;
          
end
%Implementing the Boundary Conditions
%% 
%BOUNDARY CONDITONS HAVE NOT BEEN IMPLEMENTED WORK ON CREATING EDGES AND
%APPLYING Dirichlet there
%
%% Solution
U = gmres(A,F);

% for j=1:length(U)
% fprintf('V:%d -> %f\n',j,U(j));
% end
exact = cos(pi*X).*sin(pi*Y);

error = norm(U - exact);