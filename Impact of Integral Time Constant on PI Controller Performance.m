% تعریف تابع تبدیل سیستم حلقه باز
numerator = 1;
denominator = [1 3 4 2];
G = tf(numerator, denominator);

% بهره تناسبی
Kp = 2;

% مقادیر زمان انتگرالی و بهره انتگرالی
Ti_values = [10, 2.5];
Ki_values = Kp ./ Ti_values;

% تعریف زمان شبیه‌سازی
t = 0:0.1:60;

% جدول برای ذخیره نتایج
results = [];

for i = 1:length(Ti_values)
    Ti = Ti_values(i);
    Ki = Ki_values(i);
    
    % تعریف کنترل‌کننده PI
    PI_controller = Kp + tf([Ki], [1 0]);
    
    % ایجاد سیستم حلقه بسته با فیدبک واحد
    closed_loop_system = feedback(PI_controller * G, 1);
    
    % شبیه‌سازی پاسخ سیستم به ورودی پله واحد
    [y, t] = step(closed_loop_system, t);
    
    % محاسبه مشخصه‌های پاسخ
    step_info = stepinfo(closed_loop_system);
    ess_numeric = abs(1 - y(end));
    
    % ذخیره نتایج
    results = [results; Ti, Ki, step_info.RiseTime, step_info.Overshoot, step_info.SettlingTime, ess_numeric, 0];
end

% نمایش نتایج
disp('Results:');
disp(' Ti      Ki      tr      P.O     ts      ess     ess(Theoretical)');
disp(results);
