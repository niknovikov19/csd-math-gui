function [A, phi] = calc_fresp(x, t, f)
% Calculate amplitude of a harmonic of given frequency in a signal

dt = t(2) - t(1);
T = t(end) - t(1);

% Basis function
u = cos(2*pi*f*t)';
v = sin(2*pi*f*t)';

% Remove baseline
x = x - mean(x);
x = x(:);

% Frequency response
wu = sum(x.*u) * 2*dt/T;
wv = sum(x.*v) * 2*dt/T;

A = sqrt(wu^2 + wv^2);
phi = atan2(wv, wu);

end

