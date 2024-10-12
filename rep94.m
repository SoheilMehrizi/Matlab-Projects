% سیستم جبران نشده
num_uncompensated = 10;
den_uncompensated = [1 6 0];
G_uncompensated = tf(num_uncompensated, den_uncompensated);

% سیستم جبران شده با کنترل کننده پسفاز
Kc = 8; % مقدار کنترل کننده پیشفاز
T = 1; % مقدار زمانی T
beta = 2; % مقدار زمانی Beta

num_compensated = [Kc*T  Kc]; % Numerator of the compensated system
den_compensated = [T/beta 1]; % Denominator of the compensated system
G_compensated = tf(num_compensated, den_compensated); % Compensated system transfer function

% پاسخ پله سیستم جبران نشده
[y_uncompensated, t_uncompensated] = step(G_uncompensated);

% پاسخ پله سیستم جبران شده
[y_compensated, t_compensated] = step(G_compensated);

% ویژگی‌های زمانی سیستم جبران نشده
uncompensated_info = stepinfo(y_uncompensated, t_uncompensated);

% ویژگی‌های زمانی سیستم جبران شده
compensated_info = stepinfo(y_compensated, t_compensated);


% رسم پاسخ پله
figure;
plot(t_uncompensated, y_uncompensated, 'b', 'LineWidth', 2);
hold on;
plot(t_compensated, y_compensated, 'r--', 'LineWidth', 2);
legend('Uncompensated System', 'Compensated System');
xlabel('Time');
ylabel('Step Response');
title('Step Response Comparison');
grid on;
fprintf("uncompensated_info:\n");
disp(uncompensated_info);
fprintf("compensated_info\n");
disp(compensated_info);
