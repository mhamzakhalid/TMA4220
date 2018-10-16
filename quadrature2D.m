function I=quadrature2D ( p1, p2 , p3 , Nq , g)
%Calculating Jacobian matrix 
J= [p1(1)-p3(1),p2(1)-p3(1);
    p1(2)-p3(2),p2(2)-p3(2)];
K=abs(det(J))/2;
%Choise of point rule want to use i.e 1 point, 3 point or 4 point
if Nq==1
lambda1=[1/3,1/3,1/3];
X1=lambda1(1)*p1+lambda1(2)*p2+lambda1(3)*p3;
P(1)=1;
x(1)=X1(1);
y(1)=X1(2);
elseif Nq==3
    lambda1=[1/2,1/2,0];
X1=lambda1(1)*p1+lambda1(2)*p2+lambda1(3)*p3;
P(1)=1/3;
x(1)=X1(1);
y(1)=X1(2);

lambda2=[1/2,0,1/2];
X2=lambda2(1)*p1+lambda2(2)*p2+lambda2(3)*p3;
P(2)=1/3;
x(2)=X2(1);
y(2)=X2(2);

lambda3=[0,1/2,1/2];
X3=lambda3(1)*p1+lambda3(2)*p2+lambda3(3)*p3;
P(3)=1/3;
x(3)=X3(1);
y(3)=X3(2);

elseif Nq==4
    lambda1=[1/3,1/3,1/3];
X1=lambda1(1)*p1+lambda1(2)*p2+lambda1(3)*p3;
P(1)=-9/16;
x(1)=X1(1);
y(1)=X1(2);

lambda2=[3/5,1/5,1/5];
X2=lambda2(1)*p1+lambda2(2)*p2+lambda2(3)*p3;
P(2)=25/48;
x(2)=X2(1);
y(2)=X2(2);

lambda3=[1/5,3/5,1/5];
X3=lambda3(1)*p1+lambda3(2)*p2+lambda3(3)*p3;
P(3)=25/48;
x(3)=X3(1);
y(3)=X3(2);

lambda4=[1/5,1/5,3/5];
X4=lambda4(1)*p1+lambda4(2)*p2+lambda4(3)*p3;
P(4)=25/48;
x(4)=X4(1);
y(4)=X4(2);
else
    disp('Enter from 1,3 or 4')
end

for i=1:Nq
    T(i)=K*P(i)*g(x(i),y(i));
    
end
I=sum(T);
