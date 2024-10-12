% تعریف تابع تبدیل سیستم G1(s)
numerator = 1;
denominator = [1 3 3 1];
G1 = tf(numerator, denominator);

% محاسبه و نمایش پاسخ پله واحد
figure;
step(G1);
title('Step Response of G1(s) = 1/(1+s)^3');
xlabel('Time (s)');
ylabel('Response');
grid on;
