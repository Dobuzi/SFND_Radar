c = 3e8;
f = 77e9;

% TODO : wavelength
lambda = c / f;

% TODO : the doppler shifts in Hz
f_d = [3e3, -4.5e3, 11e3, -3e3];

% TODO : velocity of the targets
v_r = f_d * lambda / 2;

disp(v_r);