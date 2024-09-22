function M = create_smallworld_mat(N, K)

	M = zeros(N,N);
	
	for n = 1 : N
		
		for k = 1 : K
			
			m = mod(n+k-1, N) + 1;
			
			M(n,m) = 1;
			M(m,n) = 1;
			
		end
		
	end

	M = sparse(M);
	
end