%% MAE 162D Trajectory Generatior %%
clc;
clear all

%% Initialize %%
w_max = 300*pi/180; %[rad/s]
t_max = 5; %[s]
dt = .25; %[s]
Dt = .01;

t = 0:dt:5; %[s]
w_L = zeros(length(t),1);
w_R = w_L;

%% Compute Random Trajectories

for j = 1:50
    
    for i = 2:length(w_L)
        
        w_L(i) = (2*rand - 1)*w_max;
        w_R(i) = (2*rand - 1)*w_max;
        
        if mod(i,3) == 0 && i >= 3
            
            w_L(i-1) = w_L(i-2);
            w_L(i) = w_L(i-1);
            if i > 3
                % w_R(i-1) = w_R(i-2);
                w_R(i) = w_R(i-1);
            end
            
        end
        
        
    end
    
    t_vector = 0:Dt:t_max;
    w_L_Long = interp1(t,w_L,t_vector);
    w_R_Long = interp1(t,w_R,t_vector);
    
    
    
    %% Save Into Excel %%
    Array = [t_vector', w_L_Long', w_R_Long'];
    %     Array = [{'t [s]' 'w_L [rad/s]' 'w_R [rad/s]'};num2cell(Array)];
    if j <= 9
        FileName = strcat('Trajectory0',num2str(j));
        FileName = strcat(FileName,'.csv');
        csvwrite(FileName,Array);
    else
        FileName = strcat('Trajectory',num2str(j));
        FileName = strcat(FileName,'.csv');
        csvwrite(FileName,Array);
    end
    
end

% 
% figure(1)
% title('Randomly Generated Inputs');
% plot(t_vector,w_L_Long,'LineWidth',1.25);
% hold on
% plot(t_vector,w_R_Long,'r','LineWidth',1.25);
% hold off
% yline(w_max,'k--','linewidth',1.5);
% yline(-w_max,'k--','linewidth',1.5);
% xlabel('t [s]');
% ylabel('{\omega} [rad/s]')
% legend('w_L','w_R','w_{max}','w_{min}','location','EastOutside');

