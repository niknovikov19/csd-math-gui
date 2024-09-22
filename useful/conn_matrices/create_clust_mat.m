function M = create_clust_mat(Nclust, Nnodes_clust, p_clust, p_inter)

	% Number of nodes
	N = Nclust * Nnodes_clust;
	
	% Pair type matrix (1 - within-cluster, 0 - inter-cluster)
	T = zeros(N,N);
	
	% Mark within-cluster pairs of nodes
	for n = 1 : Nclust
		clust_node_idx = (n-1) * Nnodes_clust + [1 : Nnodes_clust];
		T(clust_node_idx, clust_node_idx) = 1;
	end

	% Generate connectivity matrix
	M_clust = (rand(N,N) < p_clust/2) .* (T == 1);
	M_inter = (rand(N,N) < p_inter/2) .* (T == 0);
	M = M_clust + M_inter;
	
	% Make symmetric and remove the diagonal
	M = (M + M') > 0;
	for n = 1 : N
		M(n,n) = 0;
	end
	
% 	figure;
% 	imagesc(M);
% 	axis image
	
end