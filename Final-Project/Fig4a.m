%% FIGURE 4(a) – Map T(x) vs x (piecewise-linear recursion)
clear; 
close all; 
clc;

% Parameters from paper
d1 = 0.1;
d2 = 0.2;
alpha = 0.7;   
m = 1 - alpha;

SetGraphics;
xs = linspace(0,1,500);

T1 = nan(size(xs));   % x <= d1
T2 = nan(size(xs));   % d1 < x < d2
T3 = nan(size(xs));   % x >= d2

for i = 1:length(xs)
    x = xs(i);
    if x < d1 
        T1(i) = m*x;
    elseif x == d1
        T1(i) = x;
    elseif x > d2
        T3(i) = m*x;
    elseif x == d2
        T3(i) = x;
    else
        T2(i) = m*x + (1-m);
    end
end

figure('Position',[200 200 650 450]);
plot(xs, T1, 'b', 'LineWidth', 2); hold on;
plot(xs, T2, 'b', 'LineWidth', 2);
plot(xs, T3, 'b', 'LineWidth', 2);

% Identity line
plot(xs, xs, 'k--', 'LineWidth', 2.5);

% plot([d1 d1], ylim, 'k:');
% plot([d2 d2], ylim, 'k:');
plot(d1, 0, 'ro', 'MarkerSize', 8, 'LineWidth', 2);
plot(d2, 0, 'ro', 'MarkerSize', 8, 'LineWidth', 2);
text(d1, 0, '  d_1', 'VerticalAlignment', 'bottom', 'FontSize', 12);
text(d2, 0, '  d_2', 'VerticalAlignment', 'bottom', 'FontSize', 12);

xlabel('x_t');
ylabel('x_{t+1}');
title(sprintf('FIGURE 4(a): Graph of T(x),  d_1=%.2f, d_2=%.2f, \\alpha=%.2f',d1, d2, alpha));
grid on;
legend('T(x)', 'identity line', 'Location', 'NorthWest');