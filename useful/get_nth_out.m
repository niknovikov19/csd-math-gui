function x = get_nth_out(f, x, n)
% Get n-th output value of a function
% f - function
% x - cell array of arguments of f
% n - number of output to return

if ~iscell(x)
	x = {x};
end

N = nargout(f);
s = cell(1,N);
[s{:}] = f(x{:});
x = s{n};

end

