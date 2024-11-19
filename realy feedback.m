% تعریف تابع انتقال سیستم
num = 1;
den = [1 9 36 84 126 126 84 36 9 1];
G = tf(num, den);

% پارامترهای شبیه‌سازی
t = 0:0.01:50;
relay_amplitude = 1;
relay_bias = 0;

% سیگنال ورودی رله
u = relay_amplitude * square(2 * pi * 0.1 * t) + relay_bias;

% شبیه‌سازی پاسخ سیستم
[y, t_out, x] = lsim(G, u, t);

% رسم نمودار پاسخ سیستم
figure;
plot(t_out, y);
title('Relay Feedback Response');
xlabel('Time (s)');
ylabel('Output');
grid on;

% محاسبه دامنه و دوره نوسانات
A = (max(y) - min(y)) / 2;
P_u = mean(diff(find(diff(sign(diff(y)))))) * 0.01;

% محاسبه نقطه نهایی
K_u = 4 * relay_amplitude / (pi * A);
L = P_u / 2;

% نمایش نتایج
fprintf('Amplitude (A): %.4f\n', A);
fprintf('Period (P_u): %.4f\n', P_u);
fprintf('Ultimate Gain (K_u): %.4f\n', K_u);
fprintf('L (Half Period): %.4f\n', L);
