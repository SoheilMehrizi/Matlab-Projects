% Define transfer function G2(s)
num = 1;
den = [1 9 36 84 126 126 84 36 9 1]; % corresponds to (1+s)^9
G2 = tf(num, den);

% فرضی: مقادیر K_u و T_u
Ku = 1.0; % مقدار فرضی
Tu = 1.0; % مقدار فرضی

% کنترل‌کننده‌ها بر اساس روش زیگلر-نیکولز
Kp_P = 0.5 * Ku;

Kp_PI = 0.4 * Ku;
Ti_PI = 0.8 * Tu;

Kp_PID = 0.6 * Ku;
Ti_PID = 0.5 * Tu;
Td_PID = 0.125 * Tu;

% تعریف کنترل‌کننده‌ها
P = Kp_P;
PI = Kp_PI * tf([Ti_PI 1], [Ti_PI 0]);
PID = Kp_PID * tf([Td_PID*Ti_PID Ti_PID 1], [Ti_PID 0]);

% سیستم‌های حلقه بسته
sys_P = feedback(P*G2, 1);
sys_PI = feedback(PI*G2, 1);
sys_PID = feedback(PID*G2, 1);

% پاسخ پله
figure;
subplot(3,1,1);
step(sys_P);
title('P Controller');
grid on;

subplot(3,1,2);
step(sys_PI);
title('PI Controller');
grid on;

subplot(3,1,3);
step(sys_PID);
title('PID Controller');
grid on;

% تحلیل عملکرد
info_P = stepinfo(sys_P);
info_PI = stepinfo(sys_PI);
info_PID = stepinfo(sys_PID);

ess_P = abs(1 - dcgain(sys_P));
ess_PI = abs(1 - dcgain(sys_PI));
ess_PID = abs(1 - dcgain(sys_PID));

% نمایش ویژگی‌های عملکرد
disp('ویژگی‌های عملکرد:');
disp(['P Controller: Tr = ', num2str(info_P.RiseTime), ', Ts = ', num2str(info_P.SettlingTime), ', PO = ', num2str(info_P.Overshoot), ', ESS = ', num2str(ess_P)]);
disp(['PI Controller: Tr = ', num2str(info_PI.RiseTime), ', Ts = ', num2str(info_PI.SettlingTime), ', PO = ', num2str(info_PI.Overshoot), ', ESS = ', num2str(ess_PI)]);
disp(['PID Controller: Tr = ', num2str(info_PID.RiseTime), ', Ts = ', num2str(info_PID.SettlingTime), ', PO = ', num2str(info_PID.Overshoot), ', ESS = ', num2str(ess_PID)]);
