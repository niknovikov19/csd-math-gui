
eps_vals = 10.^linspace(-10,-3,20);

D = [];

for n = 1 : length(eps_vals)
	D(n) = Du(1i*eps_vals(n), 0);
end

figure;
plot(log(eps_vals), D);