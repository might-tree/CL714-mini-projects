%% FIGURE 3(d) – 2D Basin of Attraction: alpha vs x0 (period-coded)

clear; 
close all; 
clc;

SetGraphics;

d1 = 0.2; 
d2 = 0.7;
Nalpha = 400;                         % resolution in alpha
alpha_vals = linspace(0,1,Nalpha);    % α ∈ [0,1]
Nx0 = 400;
x0_vals = linspace(0,1,Nx0);          % x0 ∈ [0,1]

maxit = 2000;
trans = 1400;
maxP = 12;

PeriodMap = zeros(Nx0, Nalpha);

fprintf("Computing 2D basin map...\n");
tic;
for ia = 1:Nalpha
    alpha = alpha_vals(ia);
    m = 1 - alpha;
    for ix = 1:Nx0
        x = x0_vals(ix);
        for t = 1:maxit
            x = Tmap(x, d1, d2, m);
            if t == trans
                tail = zeros(1, maxit-trans);
            end
            if t > trans
                tail(t-trans) = x;
            end
        end
        p = detectPeriod(tail, maxP);
        PeriodMap(ix, ia) = p;
    end
end
toc;

figure('Position',[200 200 750 550]);
imagesc(alpha_vals, x0_vals, PeriodMap);
set(gca,'YDir','normal');

colormap(jet);
c = colorbar; 
c.Label.String = 'Detected Period (-1 = non-periodic)';

xlabel('\alpha');
ylabel('Initial condition x_0');
title('FIGURE 3(d): 2D Basin of Attraction (Period-coded)');