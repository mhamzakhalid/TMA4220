function rhs = getrhs (p1 ,p2 ,p3,g )

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

lambda3=[3/5,1/5,1/5];
X3=lambda3(1)*p1+lambda3(2)*p2+lambda3(3)*p3;
P(3)=25/48;
x(3)=X3(1);
y(3)=X3(2);

lambda4=[1/5,1/5,3/5];
X4=lambda4(1)*p1+lambda4(2)*p2+lambda4(3)*p3;
P(4)=25/48;
x(4)=X4(1);
y(4)=X4(2);

for i=1:4
    T(i)=P(i)*g(x(i),y(i));    
end
  rhs =T(1)*lambda1' +T(2)*lambda2' +T(3)*lambda3' +T(4)*lambda4';
end