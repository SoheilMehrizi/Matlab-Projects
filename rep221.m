% تعریف تابع تبدیل سیستم حلقه باز
numerator = 1;
denominator = [1 3 4 2];
G = tf(numerator, denominator);

% تعریف کنترل‌کننده PI
Kp = 1; % بهره تناسبی
Ki = 1; % بهره انتگرالی
PI_controller = Kp + tf([Ki], [1 0]);

% ایجاد سیستم حلقه بسته با فیدبک واحد
closed_loop_system = feedback(PI_controller * G, 1);

% شبیه‌سازی پاسخ سیستم به ورودی پله واحد
t = 0:0.1:60; % تعریف زمان شبیه‌سازی
[y, t] = step(closed_loop_system, t); % محاسبه پاسخ سیستم

% نمایش پاسخ سیستم
figure;
plot(t, y, 'b', 'LineWidth', 2);
title('Closed-Loop Step Response with PI Controller');
xlabel('Time (s)');
ylabel('Response');
grid on;

% نمایش مشخصه‌های پاسخ
step_info = stepinfo(closed_loop_system);
ess_numeric = abs(1 - y(end));

disp('Step Response Characteristics:');
disp(step_info);
disp(['Numerical Steady-State Error: ', num2str(ess_numeric)]);
