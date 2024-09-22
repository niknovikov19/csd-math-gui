function M = create_fixed_indegree_mat(Nout, Nin, Kin, allow_self_conn)

	if ~exist('allow_self_conn', 'var')
		allow_self_conn = 1;
	end

	M = zeros(Nout,Nin);
	M(:,1:Kin) = 1;
	for n = 1 : Nout
		
% 		if mod(n,10)==0
% 			fprintf('%i / %i\n', n, Nout);
% 		end
		
		while 1
			M(n,:) = M(n,randperm(Nin));
			if allow_self_conn || (M(n,n) == 0)
				break;
			end
		end
		
	end			
	
	M = sparse(M);
	
end