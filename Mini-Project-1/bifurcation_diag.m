clear
close all
clc

% Parameters
a = 2;                          % exponent
s_vals = linspace(-5,5,1000);   % sweep s from -∞ to ∞

% Store equilibria
x0 = zeros(size(s_vals)); % branch at x=0
x1 = ones(size(s_vals));  % branch at x=1
xstar = nan(size(s_vals)); % interior equilibrium
stab0 = nan(size(s_vals)); % stability of x=0
stab1 = nan(size(s_vals)); % stability of x=1
stabstar = nan(size(s_vals)); % stability of x*

for i = 1:length(s_vals)
    s = s_vals(i);

    % Interior equilibrium
    if a ~= 1
        xx = 1 / (1 + (s/(1-s))^(1/(a-1)));
        if isreal(xx) && xx >= 0 && xx <= 1
            xstar(i) = xx;
        end
    end
    
    % Stability: f'(x*) sign test
    % Define f(x) as anonymous function
    f = @(x) x.*(1-x).*( s - x.^(a-1)./(x.^(a-1)+(1-x).^(a-1)) );
    df = @(x) (f(x+1e-6)-f(x-1e-6))/(2e-6); % numerical derivative
    
    stab0(i)    = sign(df(0+1e-6));  % near x=0
    stab1(i)    = sign(df(1-1e-6));  % near x=1
    if ~isnan(xstar(i))
        stabstar(i) = sign(df(xstar(i)));
    end
end

% Plot bifurcation diagram
figure; hold on;

% x=0 branch
plot(s_vals(stab0<0), x0(stab0<0), 'k-', 'LineWidth',1.5) % stable
plot(s_vals(stab0>0), x0(stab0>0), 'k--','LineWidth',1.5) % unstable

% x=1 branch
plot(s_vals(stab1<0), x1(stab1<0), 'b-', 'LineWidth',1.5)
plot(s_vals(stab1>0), x1(stab1>0), 'b--','LineWidth',1.5)

% interior branch
plot(s_vals(stabstar<0), xstar(stabstar<0), 'r-', 'LineWidth',2)
plot(s_vals(stabstar>0), xstar(stabstar>0), 'r--','LineWidth',2)

xlabel('Bifurcation parameter s')
ylabel('Fixed points x_{ss}')
title('Bifurcation diagram of Language Competition Model')
legend({'x=0 stable','x=0 unstable','x=1 stable','x=1 unstable','x^* stable','x^* unstable'}, 'Location','best')
grid on; box on;












% clear
% close all
% clc
% 
% % Parameters
% a = 2;                    % exponent
% s_vals = linspace(-10,10,5000);
% 
% % Fixed points
% x0 = zeros(size(s_vals)); % x=0 branch
% x1 = ones(size(s_vals));  % x=1 branch
% xstar = nan(size(s_vals)); % interior equilibrium
% 
% for i = 1:length(s_vals)
%     s = s_vals(i);
%     if a ~= 1
%         xstar(i) = (s/(1-s))^(1/(a-1)) / (1 + (s/(1-s))^(1/(a-1)));
%     end
% end
% 
% % Plot
% figure; hold on;
% 
% plot(s_vals, x0, 'k-','LineWidth',1.2); % boundary branch (x=0)
% plot(s_vals, x1, 'b-','LineWidth',1.2); % boundary branch (x=1)
% plot(s_vals, xstar, 'r','LineWidth',1.2);  % interior branch
% 
% xlabel('Status parameter s');
% ylabel('Equilibrium proportion x^*');
% title('Bifurcation diagram of Language Competition Model');
% legend({'x=0','x=1','x^*'}, 'Location','best');
% grid on; box on;
