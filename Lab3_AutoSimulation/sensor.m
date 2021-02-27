function [Df,Dr,omega,My,Mx] = sensor(x,y,theta,vtheta,N,L,W)

    My = cos(theta-N);
    Mx = sin(theta-N);
    omega = vtheta;
    
    %The Df calculation
    if (theta >= 0 && theta < pi/2)
        Df = min((W-y)/cos(theta),(L-x)/cos(0.5*pi - theta));
    elseif (theta >= pi/2 && theta < pi)
        Df = min((L-x)/cos(theta-0.5*pi),(y)/cos(pi - theta));    
    elseif (theta >= pi && theta < 3*pi/2)
        Df = min((x)/cos(1.5*pi - theta),(y)/cos(theta-pi));
    else
        Df = min((W-y)/cos(2*pi - theta),(x)/sin(2*pi - theta));
    end 
    
    %The Dr calculation
    if (theta >= 0 && theta < pi/2)
        Dr = min((L-x)/cos(theta),(y)/cos(0.5*pi - theta));
    elseif (theta >= pi/2 && theta < pi)
        Dr = min((x)/cos(theta-pi),(y)/cos(pi*0.5 - theta));    
    elseif (theta >= pi && theta < 3*pi/2)
        Dr = min((W-y)/cos(theta - 1.5*pi),(x)/cos(theta-pi));
    else
        Dr = min((W-y)/cos(theta - 1.5*pi),abs((L-x)/sin(theta-1.5*pi)));
    end 
    
end