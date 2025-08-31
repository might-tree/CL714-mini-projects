clear; close all; clc

% Parameters (example)
s = -0.2;
a = 2;
x0_vals = [0.01, 0.05, 0.1, 0.2, 0.4, 0.6, 0.9];
tspan = [0 50];

f = @(t,x) s*(1-x).*x.^a - (1-s)*x.*(1-x).^a;

figure; hold on;
colors = lines(length(x0_vals));
for i=1:length(x0_vals)
    x0 = x0_vals(i);
    [t,x] = ode45(f, tspan, x0);
    plot(t, x, 'Color', colors(i,:), 'LineWidth', 1.5);
end

% plot fixed points as markers
plot(tspan, zeros(size(tspan)), '--k', 'LineWidth', 2); % x=0 line for reference
plot(tspan, ones(size(tspan)), ':k', 'LineWidth', 1);   % x=1 reference

xlabel('Time'); ylabel('x (proportion speaking X)');
title(sprintf('Trajectories for s = %.2f, a = %.2f', s, a));
ylim([0 1]); grid on;
legendStrings = arrayfun(@(x0) sprintf('x_0 = %.2f', x0), x0_vals, 'UniformOutput', false);
legend([legendStrings, {'x=0','x=1'}], 'Location','northeast');
hold off;
