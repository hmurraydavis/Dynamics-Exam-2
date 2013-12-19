function E2_Q8()   
    phi_0 = 30 * pi/180; % initial phi value = 30 degrees, convert to rad
    r0 = 2; % length of pendulum arm in m
    theta_dot_0 = 6/ (sin(phi_0)*r0);   % velocity component in theta direction = 0.5 m/s
        
    %% Define state variables: z1 = ld,ldd,td,tdd
    % Specify initial conditions
    z1_0 = 30;    %theta
    z2_0 = theta_dot_0; %theta dot
    z3_0 =r0; %initial spring length
    z4_0=100; %initial spring acceleration
    d=.8; %m, arm length of the spining column, constant
    omega=.5; %rad/sec
%%
    Z_0 = [z1_0, z2_0, z3_0, z4_0];
    t_span = [0:0.01:10];  %time span for simulation 
    [time, zout] = ode45(@sphpend_fun, t_span, Z_0);
%%
    function states = sphpend_fun(T, ZZ) %all phi = 0 b/c planar spring pendulum
        %% ICs:
        g = 9.81; % gravitational acceleration in m/s^2
        m = 1; % mass = 3.0 kg, assume rod has neglible mass
        k=2; %N/m, spring constant
        lo=1; %m 
        
        %Extract positions and velocities from incoming integrated vector
       
        ld=ZZ(2); td=ZZ(4);
        l=ZZ(1); t=ZZ(3);
        
        ldd=(((k*(l-lo)-m*g*cos(t))/m)+(ld^2)+(l*ld^2)+(2*ld)+(l*td))/(-l);
        tdd=(-g*sin(t)+d*omega^2*cos(t))/l;

        states = [ld;ldd; td;tdd];
    end

end
