% تعریف پارامترهای کنترل‌کننده PD
Kp = 2;
Kd = 5;  % می‌توانید این مقدار را تغییر دهید و تاثیر آن را بررسی کنید

% تعریف تابع تبدیل سیستم باز
num = 1;
den = [1 3 4 2];
G = tf(num, den);

% تعریف تابع تبدیل کنترل‌کننده PD
C = tf([Kd Kp], 1);

% تشکیل تابع تبدیل حلقه باز سیستم با کنترل‌کننده
G_open = series(C, G);

% تشکیل تابع تبدیل حلقه بسته با فیدبک واحد
G_closed = feedback(G_open, 1);

% تعریف تابع تبدیل اغتشاش به خروجی
G_dist = feedback(G, C);

% شبیه‌سازی پاسخ پله و اعمال اغتشاش در زمان t = 20 ثانیه
t = 0:0.1:40; % بازه زمانی شبیه‌سازی
u = ones(size(t)); % ورودی پله واحد
dist = -1 * (t >= 20); % اغتشاش پله در زمان t = 20 ثانیه

% شبیه‌سازی پاسخ سیستم به ورودی پله و اغتشاش
[y, t, x] = lsim(G_closed, u, t);
[y_dist, t, x_dist] = lsim(G_dist, dist, t);

% ترکیب پاسخ به ورودی پله و اغتشاش
y_total = y + y_dist;

% رسم نتایج
figure;
plot(t, y, 'b', 'LineWidth', 1.5); hold on;
plot(t, y_total, 'r', 'LineWidth', 1.5);
plot(t, dist, 'k--', 'LineWidth', 1.5);
legend('Step Response without Disturbance', 'Total Response with Disturbance', 'Disturbance');
title(['Closed-Loop Response with PD Controller (Kp = ' num2str(Kp) ', Kd = ' num2str(Kd) ')']);
xlabel('Time (seconds)');
ylabel('Output');
grid on;
