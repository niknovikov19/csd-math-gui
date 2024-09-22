function M = create_symm_fixed_indegree_mat(N, Kin)

	M = zeros(N,N);
	
	while 1
		
		% Current in-degree vector
		Kvec = sum(M,2);
		
		% Rows with the required in-degree
		idx = find(Kvec ~= Kin);
		L = length(idx);
		
		% Ready
		if L==0
			break;
		end
		
		% Cannot add one more symmetrical connection - restart
		if L==1
			%fprintf('retry (1)\n');
			M = zeros(N,N);
			continue;
		end
		
		% Check if we can add more connections
		M1 = M(idx,idx);
		if sum(M1(:)==0)==L
			%fprintf('retry (2)\n');
			M = zeros(N,N);
			continue;
		end
		
		% Add new symmetrical connection
		idx2 = randperm(L, 2);
		id1 = idx(idx2(1));
		id2 = idx(idx2(2));
		M(id1,id2) = 1;
		M(id2,id1) = 1;
		
	end
	
	M = sparse(M);
	
end