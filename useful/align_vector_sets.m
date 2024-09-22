function idx_best = align_vector_sets(V1, V2)
% V1 and V2 contain vectors in their columns
% idx_best is the permutation of columns of V2 that yields the best match to V1

N = size(V1,2);

idx_list = perms([1:N]);

dvec = zeros(1,size(idx_list,1));

is_scalar = (size(V1,1)==1);

for n = 1 : size(idx_list,1)
	
	idx = idx_list(n,:);
	V2perm = V2(:,idx);
	
	D = abs(V1 - V2perm).^2;
	dvec(n) = nanmean(D(:));
	
	% Discard non-matching of NaN's
	if is_scalar
		N1 = sum(isnan(V1) | isnan(V2perm));
		N2 = max(sum(isnan(V1)), sum(isnan(V2perm)));
		if N1 > N2
			dvec(n) = Inf;
		end
	end
	
end

[~,nbest] = min(dvec);
idx_best = idx_list(nbest,:);

end

