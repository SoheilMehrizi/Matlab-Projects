% مشخصات سیستم
num = 10;
den = [1 6 0];
G = tf(num, den);

% مقادیر مختلف K
K_values = [8, 12, 30];
Kv_target = 5;  % ثابت خطای سرعت هدف

for K = K_values
    % سیستم حلقه بسته
    Gc = K;
    G_cl = feedback(G*Gc, 1);
    
    % محاسبه ثابت خطای سرعت
    Kv = dcgain(G*Gc/s);
    
    % رسم پاسخ پله
    figure;
    step(G_cl);
    title(['Step Response for K = ', num2str(K)]);
    grid on;
    
    % نمایش Kv
    fprintf('For K = %.2f:\n', K);
    fprintf('Kv = %.2f (Target = %.2f)\n', Kv, Kv_target);
    poles = pole(G_cl);
    fprintf('Closed-loop poles:\n');
    disp(poles);
    fprintf('\n');
end
