% پارامترهای کنترل‌کننده PID
Kp = 2;
Ti = 2;
Td = 1;

% محاسبه مقادیر Ki و Kd
Ki = Kp / Ti;
Kd = Kp * Td;

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

% محاسبه پارامترهای پاسخ گذرا
step_info = stepinfo(G_closed);

% محاسبه خطای حالت ماندگار (theoretical)
ess = 1 / (1 + dcgain(G_closed));

% نمایش نتایج
fprintf('Rise Time (tr): %.4f seconds\n', step_info.RiseTime);
fprintf('Overshoot (P.O): %.2f%%\n', step_info.Overshoot);
fprintf('Settling Time (ts): %.4f seconds\n', step_info.SettlingTime);
fprintf('Steady-State Error (ess): %.4f\n', ess);

% رسم پاسخ پله سیستم حلقه بسته
figure;
plot(t, y, 'b', 'LineWidth', 1.5);
title(['Closed-Loop Step Response with PID Controller (Kp = ' num2str(Kp) ', Ki = ' num2str(Ki) ', Kd = ' num2str(Kd) ')']);
xlabel('Time (seconds)');
ylabel('Output');
grid on;
