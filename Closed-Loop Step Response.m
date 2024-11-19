% تعریف تابع تبدیل سیستم حلقه باز
numerator = 1;
denominator = [1 3 4 2];
G = tf(numerator, denominator);

% مقادیر مختلف بهره کنترل‌کننده تناسبی
Kp_values = [-1.5, -1, 0, 1, 5, 10];

% شبیه‌سازی برای هر مقدار Kp و نمایش پاسخ پله
figure;
hold on;
for Kp = Kp_values
    % تعریف کنترل‌کننده تناسبی
    P_controller = Kp;
    
    % ایجاد سیستم حلقه بسته با فیدبک واحد
    closed_loop_system = feedback(P_controller * G, 1);
    
    % شبیه‌سازی پاسخ سیستم به ورودی پله واحد
    [y, t] = step(closed_loop_system);
    plot(t, y, 'DisplayName', ['K_p = ', num2str(Kp)]);
    
    % بررسی پایداری
    poles = pole(closed_loop_system);
    if any(real(poles) > 0)
        disp(['System is unstable for K_p = ', num2str(Kp)]);
    else
        disp(['System is stable for K_p = ', num2str(Kp)]);
    end
end
hold off;
legend;
title('Closed-Loop Step Response for Different K_p Values');
grid on;

