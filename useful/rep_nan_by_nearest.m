function X = rep_nan_by_nearest(X)
% Replace NaN's in a matrix by non-NaN values in the closest bins

d = ndims(X);

% Coordinates of NaN's
nan_coords = cell(1,d);
[nan_coords{:}] = ind2sub(size(X), find(isnan(X)));
nan_coords = [nan_coords{:}];

% Coordinates of no-NaN's
num_coords = cell(1,d);
[num_coords{:}] = ind2sub(size(X), find(~isnan(X)));
num_coords = [num_coords{:}];

for n = 1 : size(nan_coords,1)
    
    nan_coords_cur = nan_coords(n,:);
    
    % Distance from this NaN-bin to all no-NaN-bins
    D = bsxfun(@minus, num_coords, nan_coords_cur);
    D = mean(D.^2, 2);
    [~,idx_sort] = sort(D);
    
    % Coordinates of the closest no-NaN-bin
    num_coords_best = num_coords(idx_sort(1),:);
    
    % Replace NaN
    num_coords_best = num2cell(num_coords_best);
    nan_coords_cur = num2cell(nan_coords_cur);
    X(nan_coords_cur{:}) = X(num_coords_best{:});
    
end

end

