thetaclear;clc;
a=[300 700 185 0 0 0];
d=[600 0 0 830 0 120];
alfa=[90 0 0 0 0 0];
theta=[90 -90 65 90 -90 90];
F=[a(:),alfa(:),d(:),theta(:)];  
B=eye(4);
for i=1:length(theta)
    T=[cos(F(i,4)) -sin(F(i,4)).*cos(F(i,2)) sin(F(i,4)).*sin(F(i,2)) F(i,1).*cos(F(i,4));
             sin(F(i,4)) cos(F(i,4)).*cos(F(i,2)) -cos(F(i,4)).*sin(F(i,2)) F(i,1).*sin(F(i,4));
             0 sin(F(i,2)) cos(F(i,2)) F(i,3);
             0 0 0 1];
         B=B*T;
end
    
R=B(1:3,1:3);
d=B(1:3,4);
z=R*d
    