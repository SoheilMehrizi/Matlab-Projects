% Define the transfer function G1(s)
num = 1;
den = [1 9 36 84 126 126 84 36 9 1]; % corresponds to (1+s)^3
G1 = tf(num, den);

% Calculate the roots of the characteristic equation
r = roots(den);

% Check the number of roots
num_roots = numel(r);

if num_roots >= 1
    % Define the desired damping ratio and natural frequency for the dominant pole
    zeta = 0.7;
    omega_n = abs(r(1)) * 1.5; % Adjust as needed for desired overshoot

    % Calculate the desired closed-loop poles
    s_star = -zeta * omega_n + j * omega_n * sqrt(1 - zeta^2);

    % Find the desired gain K using root locus method
    if num_roots >= 3
        K = abs((s_star + r(1)) * (s_star + r(2)) * (s_star + r(3)) / (1 * evalfr(G1, s_star)));
    elseif num_roots == 2
        K = abs((s_star + r(1)) * (s_star + r(2)) / (1 * evalfr(G1, s_star)));
    elseif num_roots == 1
        K = abs((s_star + r(1)) / (1 * evalfr(G1, s_star)));
    end

    % Display the results
    disp(['Desired Gain K: ', num2str(K)]);
    disp(['Desired Dominant Pole: ', num2str(s_star)]);
else
    disp('Error: Not enough roots available for the desired calculation.');
end
