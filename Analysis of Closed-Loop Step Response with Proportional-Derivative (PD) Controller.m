% تعریف پارامترهای کنترل‌کننده PD
Kp = 10;
Kd = 1;

% تعریف تابع تبدیل سیستم باز
num = 1;
den = [1 3 4 2];
G = tf(num, den);

% تعریف تابع تبدیل کنترل‌کننده PD
C = tf([Kd Kp], 1);

% تشکیل تابع تبدیل حلقه باز سیستم با کنترل‌کننده
G_open = series(C, G);

% تشکیل تابع تبدیل حلقه بسته با فیدبک واحد
G_closed = feedback(G_open, 1);

% رسم پاسخ پله سیستم حلقه بسته
step(G_closed)
title('Closed-Loop Step Response with PD Controller')
grid on
