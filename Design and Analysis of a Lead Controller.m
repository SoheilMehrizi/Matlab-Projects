% مشخصات سیستم
num = 2;
den = [1 0.5 0];
G = tf(num, den);

% مشخصات مطلوب حلقه بسته
zeta = sqrt(2)/2;
omega_n = 2;
s_desired = [-zeta*omega_n + 1i*omega_n*sqrt(1-zeta^2), -zeta*omega_n - 1i*omega_n*sqrt(1-zeta^2)];

% محاسبه مقدار مطلوب برای Kc
G_mag = abs(freqresp(G, omega_n));
alpha = 0.1; % مقدار دلخواه برای alpha
K_c = (abs(s_desired(1)) + abs(s_desired(2)) - 2 * G_mag) / alpha;

% مقدار دلخواه برای T
T = 1;

% ساخت کنترل کننده پیشفاز
Gc = K_c * tf([T 1], [alpha*T 1]);

% حلقه بسته با کنترل کننده پیشفاز
G_cl = feedback(G*Gc, 1);

% رسم نمودار مکان هندسی قطب‌ها
figure;
rlocus(G*Gc);
hold on;
plot(real(s_desired), imag(s_desired), 'rx', 'MarkerSize', 10, 'LineWidth', 2);
title('Root Locus with Lead Controller');
xlabel('Real Axis');
ylabel('Imaginary Axis');
grid on;

% نمایش قطب‌های حلقه بسته
poles_cl = pole(G_cl);
disp('قطب‌های سیستم حلقه بسته:');
disp(poles_cl);
