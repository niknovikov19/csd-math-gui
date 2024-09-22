function x = fix_angle(x)
% Maps an angle onto (-pi,pi)

x = mod(x, 2*pi);

mask = (x > pi);
x(mask) = x(mask) - 2*pi;

end

