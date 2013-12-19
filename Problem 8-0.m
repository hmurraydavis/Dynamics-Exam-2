function E2_Q8()   
    phi_0 = 30 * pi/180; % initial phi value = 30 degrees, convert to rad
    r0 = 800.0; % length of pendulum arm in m
    theta_dot_0 = 6/ (sin(phi_0)*r0);   % velocity component in theta direction = 0.5 m/s
    
    
    %% Define state variables: z1 = phi, z2 = d(phi)/dt, z3 = theta, z4 = d(theta)/dt
    % Specify initial conditions
    z1_0 = phi_0;  %phi
    z2_0 = 40; %phi dot
    z3_0 = 30;    %theta
    z4_0 = theta_dot_0; %theta dot
    z5_0 =r0; %initial spring length
    z6_0=100; %initial spring acceleration
    d=.8; %m, arm length of the spining column, constant
    omega=.5; %rad/sec
    Rx=[]; Ry=[]; Rz=[];
%%
    Z_0 = [z1_0, z2_0, z3_0, z4_0, z5_0, z6_0, -d*sin(omega), d*cos(omega), 0,0, 0,0,0];
    t_span = [0:0.01:10];  %time span for simulation function E2_Q8()   
    phi_0 = 30 * pi/180; % initial phi value = 30 degrees, convert to rad
    r0 = 800.0; % length of pendulum arm in m
    theta_dot_0 = 6/ (sin(phi_0)*r0);   % velocity component in theta direction = 0.5 m/s
        
    %% Define state variables: z1 = phi, z2 = d(phi)/dt, z3 = theta, z4 = d(theta)/dt
    % Specify initial conditions
    z1_0 = phi_0;  %phi
    z2_0 = 40; %phi dot
    z3_0 = 30;    %theta
    z4_0 = theta_dot_0; %theta dot
    z5_0 =r0; %initial spring length
    z6_0=100; %initial spring acceleration
    d=.8; %m, arm length of the spining column, constant
    omega=.5; %rad/sec
    Rx=[]; Ry=[]; Rz=[];
%%
    Z_0 = [z1_0, z2_0, z3_0, z4_0, z5_0, z6_0, -d*sin(omega), d*cos(omega), 0,d, 0,0,0];
    t_span = [0:0.01:10];  %time span for simulation 
    [time, zout] = ode45(@sphpend_fun, t_span, Z_0);
%%
    function states = sphpend_fun(T, ZZ) %all phi = 0 b/c planar spring pendulum
        %% ICs:
        g = -9.81; % gravitational acceleration in m/s^2
        m = 3.0; % mass = 3.0 kg, assume rod has neglible mass
        k=9800; %spring constant
        lo=400; 
        
        %Extract positions and velocities from incoming integrated vector
       
        rd=ZZ(6); pd=ZZ(2); td=ZZ(4);
        r= ZZ(5); p=ZZ(1); t=ZZ(3);
        
        %velocity eqs for spring pendulum without rotation:
        z1 = 0; %phi dot
        z3 = td; %theta dot
        z5= rd;%r dot
        
        %acceleration eqs for spring pendulum without rotation:
        z2=0; %phi dd
        z4=(-2*rd*td/r) - (2*pd*td*cos(p)/sin(p)); %theta dd
        z6=(g*cos(p)/m) - (k*(r-lo)/m) + (r*pd^2) + (r*td^2*sin(p)^2); %r dd
        
        %acceleration of the center spining arm, should be circular
        axc=ZZ(9)-d*sin(omega*.01); ayc=ZZ(10)+d*cos(omega*.01);
        %position of the center, spinning arm:
        angvel=omega;
        ang=ZZ(7);
        pxc=-d*sin( ang + omega*.01); pyc=d*cos( ang + omega*.01);
        %velocities of the center, spinning arm:
        vxc=ZZ(7); vyc=ZZ(8);

        
        rps=r*sin(t); %projection of spring onto the x-y plane
        psx=rps*pxc/(pxc+pyc); psy=rps*pyc/(pxc+pyc);
        psz=r*cos(t);
        Rx=[Rx,psx+pxc]; Ry=[Ry,psy+pyc]; Rz=[Rz,psz];

        states = [z1;z2;z3;z4;z5;z6; angvel;ayc; vxc;vyc; psx;psy;psz];
    end

    
    TtSpan=linspace(0,time(length(time)),length(Rx));
%     whos Rx Ry Rz TtSpan

    min(Ry)
    max(Ry)
    plot3(Rx,Ry,Rz)
    xlabel('x')
    ylabel('y')
    zlabel('z')

end
    [time, zout] = ode45(@sphpend_fun, t_span, Z_0);
%%
    function states = sphpend_fun(T, ZZ) %all phi = 0 b/c planar spring pendulum
        %% ICs:
        g = -9.81;              % gravitational acceleration in m/s^2
        m = 3.0;               % mass = 3.0 kg, assume rod has neglible mass
        k=9800; %spring constant
        lo=400; 
        
        %Extract positions and velocities from incoming integrated vector
       
        rd=ZZ(6); pd=ZZ(2); td=ZZ(4);
        r= ZZ(5); p=ZZ(1); t=ZZ(3);
        
        %velocity eqs for spring pendulum without rotation:
        z1 = 0; %phi dot
        z3 = td; %theta dot
        z5= rd;%r dot
        
        %acceleration eqs for spring pendulum without rotation:
        z2=0; %phi dd
        z4=(-2*rd*td/r) - (2*pd*td*cos(p)/sin(p)); %theta dd
        z6=(g*cos(p)/m) - (k*(r-lo)/m) + (r*pd^2) + (r*td^2*sin(p)^2); %r dd
        
        %acceleration of the center spining arm, should be circular
        axc=-d*sin(omega); ayc=d*cos(omega);
        %velocities of the center, spinning arm:
        vxc=ZZ(7); vyc=ZZ(8);
        %position of the center, spinning arm:
        pxc=ZZ(9); pyc=ZZ(10);
        
        rps=r*sin(t); %projection of spring onto the x-y plane
        psx=rps*pxc/(pxc+pyc); psy=rps*pyc/(pxc+pyc);
        psz=r*cos(t);
            Rx=[Rx,psx+pxc]; Ry=[Ry,psy+pyc]; Rz=[Rz,psz];

        states = [z1;z2;z3;z4;z5;z6; axc;ayc; vxc;vyc; psx;psy;psz];
    end

    
    TtSpan=linspace(0,time(length(time)),length(Rx));
    whos Rx Ry Rz TtSpan
    min(Rz)
    max(Rx)
    plot3(Rx,Ry,Rz)
    xlabel('x')
    ylabel('y')
    zlabel('z')

end
