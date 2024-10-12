% تعریف تابع تبدیل سیستم حلقه باز
numerator = 1;
denominator = [1 3 4 2];
G = tf(numerator, denominator);

% تعریف کنترل‌کننده تناسبی
Kp = 1;
P_controller = Kp;

% ایجاد سیستم حلقه بسته با فیدبک واحد
closed_loop_system = feedback(P_controller * G, 1);

% تعریف زمان شبیه‌سازی
t = 0:0.1:60;

% تعریف ورودی پله واحد
u = ones(size(t));

% تعریف اغتشاش پله در لحظه t = 20 با اندازه -1
disturbance = -1 * (t >= 20);

% ورودی کلی سیستم (پله + اغتشاش)
total_input = u + disturbance;

% شبیه‌سازی پاسخ سیستم به ورودی کلی
[y, t, x] = lsim(closed_loop_system, total_input, t);

% نمایش پاسخ سیستم
figure;
plot(t, y, 'b', 'LineWidth', 2);
hold on;
plot(t, total_input, 'r--', 'LineWidth', 1.5);
legend('System Response', 'Total Input (Step + Disturbance)');
title('System Response to Step Input with Disturbance at t = 20s');
xlabel('Time (s)');
ylabel('Response');
grid on;
