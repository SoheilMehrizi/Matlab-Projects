% تعریف تابع انتقال سیستم G1(s)
numerator = 1;
denominator = [1 3 3 1];
G1 = tf(numerator, denominator);

% تقریبی پارامترهای L و T از پاسخ پله سیستم (اینجا مقادیر فرضی استفاده شده)
L = 1; % زمان تاخیر تقریبی (باید از نمودار دقیقاً بدست آید)
T = 3; % زمان ثابت تقریبی (باید از نمودار دقیقاً بدست آید)

% محاسبه پارامترهای کنترل‌کننده‌ها با استفاده از روش زیگلر-نیکولز
a = T / L;

% کنترل‌کننده P
Kp_P = 1 / a;
P_controller = Kp_P;

% کنترل‌کننده PI
Kp_PI = 0.9 / a;
Ti_PI = 3 * L;
PI_controller = Kp_PI * (1 + tf([1], [Ti_PI, 0]));

% کنترل‌کننده PID
Kp_PID = 1.2 / a;
Ti_PID = 2 * L;
Td_PID = L / 2;
PID_controller = Kp_PID * (1 + tf([1], [Ti_PID, 0]) + tf([Td_PID, 0], [1]));

% سیستم‌های حلقه بسته با کنترل‌کننده‌های مختلف
closed_loop_P = feedback(P_controller * G1, 1);
closed_loop_PI = feedback(PI_controller * G1, 1);
closed_loop_PID = feedback(PID_controller * G1, 1);

% تعریف زمان شبیه‌سازی و اغتشاش پله‌ای
t = 0:0.01:30;
u = ones(size(t)); % ورودی پله واحد
disturbance = (t >= 15) * -1; % اغتشاش پله‌ای در لحظه t = 15

% پاسخ سیستم حلقه بسته به ورودی پله واحد و اغتشاش پله‌ای
y_P = lsim(closed_loop_P, u + disturbance, t);
y_PI = lsim(closed_loop_PI, u + disturbance, t);
y_PID = lsim(closed_loop_PID, u + disturbance, t);

% رسم پاسخ سیستم حلقه بسته با کنترل‌کننده‌های مختلف در حضور اغتشاش
figure;
plot(t, y_P, 'LineWidth', 1.5);
hold on;
plot(t, y_PI, 'LineWidth', 1.5);
plot(t, y_PID, 'LineWidth', 1.5);
title('Closed-Loop Response with P, PI, and PID Controllers in Presence of Disturbance');
xlabel('Time (seconds)');
ylabel('Amplitude');
legend('P Controller', 'PI Controller', 'PID Controller');
grid on;

% محاسبه ویژگی‌های پاسخ زمانی در حضور اغتشاش
info_P = stepinfo(y_P, t, 1);
info_PI = stepinfo(y_PI, t, 1);
info_PID = stepinfo(y_PID, t, 1);

% نمایش ویژگی‌های پاسخ زمانی در حضور اغتشاش
fprintf('P Controller (with disturbance):\n');
fprintf('Rise Time (t_r): %.4f s\n', info_P.RiseTime);
fprintf('Settling Time (t_s): %.4f s\n', info_P.SettlingTime);
fprintf('Overshoot (P.O): %.2f %%\n', info_P.Overshoot);
fprintf('Steady-State Error (e_ss): %.4f\n', abs(1 - y_P(end)));

fprintf('\nPI Controller (with disturbance):\n');
fprintf('Rise Time (t_r): %.4f s\n', info_PI.RiseTime);
fprintf('Settling Time (t_s): %.4f s\n', info_PI.SettlingTime);
fprintf('Overshoot (P.O): %.2f %%\n', info_PI.Overshoot);
fprintf('Steady-State Error (e_ss): %.4f\n', abs(1 - y_PI(end)));

fprintf('\nPID Controller (with disturbance):\n');
fprintf('Rise Time (t_r): %.4f s\n', info_PID.RiseTime);
fprintf('Settling Time (t_s): %.4f s\n', info_PID.SettlingTime);
fprintf('Overshoot (P.O): %.2f %%\n', info_PID.Overshoot);
fprintf('Steady-State Error (e_ss): %.4f\n', abs(1 - y_PID(end)));
