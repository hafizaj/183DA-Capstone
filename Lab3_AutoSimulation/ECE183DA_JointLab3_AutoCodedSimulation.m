clear all

%Identify the simulation parameters needed
d = 0.502; %diameter of wheel
w = 0.53; %width of robot
N = 0; %angle between the absolute magnetic north and the defined y-axis
W = 10; %width of room
L = 10; %length of room
total_trajectories = 50;
init = readmatrix('InitialStates.csv');


for iter = 1:1:total_trajectories 
    init_x = init(iter,1);
    init_y = init(iter,2);
    init_theta = init(iter,3);
    init_thetadot = 0;
    
    %Extract the data from the csv file
    text1 = 'Trajectory';
    text2 = '.csv';
    if iter < 10
        char = strcat('0',int2str(iter));
    else
        char = int2str(iter);
    end
    
    all_data = readmatrix(strcat(text1,char,text2));
    t = all_data(:,1);
    wL = all_data(:,2);
    wR = all_data(:,3);
    avg_dt = 5/length(t);
    
    %Allocate the vectors for the states and observations
    N_input = length(t);
    x_ML = ones(N_input,1); x_ML(1) = init_x;
    y_ML = ones(N_input,1); y_ML(1) = init_y;
    theta_ML = ones(N_input,1); theta_ML(1) = init_theta;
    thetadot_ML = ones(N_input,1); thetadot_ML(1) = init_thetadot;
    Df_ML = ones(N_input,1);
    Dr_ML = ones(N_input,1);
    omega_ML = ones(N_input,1);
    My_ML = ones(N_input,1);
    Mx_ML = ones(N_input,1);
    
    %Finally, we simulate the system
    for k = 1:N_input-1
        [Df_ML(k),Dr_ML(k),omega_ML(k),My_ML(k),Mx_ML(k)] ...
            = sensor(x_ML(k),y_ML(k),theta_ML(k),thetadot_ML(k),N,L,W);
        [x_ML(k+1), y_ML(k+1), theta_ML(k+1),thetadot_ML(k+1)] ...
            = actuator(wL(k), wR(k), x_ML(k), y_ML(k), theta_ML(k), avg_dt,d,w);
    end
    
    %to make the graph consistent
    Df_ML(N_input) = Df_ML(N_input-1);
    Dr_ML(N_input) = Dr_ML(N_input-1);
    thetadot_ML(N_input) = thetadot_ML(N_input-1);
    My_ML(N_input) = My_ML(N_input-1);
    Mx_ML(N_input) = Mx_ML(N_input-1);
    
    %Plotting the results
    h1 = figure('visible','off');
    plot(t,x_ML); xlabel('time(s)') ; ylabel('x position(m)');
    title('X position over time based on input wL and wR');
    grid on
    text3 = strcat('/Plots and Graphs/',char,'_x','.jpg');
    saveas(h1,[pwd text3]);
    
    h2 = figure('visible','off');
    plot(t,y_ML); xlabel('time(s)') ; ylabel('y position (m)');
    title('Y position over time based on input wL and wR');
    grid on
    text3 = strcat('/Plots and Graphs/',char,'_y','.jpg');
    saveas(h2,[pwd text3]);
    
    h3 = figure('visible','off');
    plot(t,theta_ML); xlabel('time(s)') ; ylabel('theta(rad)');
    title('\theta over time based on input wL and wR');
    grid on
    text3 = strcat('/Plots and Graphs/',char,'_theta','.jpg');
    saveas(h3,[pwd text3]);
    
    h4 = figure('visible','off');
    plot(t,thetadot_ML); xlabel('time(s)') ; ylabel('angular velocity(rad/s)');
    title('xy-angular velocity over time based on input wL and wR');
    grid on
    text3 = strcat('/Plots and Graphs/',char,'_thetadot','.jpg');
    saveas(h4,[pwd text3]);
    
    h5 = figure('visible','off');
    plot(t,Df_ML); xlabel('time(s)') ; ylabel('Df(m)');
    title('front LIDAR reading over time based on input wL and wR');
    grid on
    text3 = strcat('/Plots and Graphs/',char,'_Df','.jpg');
    saveas(h5,[pwd text3]);
    
    h6 = figure('visible','off');
    plot(t,Dr_ML); xlabel('time(s)') ; ylabel('Dr(m)');
    title('right LIDAR reading over time based on input wL and wR');
    grid on
    text3 = strcat('/Plots and Graphs/',char,'_Dr','.jpg');
    saveas(h6,[pwd text3]);
    
    h7 = figure('visible','off');
    plot(t,omega_ML); xlabel('time') ; ylabel('omega (rad/s)');
    title('xy angular velocity sensor over time based on input wR and wR');
    grid on
    text3 = strcat('/Plots and Graphs/',char,'_omega','.jpg');
    saveas(h7,[pwd text3]);
    
    h8 = figure('visible','off');
    plot(t,My_ML); xlabel('time') ; ylabel('My');
    title('My over time based on input wR and wR');
    grid on
    text3 = strcat('/Plots and Graphs/',char,'_My','.jpg');
    saveas(h8,[pwd text3]);
    
    h9 = figure('visible','off');
    plot(t,Mx_ML); xlabel('time') ; ylabel('Mx');
    title('Mx over time based on input Ul and Ur');
    grid on
    text3 = strcat('/Plots and Graphs/',char,'_Mx','.jpg');
    saveas(h9,[pwd text3]);
    
    all_data = [t, thetadot_ML, theta_ML, x_ML, y_ML, ...
        Df_ML, Dr_ML, My_ML, Mx_ML,omega_ML];
    
    text1 = 'ML_Simulation';
    text2 = '.csv';
    writematrix(all_data,strcat(text1,char,text2))
end