% محاسبه پارامترهای کنترل‌کننده P
a = T / L;
Kp_P = 1 / a;

% تعریف کنترل‌کننده P
P_controller = Kp_P;

% محاسبه پارامترهای کنترل‌کننده PI
Kp_PI = 0.9 / a;
Ti_PI = 3 * L;

% تعریف کنترل‌کننده PI
PI_controller = Kp_PI * (1 + tf([1], [Ti_PI, 0]));

% محاسبه پارامترهای کنترل‌کننده PID
Kp_PID = 1.2 / a;
Ti_PID = 2 * L;
Td_PID = L / 2;

% تعریف کنترل‌کننده PID
PID_controller = Kp_PID * (1 + tf([1], [Ti_PID, 0]) + tf([Td_PID, 0], [1]));
