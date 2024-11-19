% تعریف تابع انتقال سیستم
numerator = [1 5];
denominator = [1 2 4];
sys = tf(numerator, denominator);

% محاسبه مشخصه‌های پاسخ زمانی
info = stepinfo(sys);

% استخراج مقادیر
rise_time = info.RiseTime;
settling_time = info.SettlingTime;
overshoot = info.Overshoot;
ess = abs(1 - dcgain(sys)); % خطای حالت ماندگار برای ورودی پله

% نمایش نتایج در جدول
fprintf('مشخصه‌های پاسخ زمانی سیستم به ورودی پله واحد:\n');
fprintf('--------------------------------------------\n');
fprintf('زمان صعود (Rise Time, t_r): %.4f seconds\n', rise_time);
fprintf('زمان نشست (Settling Time, t_s): %.4f seconds\n', settling_time);
fprintf('درصد فراجهش (Percent Overshoot, P.O): %.2f%%\n', overshoot);
fprintf('خطای حالت ماندگار (Steady-state error, e_ss): %.4f\n', ess);
