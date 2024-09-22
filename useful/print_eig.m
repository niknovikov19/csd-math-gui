function print_eig(lambda)
% Print eigenvalues

% Remove complex conjugates
idx = find(imag(lambda) < 0);
lambda(idx) = [];
%[~,idx] = unique(real(lambda));
%lambda = lambda(idx);

% Sort eigenvalues by its real parts
[~,idx] = sort(real(lambda), 'descend');
lambda = lambda(idx);

% Print
for n = 1 : length(lambda)
	fprintf('tau = %.04f ms  f = %.04f Hz\n', 1000./real(lambda(n)), imag(lambda(n))/(2*pi));
end

end

