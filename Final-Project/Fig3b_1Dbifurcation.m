%% FIGURE 3(b) – 1D Bifurcation Diagram (Exact Paper Map)

clear; 
close all; 
clc;

d1 = 0.2%0.12;
d2 = 0.7%0.38;

alpha_vals = linspace(0,0.99,1600);
nIter = 1500;
nTrans = 800;
x0 = 0.5;

bifA = [];
bifX = [];

for ai = 1:length(alpha_vals)
    alpha = alpha_vals(ai);
    m = 1 - alpha;
    x = x0;
    for it = 1:nIter
        x = Tmap(x,d1,d2,m);
        if it > nTrans
            bifA(end+1) = alpha;
            bifX(end+1) = x;
        end
    end
end

SetGraphics;

figure('Position',[200 200 700 500]);
plot(bifA, bifX, '.', 'MarkerSize',4, 'Color',[0 0 0]);
xlabel('\alpha'); ylabel('x');
title('FIGURE 3(b) – Bifurcation Diagram');
ylim([0 1]);
grid on;

%% ---- Eq. for 2-cycle borders from paper ----
alpha2s = (1 - 2*d2)/(1 - d2);
alpha2f = 2 - 1/d2;
hold on;
plot([alpha2s alpha2s], [0 1], 'r--');
plot([alpha2f alpha2f], [0 1], 'r--');

% function xnext = Tmap_local(x, d1, d2, m)
%     if x==d1 || x==d2
%         xnext = x;
%     elseif x < d1 || x > d2
%         xnext = m*x;
%     elseif x > d1 && x < d2
%         xnext = m*x + (1-m);
%     end
% end
