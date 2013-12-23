m=12;
a=.3; b=.4;

I11=m*a^2/12; I22=m*b^2/12; I33=m*(a^2+b^2)/12;
IB=[I11,0,0;0,I22,0;0,0,I33];
t=atan(15/20);
R=[cos(t),-sin(t),0;sin(t),cos(t),0;0,0,1];
I=R*IB*(inv(R));
omega=1000;
l=40;
I(3,1);

Fbz=omega^2*I(1,2)/l/-2
Faz=(-2*omega*I(1,2)+omega^2*I(1,2))/l/-2
Fby=(omega^2*I(1,2)+l*m)/2/l
Fay=(omega^2*I(1,2)-Fby*l)/-l
