function [x_next, y_next, theta_next, vtheta_next] = actuator(ul, ur, x, y, theta, t,d,w)
    
    %Define the state space equation
    ydot = 0.25*d*cos(theta)*ul + 0.25*d*cos(theta)*ur;
    xdot = 0.25*d*sin(theta)*ul + 0.25*d*sin(theta)*ur;
    thetadot = (d/(2*w))*ul - (d/(2*w))*ur;
    
    
    %Calculate the next state
    x_next = xdot*t + x;
    y_next = ydot*t + y;
    theta_next = mod(thetadot*t + theta,2*pi);
    vtheta_next = thetadot;
    
end
