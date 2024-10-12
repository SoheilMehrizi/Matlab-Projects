num = 1;
den = [1 3 3 1]; % corresponds to (1+s)^3
G1 = tf(num, den);


% Plot root locus of G1(s)
figure;
rlocus(G1);
grid on; % Add grid to the root locus plot for clarity

% Calculate the gain K and final closed-loop poles automatically
[K, poles] = rlocfind(G1);

% Display the results
disp('----------------------------------------');
disp('Results:');
disp(['K = ', num2str(K)]);
disp(['Poles = ', num2str(poles')]);
