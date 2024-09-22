function d = calc_deriv_2arg(f, x1, x2, arg_num, h)
% Calculate partial derivative of a given function at given points
% f - function
% x1 - points of interest (1-st argument of f)
% x2 - points of interest (2-nd argument of f)
% arg_num - number of argument (1 or 2) by which to take derivative
% h - approximation step

if arg_num==1
	d = (f(x1+h,x2) - f(x1-h,x2)) / (2*h);
elseif arg_num==2
	d = (f(x1,x2+h) - f(x1,x2-h)) / (2*h);
else
	assert(0==1);
end

end

