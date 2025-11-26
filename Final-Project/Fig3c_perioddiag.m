%% FIGURE 3(c) – Period Diagram vs Alpha

clear; 
close all;
clc;

SetGraphics;

d1 = 0.2; 
d2 = 0.7;
alpha_vals = linspace(0,0.99,1000);
nIter = 1200; nTrans = 800;
maxP = 12;

periods = zeros(size(alpha_vals));

for k = 1:length(alpha_vals)
    alpha = alpha_vals(k);
    m = 1 - alpha;
    x = 0.5;
    
    % iterate
    for it = 1:nIter
        x = Tmap(x,d1,d2,m);
        if it == nTrans
            tail = zeros(1,nIter-nTrans);
        end
        if it > nTrans
            tail(it-nTrans) = x;
        end
    end
    periods(k) = detectPeriod(tail, maxP);
end

figure('Position',[200 200 650 450]);
scatter(alpha_vals, periods, 10, periods, 'filled');
xlabel('\alpha'); ylabel('Period');
title('FIGURE 3(c) – Minimal period vs \alpha');
colormap(jet); colorbar; grid on;
ylim([-1 maxP+1]);
