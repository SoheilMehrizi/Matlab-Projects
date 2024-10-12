% تعریف تابع انتقال سیستم G1(s)
numerator = 1;
denominator = [1 3 3 1];
G1 = tf(numerator, denominator);

% شبیه‌سازی پاسخ پله واحد
[y, t] = step(G1);

% رسم نمودار پاسخ پله
figure;
plot(t, y, 'LineWidth', 2);
title('Step Response of G1(s) = 1/(1+s)^3');
xlabel('Time (seconds)');
ylabel('Amplitude');
grid on;

% تقریبی پارامترهای L و T
% فرض کنیم L و T را از نمودار بدست آورده ایم
L = 1; % زمان تاخیر تقریبی (باید از نمودار دقیقاً بدست آید)
T = 3; % زمان ثابت تقریبی (باید از نمودار دقیقاً بدست آید)
