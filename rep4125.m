% تعریف تابع انتقال سیستم G2(s)
numerator = 1;
denominator = [1 9 36 84 126 126 84 36 9 1];
G2 = tf(numerator, denominator);

% پارامترهای کنترل‌کننده PID از مرحله قبل (با توجه به مقادیر اولیه)
L = 3; % زمان تاخیر تقریبی
T = 9; % زمان ثابت تقریبی
a = T / L;

% پارامترهای اولیه کنترل‌کننده PID از روش زیگلر-نیکولز
Kp_initial = 1.2 / a;
Ti_initial = 2 * L;
Td_initial = L / 2;

% تغییر پارامترهای K و Ti
Kp_new = 0.7 * Kp_initial;
Ti_new = 2 * Ti_initial;

% کنترل‌کننده PID جدید
PID_controller_new = Kp_new * (1 + tf([1], [Ti_new, 0]) + tf([Td_initial, 0], [1]));

% سیستم حلقه بسته با کنترل‌کننده PID جدید
closed_loop_PID_new = feedback(PID_controller_new * G2, 1);

% تعریف زمان شبیه‌سازی
t = 0:0.01:50; % زمان شبیه‌سازی طولانی‌تر به دلیل رفتار کندتر سیستم
u = ones(size(t)); % ورودی پله واحد

% پاسخ سیستم حلقه بسته به ورودی پله واحد
y_PID_new = lsim(closed_loop_PID_new, u, t);

% رسم پاسخ سیستم حلقه بسته با کنترل‌کننده PID جدید
figure;
plot(t, y_PID_new, 'LineWidth', 1.5);
title('Closed-Loop Response with Modified PID Controller');
xlabel('Time (seconds)');
ylabel('Amplitude');
legend('Modified PID Controller');
grid on;

% محاسبه ویژگی‌های پاسخ زمانی
info_PID_new = stepinfo(y_PID_new, t, 1);

% نمایش ویژگی‌های پاسخ زمانی
fprintf('Modified PID Controller:\n');
fprintf('Rise Time (t_r): %.4f s\n', info_PID_new.RiseTime);
fprintf('Settling Time (t_s): %.4f s\n', info_PID_new.SettlingTime);
fprintf('Overshoot (P.O): %.2f %%\n', info_PID_new.Overshoot);
fprintf('Steady-State Error (e_ss): %.4f\n', abs(1 - y_PID_new(end)));
