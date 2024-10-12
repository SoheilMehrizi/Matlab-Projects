% پارامترهای کنترل‌کننده PID
Kp = 2;
Ki = 1; % باید مقدار مناسب را تنظیم کنید
Kd = 5; % باید مقدار مناسب را تنظیم کنید

% تعریف تابع تبدیل سیستم باز
num = 1;
den = [1 3 4 2];
G = tf(num, den);

% تعریف تابع تبدیل کنترل‌کننده PID
C = pid(Kp, Ki, Kd);

% تشکیل تابع تبدیل حلقه باز سیستم با کنترل‌کننده
G_open = series(C, G);

% تشکیل تابع تبدیل حلقه بسته با فیدبک واحد
G_closed = feedback(G_open, 1);

% شبیه‌سازی پاسخ پله واحد
t = 0:0.1:40; % بازه زمانی شبیه‌سازی
[y, t] = step(G_closed, t);

% رسم پاسخ پله سیستم حلقه بسته
figure;
plot(t, y, 'b', 'LineWidth', 1.5);
title(['Closed-Loop Step Response with PID Controller (Kp = ' num2str(Kp) ', Ki = ' num2str(Ki) ', Kd = ' num2str(Kd) ')']);
xlabel('Time (seconds)');
ylabel('Output');
grid on;
