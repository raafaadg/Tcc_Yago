function z = DH_Met(theta)
%%% DENAVIT HARTENBERG%%%%%%%%%%

F=[[300 700 185 0 0 0]',[600 0 0 830 0 120]',...
    [90 0 0 0 0 0]',ceil((theta(:).*42.8572)-21.4286)];  
B=eye(4);
for i=1:size(F,2)

    T=[cos(F(i,4)) -sin(F(i,4)).*cos(F(i,2)) sin(F(i,4)).*sin(F(i,2)) F(i,1).*cos(F(i,4));
             sin(F(i,4)) cos(F(i,4)).*cos(F(i,2)) -cos(F(i,4)).*sin(F(i,2)) F(i,1).*sin(F(i,4));
             0 sin(F(i,2)) cos(F(i,2)) F(i,3);
             0 0 0 1];         
    B=B*T;    
end
R=B(1:3,1:3);
d=B(1:3,4);
z=d; 
end
