% Define transfer function G2(s)
num = 1;
den = [1 9 36 84 126 126 84 36 9 1]; % corresponds to (1+s)^9
G2 = tf(num, den);

% فرضی: مقادیر K_u و T_u
Ku = 1.0; % مقدار فرضی
Tu = 1.0; % مقدار فرضی

% P Controller
Kp_P = 0.5 * Ku;

% PI Controller
Kp_PI = 0.4 * Ku;
Ti_PI = 0.8 * Tu;

% PID Controller
Kp_PID = 0.6 * Ku;
Ti_PID = 0.5 * Tu;
Td_PID = 0.125 * Tu;

% نمایش مقادیر کنترل‌کننده‌ها
disp('P Controller:');
disp(['Kp = ', num2str(Kp_P)]);

disp('PI Controller:');
disp(['Kp = ', num2str(Kp_PI), ', Ti = ', num2str(Ti_PI)]);

disp('PID Controller:');
disp(['Kp = ', num2str(Kp_PID), ', Ti = ', num2str(Ti_PID), ', Td = ', num2str(Td_PID)]);
