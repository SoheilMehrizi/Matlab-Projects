% سیستم حلقه بسته با کنترل‌کننده P
closed_loop_P = feedback(P_controller * G1, 1);

% سیستم حلقه بسته با کنترل‌کننده PI
closed_loop_PI = feedback(PI_controller * G1, 1);

% سیستم حلقه بسته با کنترل‌کننده PID
closed_loop_PID = feedback(PID_controller * G1, 1);

% شبیه‌سازی پاسخ پله سیستم‌های حلقه بسته
figure;
step(closed_loop_P);
hold on;
step(closed_loop_PI);
step(closed_loop_PID);
title('Closed-Loop Step Response with P, PI, and PID Controllers');
xlabel('Time (seconds)');
ylabel('Amplitude');
legend('P Controller', 'PI Controller', 'PID Controller');
grid on;
