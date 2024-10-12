% محاسبه ویژگی‌های پاسخ زمانی
info_P = stepinfo(closed_loop_P);
info_PI = stepinfo(closed_loop_PI);
info_PID = stepinfo(closed_loop_PID);

% نمایش ویژگی‌های پاسخ زمانی
fprintf('P Controller:\n');
fprintf('Rise Time (t_r): %.4f s\n', info_P.RiseTime);
fprintf('Settling Time (t_s): %.4f s\n', info_P.SettlingTime);
fprintf('Overshoot (P.O): %.2f %%\n', info_P.Overshoot);
fprintf('Steady-State Error (e_ss): %.4f\n', abs(1 - dcgain(closed_loop_P)));

fprintf('\nPI Controller:\n');
fprintf('Rise Time (t_r): %.4f s\n', info_PI.RiseTime);
fprintf('Settling Time (t_s): %.4f s\n', info_PI.SettlingTime);
fprintf('Overshoot (P.O): %.2f %%\n', info_PI.Overshoot);
fprintf('Steady-State Error (e_ss): %.4f\n', abs(1 - dcgain(closed_loop_PI)));

fprintf('\nPID Controller:\n');
fprintf('Rise Time (t_r): %.4f s\n', info_PID.RiseTime);
fprintf('Settling Time (t_s): %.4f s\n', info_PID.SettlingTime);
fprintf('Overshoot (P.O): %.2f %%\n', info_PID.Overshoot);
fprintf('Steady-State Error (e_ss): %.4f\n', abs(1 - dcgain(closed_loop_PID)));