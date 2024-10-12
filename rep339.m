
Kp = 2;
Ti = 3;
Td = 1;
Ki = Kp / Ti;
Kd = Kp * Td;
num = 1;
den = [1, 3, 4, 2]; % Transfer function denominator coefficients
G = tf(num, den);

C_PID = pid(Kp, Ki, Kd);

G_closed = feedback(series(C_PID, G), 1);

t_disturbance = 40; % Time when disturbance occurs
disturbance_amplitude = -1; % Magnitude of the disturbance

t = 0:0.01:50; % Time vector for simulation
disturbance = disturbance_amplitude * (t >= t_disturbance); % Step disturbance at t_disturbance

[y, ~, x] = lsim(G_closed, disturbance, t);

figure;
plot(t, y);
title('Step Response of Closed-loop System with Unknown Step Disturbance');
xlabel('Time');
ylabel('Response');
grid on;
