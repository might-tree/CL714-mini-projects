%% FIGURE 4(b) – 2D Diagram of alpha-bar(d1, d2)
clear; 
close all; 
clc;
SetGraphics;

Nd = 300;  
d1_vals = linspace(0,1,Nd); 
d2_vals = linspace(0,1,Nd);

AlphaBar = nan(Nd, Nd);

for i = 1:Nd      
    for j = 1:Nd   

        d1 = d1_vals(j);
        d2 = d2_vals(i);

        % Only valid upper-left domain 0 < d1 < d2 < 1
        if d1 < d2
            alpha_bar = (d2-d1)/d2;%1 - d2;
            if alpha_bar >= 0 && alpha_bar <= 1
                AlphaBar(i,j) = alpha_bar;
            end
        end
    end
end

figure('Position',[200 200 700 550]);
imagesc(d1_vals, d2_vals, AlphaBar);
set(gca,'YDir','normal');

xlabel('d_1');
ylabel('d_2');
title('FIGURE 4(b) - \bar{\alpha}(d_1, d_2)');

colormap(jet); 
c = colorbar;
c.Label.String = '\bar{\alpha}';

% Make NaN region white (clean triangular plot)
set(gca,'Color',[1 1 1]);

