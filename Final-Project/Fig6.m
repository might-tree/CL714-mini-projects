%% FIGURE 6 – period maps
clear; 
close all; 
clc;

SetGraphics;

%% Common settings
maxP = 12;         % max period to detect
maxit = 2000;      % total iterations per (x0,alpha)
trans = 1500;      % transient to discard
tol_unique = 1e-9;

% helper inline to print progress
pr = @(s) fprintf('%s\n',s);

%% ---------------- Fig 6(a) ----------------
% d1=0.1, d2=0.3; alpha sweep coarse
d1 = 0.1; d2 = 0.3;
pr('Computing Fig 6(a) ...');
Nalpha = 400; alpha_vals = linspace(0,1,Nalpha);
Nx0 = 400; x0_vals = linspace(0,1,Nx0);

PeriodMap_a = -ones(Nx0, Nalpha); % -1 => no period found / aperiodic

for ia = 1:Nalpha
    alpha = alpha_vals(ia); m = 1-alpha;
    for ix = 1:Nx0
        x = x0_vals(ix);
        for t = 1:maxit
            x = Tmap_eq13(x,d1,d2,m);
            if t==trans, tail = zeros(1,maxit-trans); end
            if t>trans, tail(t-trans)=x; end
        end
        p = detectPeriod(tail, maxP);
        PeriodMap_a(ix, ia) = p;
    end
end

figure('Name','Fig6a','NumberTitle','off','Position',[100 100 700 520]);
imagesc(alpha_vals, x0_vals, PeriodMap_a);
set(gca,'YDir','normal'); colormap(parula);
xlabel('\alpha'); ylabel('x_0');
title('Fig 6(a): period-coded (d_1=0.1, d_2=0.3)');
c = colorbar; c.Label.String = 'Detected period (-1 = none)';
% ylim([0 1]);

%% ---------------- Fig 6(b) ----------------
% d1=0.1, d2=0.2; alpha sweep coarse
d1 = 0.1; d2 = 0.2;
pr('Computing Fig 6(b) ...');
Nalpha = 400; alpha_vals = linspace(0,1,Nalpha);
Nx0 = 400; x0_vals = linspace(0,1,Nx0);

PeriodMap_a = -ones(Nx0, Nalpha); % -1 => no period found / aperiodic

for ia = 1:Nalpha
    alpha = alpha_vals(ia); m = 1-alpha;
    for ix = 1:Nx0
        x = x0_vals(ix);
        for t = 1:maxit
            x = Tmap_eq13(x,d1,d2,m);
            if t==trans, tail = zeros(1,maxit-trans); end
            if t>trans, tail(t-trans)=x; end
        end
        p = detectPeriod(tail, maxP);
        PeriodMap_a(ix, ia) = p;
    end
end

figure('Name','Fig6b','NumberTitle','off','Position',[100 100 700 520]);
imagesc(alpha_vals, x0_vals, PeriodMap_a);
set(gca,'YDir','normal'); colormap(parula);
xlabel('\alpha'); ylabel('x_0');
title('Fig 6(a): period-coded (d_1=0.1, d_2=0.2)');
c = colorbar; c.Label.String = 'Detected period (-1 = none)';
% ylim([0 1]);

%% ---------------- Fig 6(c) ----------------
% Uses extrema of long-run attractor, solid/dotted based on stability.

pr('Computing Fig 6(c) ...');

d1 = 0.1; 
d2 = 0.2;

alpha_vals = linspace(0,1,350);
Nalpha      = numel(alpha_vals);

maxit = 1600;
trans  = 1200;

Nx0 = 60;                    % MANY initial conditions per alpha
x0_vals = linspace(0,1,Nx0);

Xmin = zeros(1,Nalpha);
Xmax = zeros(1,Nalpha);
isStable = false(1,Nalpha);

for ia = 1:Nalpha

    alpha = alpha_vals(ia);
    m = 1 - alpha;

    % Collect all attractor points across many ICs
    all_points = [];

    for ix = 1:Nx0

        x = x0_vals(ix);

        for t = 1:maxit
            x = Tmap_eq13(x,d1,d2,m);
            if t == trans
                tail = zeros(1,maxit-trans);
            elseif t > trans
                tail(t-trans) = x;
            end
        end

        all_points = [all_points, tail]; %#ok<AGROW>
    end

    % Envelope
    Xmin(ia) = min(all_points);
    Xmax(ia) = max(all_points);

    % ---- Stability: check dominant slope on branch ----
    slope_outer = m;
    slope_inner = m + (1-m)/(d2-d1);

    % Where does the envelope sit?
    xmid = 0.5*(Xmin(ia)+Xmax(ia));

    if xmid > d1 && xmid < d2
        isStable(ia) = abs(slope_inner) < 1;
    else
        isStable(ia) = abs(slope_outer) < 1;
    end

end

figure('Name','Fig6c','Position',[200 200 750 450]); hold on;

% stable ranges (solid)
idxS = find(isStable);
plot(alpha_vals(idxS), Xmin(idxS),'k-','LineWidth',1.8);
plot(alpha_vals(idxS), Xmax(idxS),'k-','LineWidth',1.8);

% unstable ranges (dashed)
idxU = find(~isStable);
plot(alpha_vals(idxU), Xmin(idxU),'k--','LineWidth',1.2);
plot(alpha_vals(idxU), Xmax(idxU),'k--','LineWidth',1.2);

xlabel('\alpha'); ylabel('x');
title('Fig 6(c): Bifurcation skeleton (d_1=0.1, d_2=0.2)');
grid on;



