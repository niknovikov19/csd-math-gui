function M = create_clust_mat_3(Nclust, Nnodes_clust, K_clust, K_inter)

	if length(Nnodes_clust) == 1
		Nnodes_clust = Nnodes_clust * ones(1,Nclust);
	end
	
	if length(K_clust) == 1
		K_clust = K_clust * ones(1,Nclust);
	end
	
	if length(K_inter) == 1
		K_inter = K_inter * ones(Nclust,Nclust);
	end

	% Number of nodes
	N = sum(Nnodes_clust);
	
	% Connectivity matrix
	M = zeros(N,N);
	
	% Generate within-cluster connections
	for n = 1 : Nclust
		
		% Node indices for this cluster
		idx = sum(Nnodes_clust(1:n-1)) + [1 : Nnodes_clust(n)];
		
		% Generate connections for this cluster
		M(idx,idx) = create_symm_fixed_indegree_mat(Nnodes_clust(n), K_clust(n));
		
	end
	
	% Generate within-cluster connections
	for n = 1 : Nclust
		for m = (n+1) : Nclust
			
			% Select nodes from each cluster to connect
			idx1_ = randperm(Nnodes_clust(n), K_inter(n,m));
			idx2_ = randperm(Nnodes_clust(m), K_inter(n,m));
			
			% Absolute indices of these nodes
			idx1 = sum(Nnodes_clust(1:n-1)) + idx1_;
			idx2 = sum(Nnodes_clust(1:m-1)) + idx2_;
			
			% Connect the nodes
			for k = 1 : K_inter(n,m)
				M(idx1(k), idx2(k)) = 1;
				M(idx2(k), idx1(k)) = 1;
			end
			
		end
	end
	
% 	figure;
% 	imagesc(M);
% 	axis image
	
end