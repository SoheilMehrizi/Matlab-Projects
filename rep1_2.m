% تعریف پارامترهای مختلف
params = [
    2, 0.1;
    2, 0.5;
    2, 1;
    2, 1.5;
    4, 0.1;
    4, 0.5;
    4, 1;
    4, 1.5
];

% ایجاد یک شکل برای نمایش نمودارها
figure;

for i = 1:size(params, 1)
    wn = params(i, 1);
    zeta = params(i, 2);
    
    % تعریف تابع انتقال سیستم
    sys = tf(wn^2, [1, 2*zeta*wn, wn^2]);
    
    % رسم نمودار محل صفر-قطب
    subplot(4, 2, i);
    pzmap(sys);
    title(['نمودار محل صفر-قطب برای \omega_n = ', num2str(wn), ' و \zeta = ', num2str(zeta)]);
    xlabel('Re');
    ylabel('Im');
    grid on;
end