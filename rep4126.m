% تعریف تابع انتقال سیستم G1(s)
numerator = 1;
denominator = [1 9 36 84 126 126 84 36 9 1];
G2 = tf(numerator, denominator);
 

% رسم پاسخ پله سیستم
figure;
step(G2);
title('Step Response of G1(s)');
grid on;

% استخراج پارامترهای L و T از نمودار (باید به صورت تقریبی از نمودار بدست آید)
% در اینجا مقادیر فرضی استفاده شده است، شما باید از نمودار مقادیر دقیق را استخراج کنید
L = 1; % زمان تاخیر تقریبی
T = 3; % زمان ثابت تقریبی

% محاسبه پارامترهای کنترل‌کننده‌ها با استفاده از روش زیگلر-نیکولز
a = T / L;

% کنترل‌کننده P
Kp_P = 1 / a;

% کنترل‌کننده PI
Kp_PI = 0.9 / a;
Ti_PI = 3 * L;

% کنترل‌کننده PID
Kp_PID = 1.2 / a;
Ti_PID = 2 * L;
Td_PID = L / 2;

% نمایش مقادیر کنترل‌کننده‌ها
fprintf('Control Parameters using Ziegler-Nichols Method:\n');
fprintf('P Controller: Kp = %.4f\n', Kp_P);
fprintf('PI Controller: Kp = %.4f, Ti = %.4f\n', Kp_PI, Ti_PI);
fprintf('PID Controller: Kp = %.4f, Ti = %.4f, Td = %.4f\n', Kp_PID, Ti_PID, Td_PID);
