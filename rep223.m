% تعریف تابع تبدیل سیستم حلقه باز
numerator = 1;
denominator = [1 3 4 2];
G = tf(numerator, denominator);

% بهره تناسبی ثابت
Kp = 2;

% بهره انتگرالی را به عنوان پارامتر متغیر در نظر می‌گیریم
Ki = tf([1], [1 0]);

% تابع تبدیل حلقه باز با کنترل‌کننده PI
L = (Kp + Ki) * G;

% رسم مکان هندسی ریشه‌ها
figure;
rlocus(L);
title('Root Locus of Open-Loop Transfer Function with PI Controller');
grid on;
