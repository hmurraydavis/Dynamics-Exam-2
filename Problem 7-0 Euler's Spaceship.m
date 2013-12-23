function E2_Q7()

    Z=[pi/2,0,0,.1,-.2,.5]; %[theta,phi,psi,wx,wy,wx]
    
    t_span = [0:0.01:35];  %time span for simulation 
    [time, zout] = ode45(@sphpend_fun, t_span, Z);
  
    function states = sphpend_fun(T, ZZ)
        phi=ZZ(2); theta=ZZ(1); psi=ZZ(3);
        w01_02=[ZZ(4);ZZ(5);ZZ(6)];
        r1_313 = [ cos(phi)  sin(phi)  0; -sin(phi) cos(phi) 0; 0  0  1];
        r2_313 = [ 1  0  0; 0  cos(theta)  sin(theta);  0  -sin(theta)  cos(theta)  ];
        r3_313 = [ cos(psi)  sin(psi)  0;  -sin(psi)  cos(psi)  0; 0  0  1];

        r_313 = r2_313*r1_313;
        
        derivmtx=[sin(phi)/sin(theta),cos(phi)/sin(theta),0; 
            cos(phi),-sin(phi),0; 
            -cos(phi)/sin(theta),-cos(theta)*cos(phi)/sin(theta),1];

        I02=[4000,0,0;0,7500,0;0,0,8500];

        w01_02dot=(I02^-1)*(cross(-w01_02, (I02*w01_02)));
        angledot=derivmtx*w01_02;
        
        states=[angledot(2);angledot(1);angledot(3);w01_02dot(1);w01_02dot(2);w01_02dot(3)];
    end

    plot(time,zout(:,1),'LineWidth',3)
    xlabel('Time (s)', 'FontSize', 16)
    ylabel('Angle (rad)','FontSize', 16)
    title('Theta over Time','FontSize', 20)
    
    figure;
    plot(time,zout(:,2), 'r','LineWidth',3)
    xlabel('Time (s)', 'FontSize', 16)
    ylabel('Angle (rad)','FontSize', 16)
    title('Phi over Time','FontSize', 20)
    
    figure;
    plot(time,zout(:,3),'c','LineWidth',3)
    xlabel('Time (s)', 'FontSize', 16)
    ylabel('Angle (rad)','FontSize', 16)
    title('Psi over Time','FontSize', 20)
    
    figure;
    plot(time,zout(:,4),'m','LineWidth',3)
    xlabel('Time (s)', 'FontSize', 16)
    ylabel('Velocity (rad/sec)','FontSize', 16)
    title('Velocity in Theta over time','FontSize', 20)
    
    figure;
    plot(time,zout(:,5),'g','LineWidth',3)
    xlabel('Time (s)', 'FontSize', 16)
    ylabel('Velocity (rad/sec)','FontSize', 16)
    title('Velocity in Phi over time','FontSize', 20)
    
    figure;
    plot(time,zout(:,6),'y','LineWidth',3)
    xlabel('Time (s)', 'FontSize', 16)
    ylabel('Velocity (rad/sec)','FontSize', 16)
    title('Velocity in Psi over time','FontSize', 20)
    
end
