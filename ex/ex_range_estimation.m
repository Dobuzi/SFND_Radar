range_max = 300;
range_resolution = 1;
c = 3e8;

% TODO : B_sweep
B_sweep = c / 2 / range_resolution;

% TODO : T_chirp
T_chirp = 5.5 * 2 * range_max / c;

% TODO : f_shift
f_shift = [0, 1.1e6, 13e6, 24e6];

calculated_range = c * T_chirp * f_shift / 2 / B_sweep;

disp(calculated_range);