% تعریف مقدار T
T = 0.1;

% تعریف تابع انتقال سیستم برای T=0.1
sys = tf(1, [T 1]);

% شبیه‌سازی پاسخ پله واحد
[y_step, t_step] = step(sys);

% شبیه‌سازی پاسخ شیب واحد با استفاده از lsim
t_ramp = 0:0.01:10; % تعریف بردار زمان برای ورودی شیب
u_ramp = t_ramp; % ورودی شیب واحد
[y_ramp, t_ramp] = lsim(sys, u_ramp, t_ramp);

% شبیه‌سازی پاسخ شتاب واحد با استفاده از lsim
t_parabolic = 0:0.01:10; % تعریف بردار زمان برای ورودی شتاب
u_parabolic = 0.5 * t_parabolic.^2; % ورودی شتاب واحد
[y_parabolic, t_parabolic] = lsim(sys, u_parabolic, t_parabolic);

% محاسبه خطای حالت ماندگار
e_ss_step = abs(1 - y_step(end)); % خطای حالت ماندگار برای پاسخ پله
e_ss_ramp = t_ramp(end) - y_ramp(end); % خطای حالت ماندگار برای ورودی شیب واحد
e_ss_parabolic = (0.5 * t_parabolic(end)^2) - y_parabolic(end); % خطای حالت ماندگار برای ورودی شتاب واحد

% نمایش نتایج
figure;

% پاسخ پله واحد
subplot(3, 1, 1);
plot(t_step, y_step);
title('پاسخ پله واحد برای T = 0.1');
xlabel('زمان (ثانیه)');
ylabel('خروجی');
grid on;

% پاسخ شیب واحد
subplot(3, 1, 2);
plot(t_ramp, y_ramp);
hold on;
plot(t_ramp, u_ramp, '--');
title('پاسخ شیب واحد برای T = 0.1');
xlabel('زمان (ثانیه)');
ylabel('خروجی');
legend('خروجی', 'ورودی (شیب واحد)');
grid on;

% پاسخ شتاب واحد
subplot(3, 1, 3);
plot(t_parabolic, y_parabolic);
hold on;
plot(t_parabolic, u_parabolic, '--');
title('پاسخ شتاب واحد برای T = 0.1');
xlabel('زمان (ثانیه)');
ylabel('خروجی');
legend('خروجی', 'ورودی (شتاب واحد)');
grid on;

% نمایش خطاهای حالت ماندگار
fprintf('خطای حالت ماندگار برای پاسخ پله: %.2f\n', e_ss_step);
fprintf('خطای حالت ماندگار برای ورودی شیب واحد: %.2f\n', e_ss_ramp);
fprintf('خطای حالت ماندگار برای ورودی شتاب واحد: %.2f\n', e_ss_parabolic);
