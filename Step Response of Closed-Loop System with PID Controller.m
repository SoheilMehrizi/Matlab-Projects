% پارامترهای کنترل‌کننده PID
Kp = 2;
Ti = 3;
Td = 1;

% محاسبه پارامترهای کنترل‌کننده PID
Ki = Kp / Ti;
Kd = Kp * Td;

% تعریف تابع تبدیل سیستم باز
num = 1;
den = [1, 3, 4, 2];
G = tf(num, den);

% تعریف کنترل‌کننده PID
C_PID = pid(Kp, Ki, Kd);

% تعریف تابع تبدیل حلقه بسته
G_closed = feedback(series(C_PID, G), 1);

% شبیه‌سازی پاسخ پله
figure;
step(G_closed, 40);
title('Step Response of Closed-loop System (PID Controller)');
xlabel('Time');
ylabel('Amplitude');
grid on;
