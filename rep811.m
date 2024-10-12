alpha_values = [0.1, 0.2, 0.9];
T = 1;
Kc = 1;

figure;
hold on;
for alpha = alpha_values
    Gc = Kc * tf([1, 1/T], [1, 1/(alpha*T)]);
    bode(Gc);
end
legend('\alpha = 0.1', '\alpha = 0.2', '\alpha = 0.9');
title('Bode Plot for Different \alpha Values');
grid on;
hold off;
