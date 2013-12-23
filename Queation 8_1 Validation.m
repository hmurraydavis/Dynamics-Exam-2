function E2_Q8()      
    %% Specify initial conditions
    z1_0 = pi/5;    %theta
    z2_0 = 1.6; %theta dot
    z3_0 =4; %initial spring length
    z4_0=.2; %initial spring acceleration
    d=0; %m, arm length of the spining column, constant
    omega=0; %rad/sec
%%
    tddA=[];tdA=[];
    Z_0 = [z3_0, z4_0, z1_0, z2_0]; %z1 = ld,ldd,td,tdd
    t_span = [0:0.004:15];  %time span for simulation 
    [time, zout] = ode45(@sphpend_fun, t_span, Z_0);
    
   
%%
    function states = sphpend_fun(T, ZZ) %all phi = 0 b/c planar spring pendulum
        %% ICs:
        g = 9.81; % gravitational acceleration in m/s^2
        m = 1; % mass = 3.0 kg, assume rod has neglible mass
        k=2; %N/m, spring constant
        lo=1; %m 
        
        %Extract positions and velocities from incoming integrated vector
        ld=0; td=ZZ(4);
        l=9; t=ZZ(3);
        
        ldd=0;%( ((k*(lo-l)-m*g*cos(t))/m) +(2*ld^2)+(l*ld^2)+(ld) )/(-l);
        T1=(ld);
        tdd=( -g*sin(t)); %+d*omega^2*cos(t)-2*omega*ld-2*omega*l*ld-omega*l)/-l;
        
        tddA=[tddA,tdd];
        tdA=[tdA,td];

        states = [ld;ldd; td;tdd];
    end

      plot(tddA, 'r')
      figure;
      plot(tdA, 'c')
      figure;
      plot(time, zout(:,3),'LineWidth',2.5)
      xlabel('Time (s)', 'FontSize', 16)
      ylabel('Angle (rad)','FontSize', 16)
      title('Theta over Time','FontSize', 20)


%     figure;
%     plot(time, zout(:,1),'m','LineWidth',2.5)
%     xlabel('Time (s)', 'FontSize', 16)
%     ylabel('Length Spring (m)','FontSize', 16)
%     title('Spring Length over Time','FontSize', 20)
% 
%     figure;
%     plot(time, zout(:,3),'LineWidth',3)
%     xlabel('Time (s)', 'FontSize', 16)
%     ylabel('Angle (rad)','FontSize', 16)
%     title('Theta over Time','FontSize', 20)
end
