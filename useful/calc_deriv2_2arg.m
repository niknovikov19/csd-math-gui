function d2 = calc_deriv2_2arg(f, x1, x2, arg_num, h)
% Calculate partial 2-nd derivative of a given function at given points
% f - function
% x1 - points of interest (1-st argument of f)
% x2 - points of interest (2-nd argument of f)
% arg_num - number of argument [1=[1,1] | 2=[2,2] | [1,2] | [2,1]) by which to take derivative
% h - approximation step(s)

if length(arg_num)==1
	arg_num = arg_num*[1,1];
end

if length(h)==1
	h = h*[1,1];
end

if all(arg_num==[1,1])
	d2 = (f(x1+h(1),x2) - 2*f(x1,x2) + f(x1-h(1),x2)) / h(1)^2;
elseif all(arg_num==[2,2])
	d2 = (f(x1,x2+h(2)) - 2*f(x1,x2) + f(x1,x2-h(2))) / h(2)^2;
elseif all(arg_num==[1,2]) || all(arg_num==[2,1])
	d2 = (f(x1+h(1),x2+h(2)) + f(x1-h(1),x2-h(2)) - f(x1-h(1),x2+h(2)) - f(x1+h(1),x2-h(2))) / (4*h(1)*h(2));
else
	assert(0==1);
end

end

