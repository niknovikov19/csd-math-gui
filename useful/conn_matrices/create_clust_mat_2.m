function M = create_clust_mat_2(Nclust, Nnodes_clust, K_clust, p_inter)

	% Number of nodes
	N = Nclust * Nnodes_clust;
	
	% Connectivity and conn type matrices
	M = zeros(N,N);
	T = zeros(N,N);
	
	% Generate within-cluster connections
	for n = 1 : Nclust
		
		% Node indices for this cluster
		idx = (n-1) * Nnodes_clust + [1 : Nnodes_clust];
		
		% Generate connections for this cluster
		M(idx,idx) = create_symm_fixed_indegree_mat(Nnodes_clust, K_clust);
		
		T(idx,idx) = 1;
		
	end
	
	% Generate within-cluster connections
	M_inter = (rand(N,N) < p_inter/2);
	M_inter = (M_inter + M_inter') > 0;
	M_inter = M_inter .* (T == 0);
	for n = 1 : N
		M_inter(n,n) = 0;
	end
	
	% Resulting matrix
	M = M + M_inter;
	
% 	figure;
% 	imagesc(M);
% 	axis image
	
end