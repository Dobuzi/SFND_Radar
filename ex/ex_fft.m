Fs = 1e3;
T = 1/Fs;
L = 1500;
t = (0:L-1) * T;

% TODO : f = 77 Hz, A = 0.7 / f = 43 Hz, A = 2
S = 0.7 * sin(2*pi*77*t) + 2 * sin(2*pi*43*t);

% Add noise on signal
X = S + 2 * rand(size(t));

% Draw the signal on time domain
plot(1000*t(1:50), X(1:50))
title('Signal Corrupted with Zero-Mean Random Noise')
xlabel('t (milliseconds)')
ylabel('X(t)')

% Compute the Fourier transform
X_fft = fft(X, L);
P2 = abs(X_fft/L);
P1 = P2(1:L/2+1);

% Plotting after fft
f = Fs * (0:(L/2)) / L;
plot(f, P1)
title('Single-sided Amplitude Spectrum of X(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')