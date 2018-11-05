function I=quadrature3D ( p1, p2 , p3 , p4 , Nq , g)
%Calculating Jacobian matrix 
%p1,p2,p3 with small p represent the coordinates whereas,
%P(i) capital P represents Gaussian weight
J=[p1(1)-p4(1),p2(1)-p4(1),p3(1)-p4(1);
   p1(2)-p4(2),p2(2)-p4(2),p3(2)-p4(2);
   p1(3)-p4(3),p2(3)-p4(3),p3(3)-p4(3)];

K=abs(det(J))/6;

%Choise of point rule want to use i.e 1 point, 3 point or 4 point
if Nq==1
lambda1=[1/4,1/4,1/4,1/4];
X1=lambda1(1)*p1+lambda1(2)*p2+lambda1(3)*p3+lambda1(4)*p4;
P(1)=1;
x(1)=X1(1);
y(1)=X1(2);
z(1)=X1(3);

elseif Nq==4
    lambda1=[0.5854102, 0.1381966, 0.1381966, 0.1381966];
X1=lambda1(1)*p1+lambda1(2)*p2+lambda1(3)*p3+lambda1(4)*p4;
P(1)=0.25;
x(1)=X1(1);
y(1)=X1(2);
z(1)=X1(3);
lambda2=[0.1381966, 0.5854102, 0.1381966, 0.1381966];
X2=lambda2(1)*p1+lambda2(2)*p2+lambda2(3)*p3+lambda2(4)*p4;
P(2)=0.25;
x(2)=X2(1);
y(2)=X2(2);
z(2)=X2(3);
lambda3=[0.1381966, 0.1381966, 0.5854102, 0.1381966];
X3=lambda3(1)*p1+lambda3(2)*p2+lambda3(3)*p3+lambda3(4)*p4;
P(3)=0.25;
x(3)=X3(1);
y(3)=X3(2);
z(3)=X3(3);
    lambda4=[0.1381966, 0.1381966, 0.1381966, 0.5854102];
X4=lambda4(1)*p1+lambda4(2)*p2+lambda4(3)*p3+lambda4(4)*p4;
P(4)=0.25;
x(4)=X4(1);
y(4)=X4(2);
z(4)=X4(3);

elseif Nq==5
lambda1=[1/4, 1/4, 1/4, 1/4];
X1=lambda1(1)*p1+lambda1(2)*p2+lambda1(3)*p3+lambda1(4)*p4;
P(1)=-4/5;
x(1)=X1(1);
y(1)=X1(2);
z(1)=X1(3);
    lambda2=[1/2, 1/6, 1/6, 1/6];
X2=lambda2(1)*p1+lambda2(2)*p2+lambda2(3)*p3+lambda2(4)*p4;
P(2)=9/20;
x(2)=X2(1);
y(2)=X2(2);
z(2)=X2(3);
lambda3=[1/6, 1/2, 1/6, 1/6];
X3=lambda3(1)*p1+lambda3(2)*p2+lambda3(3)*p3+lambda3(4)*p4;
P(3)=9/20;
x(3)=X3(1);
y(3)=X3(2);
z(3)=X3(3);
lambda4=[1/6, 1/6 , 1/2, 1/6];
X4=lambda4(1)*p1+lambda4(2)*p2+lambda4(3)*p3+lambda4(4)*p4;
P(4)=9/20;
x(4)=X4(1);
y(4)=X4(2);
z(4)=X4(3);
lambda5=[1/6, 1/6 , 1/6, 1/2];
X5=lambda5(1)*p1+lambda5(2)*p2+lambda5(3)*p3+lambda5(4)*p4;
P(5)=9/20;
x(5)=X5(1);
y(5)=X5(2);
z(5)=X5(3);
else
    disp('Enter from 1,4 or 5')
end

for i=1:Nq
    
    T(i)=K*P(i)*g(x(i),y(i),z(i));   
end
I=sum(T);