%ECE183DA_JointLab2_ActuatorSimulation
%
%Purpose:
%The purpose of this code it to simulate our system's actuator response
%to a set of predefined inputs and compare it with the SolidWorks
%simulation done by our MAE counterparts
%
%Input:
%   1. Left Wheel Angular Velocity
%   2. Right Wheel Angular Velocity
%

%Identify the simulation parameters needed
d = 0.05; %0.502; %diameter of wheel
w = 0.09; %0.53; %width of robot

%Next, make sure at this point the Solidwork simulation data is already
%imported. Name them:
%   omega_SW = angular velocity
%   theta_SW = angular displacement
%   time = time step between each input
%   wL = left wheel angular velocity (input 1)
%   wR = right wheel angular velocity (input 2)
%   x_SW = x position of the robot
%   y_SW = y position of the robot

%Since the input simulated in the solidworks is slightly different in terms
%of orientation and units, we need to make sure to adjust it in order to
%fit our mathematical formulation from Joint Lab 1.

omega_SW_adjusted = omega_SW; % (-pi/180)*omega_SW; %deg/s to rad/s
theta_SW_adjusted = zeros(1,length(theta_SW));
for j = 1:1:length(theta_SW)
    if (theta_SW(j) <= 0)
        theta_SW_adjusted(j) = -(pi/180)*theta_SW(j);
    else
        theta_SW_adjusted(j) = 2*pi - (pi/180)*theta_SW(j);
    end
end
wL_adjusted = wL; %(-pi/180)*wL; %deg/s to rad/s
wR_adjusted = wR; %(-pi/180)*wR; %deg/s to rad/s

%Next, let's start our analytical simulation using the same input from the
%Solidworks simulation. To start, we create a placeholders for our
%simulation and define the initial states
omega_ML = ones(1,length(wL));
omega_ML(1) = omega_SW_adjusted(1);
theta_ML = ones(1,length(wL));
theta_ML(1) = theta_SW_adjusted(1);
x_ML = ones(1,length(wL));
x_ML(1) = x_SW(1);
y_ML = ones(1,length(wL));
y_ML(1) = y_SW(1);

for k = 2:1:length(wL)
    delta_t = time(k) - time(k-1);
    [x_ML(k), y_ML(k), theta_ML(k),omega_ML(k)] = ...
          actuator(wL_adjusted(k), wR_adjusted(k), x_ML(k-1), ...
          y_ML(k-1), theta_ML(k-1), delta_t,d,w); 
end

figure(1)
plot(time,x_ML,time,x_SW)
title('x State Trajectory over Time');
xlabel('time'); ylabel('x (m)')
legend('ML','SW')

figure(2)
plot(time,y_ML,time,y_SW)
title('y State Trajectory over Time');
xlabel('time'); ylabel('y (m)')
legend('ML','SW')

figure(3)
plot(time,theta_ML,time,theta_SW_adjusted)
title('theta State Trajectory over Time');
xlabel('time'); ylabel('theta (rad)')
legend('ML','SW')

figure(4)
plot(time,omega_ML,time,omega_SW_adjusted)
title('omega State Trajectory over Time');
xlabel('time'); ylabel('omega (rad/s)')
legend('ML','SW')
