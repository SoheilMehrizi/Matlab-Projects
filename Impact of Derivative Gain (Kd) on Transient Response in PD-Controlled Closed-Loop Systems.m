% تعریف پارامترهای کنترل‌کننده PD
Kp = 2;

% مقادیر مختلف Kd
Kd_values = [2, 8];

% تعریف تابع تبدیل سیستم باز
num = 1;
den = [1 3 4 2];
G = tf(num, den);

% تحلیل برای مقادیر مختلف Kd
for Kd = Kd_values
    % تعریف تابع تبدیل کنترل‌کننده PD
    C = tf([Kd Kp], 1);
    
    % تشکیل تابع تبدیل حلقه باز سیستم با کنترل‌کننده
    G_open = series(C, G);
    
    % تشکیل تابع تبدیل حلقه بسته با فیدبک واحد
    G_closed = feedback(G_open, 1);
    
    % رسم پاسخ پله سیستم حلقه بسته
    figure;
    step(G_closed);
    title(['Closed-Loop Step Response with PD Controller (Kp = ' num2str(Kp) ', Kd = ' num2str(Kd) ')']);
    grid on;
    
    % محاسبه پارامترهای پاسخ گذرا
    step_info = stepinfo(G_closed);
    tr = step_info.RiseTime;
    PO = step_info.Overshoot;
    ts = step_info.SettlingTime;
    
    % نمایش نتایج
    fprintf('For Kd = %d:\n', Kd);
    fprintf('Rise Time (tr): %.4f seconds\n', tr);
    fprintf('Overshoot (P.O): %.2f%%\n', PO);
    fprintf('Settling Time (ts): %.4f seconds\n', ts);
    
    % محاسبه خطای حالت ماندگار (theoretical)
    ess = 1/(1 + dcgain(G_closed));
    fprintf('Steady-State Error (ess): %.4f\n', ess);
    fprintf('\n');
end
