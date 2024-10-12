% مشخصات سیستم
num = 10;
den = [1 6 0];
G = tf(num, den);

% ثابت خطای سرعت هدف
Kv_target = 5;

% محاسبه بهره Kc اولیه
Kc_initial = Kv_target * (6/10);

% مکان هندسی ریشه‌ها برای بهره‌های مختلف
beta_values = [2, 3, 5];  % مقادیر فرضی برای beta
T_values = 0.1:0.1:1;  % مقادیر فرضی برای T

for beta = beta_values
    for T = T_values
        % تابع تبدیل کنترل کننده پس‌فاز
        Gc = Kc_initial * tf([1 T], [1 beta*T]);
        
        % سیستم حلقه بسته
        G_open = G * Gc;
        G_cl = feedback(G_open, 1);
        
        % رسم مکان هندسی ریشه‌ها
        figure;
        rlocus(G_open);
        title(['Root Locus for \beta = ', num2str(beta), ', T = ', num2str(T)]);
        grid on;
    end
end

% محاسبه Kc دقیق‌تر پس از انتخاب beta و T مناسب
beta = 3;  % مقدار بهینه انتخاب‌شده
T = 0.5;   % مقدار بهینه انتخاب‌شده
Gc = Kc_initial * tf([1 T], [1 beta*T]);

% محاسبه ثابت خطای سرعت جدید
Kv_new = dcgain(G*Gc/s);

% نمایش پارامترهای کنترل کننده
fprintf('Optimized Controller Parameters:\n');
fprintf('Kc: %.2f\n', Kc_initial);
fprintf('Beta: %.2f\n', beta);
fprintf('T: %.2f\n', T);
fprintf('New Kv: %.2f\n', Kv_new);
