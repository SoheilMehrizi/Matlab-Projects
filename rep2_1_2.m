% تعریف تابع تبدیل سیستم حلقه باز
numerator = 1;
denominator = [1 3 4 2];
G = tf(numerator, denominator);

% مقادیر مختلف بهره کنترل‌کننده تناسبی
Kp_values = [1, 5, 9];

% ذخیره نتایج
results = [];

% شبیه‌سازی برای هر مقدار Kp
for Kp = Kp_values
    % تعریف کنترل‌کننده تناسبی
    P_controller = Kp;
    
    % ایجاد سیستم حلقه بسته با فیدبک واحد
    closed_loop_system = feedback(P_controller * G, 1);
    
    % شبیه‌سازی پاسخ سیستم به ورودی پله واحد
    [y, t] = step(closed_loop_system);
    
    % محاسبه مشخصات پاسخ
    info = stepinfo(closed_loop_system);
    tr = info.RiseTime;
    P_O = info.Overshoot;
    ts = info.SettlingTime;
    
    % محاسبه خطای حالت ماندگار به صورت عددی
    ess_numeric = abs(1 - y(end));
    
    % محاسبه خطای حالت ماندگار به صورت تئوری
    s = tf('s');
    G_closed_loop = P_controller * G / (1 + P_controller * G);
    ess_theoretical = dcgain(1 - G_closed_loop);
    
    % ذخیره نتایج
    results = [results; Kp, tr, P_O, ts, ess_numeric, ess_theoretical];
end

% نمایش نتایج
results_table = array2table(results, 'VariableNames', {'Kp', 'tr', 'P.O', 'ts', 'ess_numeric', 'ess_theoretical'});

% نمایش نتایج
disp(results_table);
