% تعریف تابع انتقال سیستم
numerator = 1;
denominator = [1 3 4 2];
G = tf(numerator, denominator);

% تعریف پارامترهای کنترل‌کننده PI
Kp = 2;
Ti = 10;
PI_controller = Kp + tf([Kp/Ti, Kp], [1, 0]);

% سیستم حلقه بسته با فیدبک واحد
closed_loop_system = feedback(PI_controller * G, 1);

% زمان شبیه‌سازی و ایجاد اغتشاش پله
t = 0:0.1:40;
disturbance_time = 20;
disturbance_size = -1;

% ایجاد سیگنال اغتشاش
disturbance_signal = disturbance_size * (t >= disturbance_time);

% شبیه‌سازی پاسخ سیستم
[y, t] = lsim(closed_loop_system, disturbance_signal, t);

% رسم نمودار پاسخ سیستم به اغتشاش
figure;
plot(t, y, 'LineWidth', 2);
title('Response of System with PI Controller to Step Disturbance');
xlabel('Time (s)');
ylabel('Response');
grid on;
