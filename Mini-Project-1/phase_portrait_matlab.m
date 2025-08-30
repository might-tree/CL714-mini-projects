clear
close all
clc

% Define the equation for dx/dt
languageCompetitionModel = @(x, s, a) s * (1 - x) * x^a - (1 - s) * x * (1 - x)^a;

% Parameters
s = 0.5; % Perceived status parameter
a = 2;   % Exponent parameter
x0_vals = 0.05:0.1:0.95;
t_span = [0, 50];

figure;
hold on;

legendEntries = cell(length(x0_vals), 1);
fixedPointEquation = @(x) languageCompetitionModel(x, s, a);
x_fixed = fzero(fixedPointEquation, 0.5); % Starting guess in the middle of the range

for i = 1:length(x0_vals)
    x0 = x0_vals(i);
    [t, x] = ode45(@(t, x) languageCompetitionModel(x, s, a), t_span, x0);
    plot(t, x, 'LineWidth', 1.5);  % Phase trajectory
    legendEntries{i} = ['Initial Condition: x_0 = ' num2str(x0)]; % Dynamic legend label
end

plot(t_span, ones(size(t_span)) * x_fixed, '--r', 'LineWidth', 2);

ylabel('x (Proportion of Population Speaking X)');
xlabel('Time');
title('Phase Portrait of Language Competition Model');
axis([0 50 0 1]);
grid on;
legend(legendEntries, 'Location', 'best');
hold off;
