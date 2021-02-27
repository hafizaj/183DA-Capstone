L = 10;
W = 10;
N_input = 501;
x_init = ones(N_input,1);
y_init = ones(N_input,1);
theta_init = ones(N_input,1);

for k = 1:1:N_input
   x = rand*(L/2)+(L/4); 
   x_init(k) = x;
   y = rand*(W/2)+(W/4); 
   y_init(k) = y;
   theta = rand*2*pi;
   theta_init(k) = theta;
end

all_data = [x_init, y_init, theta_init];
writematrix(all_data,'InitialStates.csv')