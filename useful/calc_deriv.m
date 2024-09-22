function d = calc_deriv(f, x0, h)
% Calculate 1-st derivative of a given function at given points
% f - function
% x0 - points of interest
% h - approximation step

d = (f(x0+h) - f(x0-h)) / (2*h);

end

