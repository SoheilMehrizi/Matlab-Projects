% تعریف تابع تبدیل سیستم حلقه باز
numerator = 1;
denominator = [1 3 4 2];
G = tf(numerator, denominator);

% تعریف کنترل‌کننده تناسبی با بهره K
K = 2; % مقدار K را می‌توان تغییر داد
P_controller = K;

% ایجاد سیستم حلقه بسته با فیدبک واحد
closed_loop_system = feedback(P_controller * G, 1);

% شبیه‌سازی پاسخ سیستم به ورودی پله واحد
figure;
step(closed_loop_system);
title('Closed-Loop Step Response with Proportional Controller');
grid on;
