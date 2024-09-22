function [x0, idx0] = find_zero_cross(x)
% Find points at which vector crosses zero
% Input
% x - vector
% Output
% x0 - values of x at zero intersections
% idx0 - indices of x0

idx0 = find((x(2:end) .* x(1:end-1)) < 0);
x0 = x(idx0);

end