% % same (d1,d2) but perhaps different alpha window or resolution to show chaos
% d1 = 0.1; d2 = 0.2;
% pr('Computing Fig 6(c) ...');
% alpha_vals = linspace(0.85,0.99,600);  % high-alpha region often chaotic/fragmented
% Nx0 = 600; x0_vals = linspace(0,1,Nx0);
% 
% PeriodMap_c = -ones(Nx0, length(alpha_vals));
% for ia = 1:length(alpha_vals)
%     alpha = alpha_vals(ia); m = 1-alpha;
%     for ix = 1:Nx0
%         x = x0_vals(ix);
%         for t = 1:maxit
%             x = Tmap_eq13(x,d1,d2,m);
%             if t==trans, tail = zeros(1,maxit-trans); end
%             if t>trans, tail(t-trans)=x; end
%         end
%         p = detectPeriod(tail, maxP);
%         PeriodMap_c(ix, ia) = p;
%     end
% end
% 
% figure('Name','Fig6c','NumberTitle','off','Position',[100 660 700 520]);
% imagesc(alpha_vals, x0_vals, PeriodMap_c);
% set(gca,'YDir','normal'); colormap(parula);
% xlabel('\alpha'); ylabel('x_0');
% title('Fig 6(c): period-coded (d_1=0.1, d_2=0.2) — high alpha');
% c = colorbar; c.Label.String = 'Detected period (-1 = none)';
% ylim([0 1]);

%% ---------------- Fig 6(d) ----------------
% d1=0.3, d2=0.4 alpha sweep, shows fragmentation
d1 = 0.3; d2 = 0.4;
pr('Computing Fig 6(d) ...');
Nalpha = 500; alpha_vals = linspace(0,1,Nalpha);
Nx0 = 600; x0_vals = linspace(0,1,Nx0);

PeriodMap_d = -ones(Nx0, Nalpha);
for ia = 1:Nalpha
    alpha = alpha_vals(ia); m = 1-alpha;
    for ix = 1:Nx0
        x = x0_vals(ix);
        for t = 1:maxit
            x = Tmap_eq13(x,d1,d2,m);
            if t==trans, tail = zeros(1,maxit-trans); end
            if t>trans, tail(t-trans)=x; end
        end
        p = detectPeriod(tail, maxP);
        PeriodMap_d(ix, ia) = p;
    end
end

figure('Name','Fig6d','NumberTitle','off','Position',[820 660 700 520]);
imagesc(alpha_vals, x0_vals, PeriodMap_d);
set(gca,'YDir','normal'); colormap(parula);
xlabel('\alpha'); ylabel('x_0');
title('Fig 6(d): period-coded (d_1=0.3, d_2=0.4)');
c = colorbar; c.Label.String = 'Detected period (-1 = none)';
ylim([0 1]);

%% ---------------- Fig 6(e) ----------------
% Plot x_{t+1} vs x_t for d1=0.3 d2=0.4 at alpha=0.2585
d1 = 0.3; d2 = 0.4; alpha = 0.2585; m = 1-alpha;
pr('Plotting Fig 6(e) map ...');

xs = linspace(0,1,1200);
Tvals = zeros(size(xs));
for i = 1:length(xs)
    Tvals(i) = Tmap_eq13(xs(i), d1, d2, m);
end

% Plot branches separately to avoid vertical connecting lines
T1 = nan(size(xs)); T2 = nan(size(xs)); T3 = nan(size(xs));
for i = 1:length(xs)
    x = xs(i);
    if x <= d1
        T1(i) = Tvals(i);
    elseif x >= d2
        T3(i) = Tvals(i);
    else
        T2(i) = Tvals(i);
    end
end

figure('Name','Fig6e','NumberTitle','off','Position',[400 300 600 500]);
plot(xs, T1, 'b', 'LineWidth', 1.6); hold on;
plot(xs, T2, 'b', 'LineWidth', 1.6);
plot(xs, T3, 'b', 'LineWidth', 1.6);
plot(xs, xs, 'k--', 'LineWidth', 1.2);  % identity
% mark d1,d2 at x axis and on curve
plot(d1, Tmap_eq13(d1,d1,d2,m),'ro','MarkerFaceColor','r');
plot(d2, Tmap_eq13(d2,d1,d2,m),'ro','MarkerFaceColor','r');
text(d1, -0.03, ' d_1', 'HorizontalAlignment','left');
text(d2, -0.03, ' d_2', 'HorizontalAlignment','left');
xlabel('x_t'); ylabel('x_{t+1}');
title(sprintf('Fig 6(e): Map (d1=%.2f,d2=%.2f,\\alpha=%.4f)', d1,d2,alpha));
xlim([0 1]); ylim([0 1]); grid on;

pr('Done. All Fig 6 panels generated.');

%% ---------------- Helper functions ----------------
function xnext = Tmap_eq13(x, d1, d2, m)
    % Eq. (13) style map (with special-case equality)
    if x == d1 || x == d2
        xnext = x;
        return;
    end
    if x < d1 || x > d2
        xnext = m * x;
    else
        % interior special affine: mx + (1-m)
        xnext = m * x + (1 - m);
    end
end

function p = detectPeriod(traj, maxp)
    % detect minimal period up to maxp; returns -1 if none found
    tol = 1e-6;
    p = -1;
    N = length(traj);
    for per = 1:maxp
        if N < 2*per, continue; end
        tail = traj(end-per+1:end);
        prev = traj(end-2*per+1:end-per);
        if max(abs(tail - prev)) < tol
            p = per;
            return;
        end
    end
end
