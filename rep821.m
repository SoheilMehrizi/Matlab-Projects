% مشخصات سیستم
num = 2;
den = [1 0.5 0];
G = tf(num, den);

% بهره های مختلف K
K_values = [2, 6, 8];

% مشخصات مطلوب
zeta = sqrt(2)/2;
omega_n = 2;
s_desired = [-zeta*omega_n + 1i*omega_n*sqrt(1-zeta^2), -zeta*omega_n - 1i*omega_n*sqrt(1-zeta^2)];

% حلقه برای بررسی بهره های مختلف
for K = K_values
    % تابع تبدیل حلقه بسته
    G_cl = feedback(K*G, 1);
    
    % محاسبه قطب های حلقه بسته
    poles = pole(G_cl);
    
    % رسم نمودار مکان هندسی قطب ها
    figure;
    rlocus(G*K);
    hold on;
    plot(real(s_desired), imag(s_desired), 'rx', 'MarkerSize', 10, 'LineWidth', 2);
    title(['Root Locus for K = ', num2str(K)]);
    xlabel('Real Axis');
    ylabel('Imaginary Axis');
    grid on;
    
    % نمایش قطب های حلقه بسته
    disp(['برای K = ', num2str(K), ', قطب های سیستم حلقه بسته:']);
    disp(poles);
end
