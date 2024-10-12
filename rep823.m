% مشخصات سیستم
num = 2;
den = [1 0.5 0];
G = tf(num, den);

% مشخصات مطلوب حلقه بسته
zeta = sqrt(2)/2;
omega_n = 2;
s_desired = [-zeta*omega_n + 1i*omega_n*sqrt(1-zeta^2), -zeta*omega_n - 1i*omega_n*sqrt(1-zeta^2)];

% طراحی کنترل کننده پیشفاز
alpha = 0.1;
T = 1;
G_mag = abs(freqresp(G, omega_n));
K_c = (abs(s_desired(1)) + abs(s_desired(2)) - 2 * G_mag) / alpha;
Gc = K_c * tf([T 1], [alpha*T 1]);

% سیستم جبران شده
G_comp = feedback(G*Gc, 1);

% رسم پاسخ پله برای سیستم جبران شده و جبران نشده
figure;
step(G_comp);
hold on;
step(feedback(G, 1));
title('Step Response');
legend('Compensated System', 'Uncompensated System');
grid on;

% محاسبه مشخصه‌های عملکردی
info_comp = stepinfo(G_comp);
info_uncomp = stepinfo(feedback(G, 1));

% خطای ماندگار
ess_comp = abs(1 - dcgain(G_comp));
ess_uncomp = abs(1 - dcgain(feedback(G, 1)));

% نمایش مشخصات
fprintf('Compensated System:\n');
fprintf('Rise Time (tr): %.2f seconds\n', info_comp.RiseTime);
fprintf('Settling Time (ts): %.2f seconds\n', info_comp.SettlingTime);
fprintf('Steady-State Error (ess): %.2f\n', ess_comp);
fprintf('Peak Overshoot (P.O.): %.2f%%\n', info_comp.Overshoot);

fprintf('\nUncompensated System:\n');
fprintf('Rise Time (tr): %.2f seconds\n', info_uncomp.RiseTime);
fprintf('Settling Time (ts): %.2f seconds\n', info_uncomp.SettlingTime);
fprintf('Steady-State Error (ess): %.2f\n', ess_uncomp);
fprintf('Peak Overshoot (P.O.): %.2f%%\n', info_uncomp.Overshoot);
