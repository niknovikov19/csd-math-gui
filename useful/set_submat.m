function X = set_submat(X, Y, dim_idx, coords)
% Set submatrix of X with coordinates by dimensions dim_idx given by coords to the matrix Y

if ~iscell(coords)
	coords = {coords};
end

ndims = length(size(X));

idx = repmat({':'}, 1, ndims);

for n = 1 : length(dim_idx)
	idx{dim_idx(n)} = coords{n};
end

X(idx{:}) = Y;

%idx_1 = repmat({':'}, 1, dim_id - 1);
%idx_2 = repmat({':'}, 1, ndims - dim_id);
%X(idx_1{:}, coords, idx_2{:}) = Y;

end

