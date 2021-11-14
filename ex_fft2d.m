Fs = 1000;
T = 1 / Fs;
L = 1500;
t = (0:L-1)*T;

S = 0.7 * sin(2*pi*50*t) + sin(2*pi*120*t);

X = S + 2 * randn(size(t));

figure(1);
tiledlayout(1, 2)

nexttile
plot(1000*t(1:50), X(1:50))
title('Signal corrupted with Zero-Mean Random Noise')
xlabel('t (milliseconds)')
ylabel('X(t)')

Y = fft(X);

P2 = abs(Y/L);
P1 = P2(1:L/2+1);

f = Fs * (0:(L/2))/L;

nexttile
plot(f, P1)
title('Single-Sided Amplitude Spectrum of X(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')

% Part 2 - 2D FFT

M = length(X) / 50;
N = length(X) / 30;

X_2d = reshape(X, [M, N]);

figure(2);
tiledlayout(1, 2)

nexttile
imagesc(X_2d)

% TODO : Compute the 2D FFT
Y_2d = fft2(X_2d);

% TODO : plot here
nexttile
imagesc(abs(fftshift(Y_2d)))

saveas(gcf, 'fft_2d.png')