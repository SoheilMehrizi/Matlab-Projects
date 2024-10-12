% مشخصات سیستم
num = 2;
den = [1 0.5 0];
G = tf(num, den);

% طراحی کنترل کننده پیشفاز
alpha = 0.1;
T = 1;
K_c = 10;  % فرضیه برای مثال، می‌توانید مقدار دقیق‌تر را محاسبه کنید
Gc = K_c * tf([T 1], [alpha*T 1]);

% سیستم حلقه بسته جبران شده و جبران نشده
G_comp = feedback(G*Gc, 1);
G_uncomp = feedback(G, 1);

% رسم پاسخ به ورودی شیب واحد
t = 0:0.01:10;
figure;
lsim(G_comp, t, t);
hold on;
lsim(G_uncomp, t, t);
title('Response to Unit Ramp Input');
legend('Compensated System', 'Uncompensated System');
xlabel('Time (s)');
ylabel('Response');
grid on;

% محاسبه خطای حالت دائمی برای ورودی شیب واحد
s = tf('s');
ess_comp = abs(1 - dcgain(G_comp/s));
ess_uncomp = abs(1 - dcgain(G_uncomp/s));

% نمایش خطای حالت دائمی
fprintf('Steady-State Error for Unit Ramp Input:\n');
fprintf('Compensated System: %.2f\n', ess_comp);
fprintf('Uncompensated System: %.2f\n', ess_uncomp);
