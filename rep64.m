% Define transfer function G1(s)
num = 1;
den = [1 9 36 84 126 126 84 36 9 1];
G1 = tf(num, den);

% Define Ku and Tu (فرضی)
Ku = 1.0;
Tu = 1.0;

% Controllers
Kp_P = 0.5 * Ku;
Kp_PI = 0.4 * Ku;
Ti_PI = 0.8 * Tu;
Kp_PID = 0.6 * Ku;
Ti_PID = 0.5 * Tu;
Td_PID = 0.125 * Tu;

% Define controllers
P = Kp_P;
PI = Kp_PI * tf([Ti_PI 1], [Ti_PI 0]);
PID = Kp_PID * tf([Td_PID*Ti_PID Ti_PID 1], [Ti_PID 0]);

% Closed-loop systems
sys_P = feedback(P*G1, 1);
sys_PI = feedback(PI*G1, 1);
sys_PID = feedback(PID*G1, 1);

% Disturbance
t = 0:0.1:50;
disturbance = -1 * (t >= 15);

% Response to step disturbance
figure;
subplot(3,1,1);
lsim(sys_P, disturbance, t);
title('P Controller with Disturbance');
grid on;

subplot(3,1,2);
lsim(sys_PI, disturbance, t);
title('PI Controller with Disturbance');
grid on;

subplot(3,1,3);
lsim(sys_PID, disturbance, t);
title('PID Controller with Disturbance');
grid on;

% Performance metrics with disturbance
info_P = stepinfo(sys_P);
info_PI = stepinfo(sys_PI);
info_PID = stepinfo(sys_PID);

ess_P = abs(1 - dcgain(sys_P));
ess_PI = abs(1 - dcgain(sys_PI));
ess_PID = abs(1 - dcgain(sys_PID));

% Display performance
disp('Performance Metrics with Disturbance:');
disp(['P Controller: Tr = ', num2str(info_P.RiseTime), ', Ts = ', num2str(info_P.SettlingTime), ', PO = ', num2str(info_P.Overshoot), ', ESS = ', num2str(ess_P)]);
disp(['PI Controller: Tr = ', num2str(info_PI.RiseTime), ', Ts = ', num2str(info_PI.SettlingTime), ', PO = ', num2str(info_PI.Overshoot), ', ESS = ', num2str(ess_PI)]);
disp(['PID Controller: Tr = ', num2str(info_PID.RiseTime), ', Ts = ', num2str(info_PID.SettlingTime), ', PO = ', num2str(info_PID.Overshoot), ', ESS = ', num2str(ess_PID)]);
