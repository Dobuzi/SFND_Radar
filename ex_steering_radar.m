c = 3e8;
f = 77e9;
lambda = c/f;
d = lambda / 2;
phi = 45; % in deg

theta_rad = asin(phi / 360 / d * lambda);
theta = theta_rad * 180 / pi;

disp(theta);