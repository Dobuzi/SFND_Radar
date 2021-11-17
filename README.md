# SFND_Radar

Final Project of Radar with Matlab for SFND

## Dependency

-   Matlab 2021b

## Result

1. Set up the Initial Position and Velocity

    ```matlab
    R = 100;
    v = -10;
    ```

2. Design the FMCW waveform

    ```matlab
    c = 3e8; % m/s
    R_max = 200; % m
    R_res = 1; % m
    v_max = 100; % m/s
    B = c / (2 * R_res); % Hz
    Tchirp = 5.5 * 2 * R_max / c; % s
    slope = B / Tchirp; % s^-2
    ```

3. Make the signal

    ```matlab
    for i=1:length(t)
        r_t (i) = R + v * t(i);
        td (i) = 2*r_t(i) / c;

        Tx(i) = cos(2*pi*(fc*t(i) + slope*t(i)^2 / 2));
        Rx(i) = cos(2*pi*(fc*(t(i) - td(i)) + slope*(t(i) - td(i))^2 / 2));
    end

    Mix = Tx.*Rx; % Signal with beat frequencies
    ```

4. FFT

    ```matlab
    Mix = reshape(Mix, [Nr, Nd]); % Make signal from vector to 2D matrix

    sig_fft = fft(Mix); % FFT-Processing the signal

    P2 = abs(sig_fft/Nr); % Take the absolute value

    P1 = P2(1:Nr/2+1); % Make the single-sided result
    ```

    <img src="img/fft.png">

5. FFT 2D

    ```matlab
    Mix=reshape(Mix,[Nr,Nd]);

    sig_fft2 = fft2(Mix,Nr,Nd); % 2D FFT

    sig_fft2 = sig_fft2(1:Nr/2,1:Nd); % single-sided result
    sig_fft2 = fftshift (sig_fft2); % Shift the result
    RDM = abs(sig_fft2); % Take the absolute value
    RDM = 10*log10(RDM); % Make the logarithmic result for dB unit
    ```

    <img src="img/fft2d.png">

6. 2D CFAR

-   Select the number of Training Cells, Guard Cells, offset(dB)

    ```matlab
    Tr = 20; % Training Cell in range
    Td = 10; % Training Cell in doppler
    Gr = 8;  % Guard Cell in range
    Gd = 4;  % Guard cell in doppler
    offset = 6; % dB
    ```

-   Make the loop for filtering with threshold

    ```matlab
    for i = 1:(Nr/2-(2*Gr+2*Tr+1)) % Iterate on range dir
        for j = 1:(Nd-(2*Gd+2*Td+1)) % Iterate on doppler dir
            noise_T = sum(db2pow(RDM(i:i+2*Tr+2*Gr-1, j:j+2*Td+2*Gd-1)), 'all');
            noise_G = sum(db2pow(RDM(i+Tr:i+Tr+2*Gr-1, j+Td:j+Td+2*Gd-1)), 'all');
            noise_level(i,j) = noise_T - noise_G; % Make noise level in power

            % Make threshold value in dB
            threshold_CFAR(i,j) = pow2db(noise_level(i,j)/size_T) + offset;

            % Filter the value with threhold in binary (1, 0)
            if RDM(i+Tr+Gr,j+Td+Gd) > threshold_CFAR(i,j)
                signal_CFAR(i+Tr+Gr,j+Td+Gd) = 1;
            end
        end
    end
    ```

    <img src="img/2D_CFAR.png">
