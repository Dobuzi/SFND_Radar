close all;

Fs = 1000;
T = 1/Fs;
L = 1500;
t = (0:L-1)*T;

S = 0.7 * sin(2*pi*50*t) + sin(2*pi*120*t);

X = S + 2 * randn(size(t));

X_cfar = abs(X);

Ns = 1500;

X_cfar([100, 200, 300, 700]) = [16 18 27 22];

figure(1);
tiledlayout(2, 1);
nexttile
plot(X_cfar)

% TODO : Define the number of Training Cells, Guard Cells and offset
T = 30;
G = 4;
offset = 5;

threshold_cfar = zeros(Ns-(G+T+1), 1);
signal_cfar = zeros(Ns-(G+T+1), 1);

for i = 1:(Ns-(G+T+1))
    noise_level = sum(X_cfar(i:i+T-1));
    threshold = noise_level/T * offset;
    threshold_cfar(i) = threshold;
    if X_cfar(i+T+G) > threshold
        signal = X_cfar(i+T+G);
    else
        signal = 0;
    end
    signal_cfar(i) = signal;
end

plot(signal_cfar);
legend('Signal')

nexttile
plot(X_cfar);
hold on
plot(circshift(threshold_cfar, G), 'r--', 'LineWidth', 2);
hold on
plot(circshift(signal_cfar, (T+G)), 'g--', 'LineWidth', 2);
legend('Signal', 'CFAR Threshold', 'detection')