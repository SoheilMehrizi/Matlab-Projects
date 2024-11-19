% پارامترهای کنترل‌کننده PID ثابت
Kp = 2;
Ti = 3;

% محدوده مقادیر Kd برای بررسی
Kd_values = [1, 5, 10, 20];

% محاسبه Ki
Ki = Kp / Ti;

% تعریف تابع تبدیل سیستم باز
num = 1;
den = [1, 3, 4, 2];
G = tf(num, den);

% شبیه‌سازی برای مقادیر مختلف Kd
figure;
hold on;
colors = ['b', 'r', 'g', 'k']; % رنگ‌های مختلف برای نمودارها

for i = 1:length(Kd_values)
    Kd = Kd_values(i);

    % تعریف کنترل‌کننده PID برای هر Kd
    C = pid(Kp, Ki, Kd);

    % تشکیل تابع تبدیل حلقه بسته
    G_closed = feedback(series(C, G), 1);

    % شبیه‌سازی پاسخ پله
    [y, t] = step(G_closed, 40);

    % رسم پاسخ پله
    plot(t, y, colors(i), 'LineWidth', 1.5);
end

title('Closed-Loop Step Response with Different K_d values');
xlabel('Time (seconds)');
ylabel('Output');
legend('Kd = 1', 'Kd = 5', 'Kd = 10', 'Kd = 20');
grid on;
hold off;
