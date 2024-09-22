function Y = get_submat(X, dim_idx, coords)
% Get submatrix of X with coordinates by dimensions dim_idx given by coords

if ~iscell(coords)
	coords = {coords};
end

ndims = length(size(X));

idx = repmat({':'}, 1, ndims);

for n = 1 : length(dim_idx)
	idx{dim_idx(n)} = coords{n};
end

Y = X(idx{:});

end

