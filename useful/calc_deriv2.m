function d2 = calc_deriv2(f, x0, h)
% Calculate 2-nd derivative of a given function at given points
% f - function
% x0 - points of interest
% h - approximation step

d2 = (f(x0+h) - 2*f(x0) + f(x0-h)) / h^2;

end

