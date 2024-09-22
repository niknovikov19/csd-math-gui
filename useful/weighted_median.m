function [wm, id] = weighted_median(data, weights)
    % Ensure data and weights are column vectors
    data = data(:);
    weights = weights(:);
    
    % Sort data and weights
    [sorted_data, sort_index] = sort(data);
    sorted_weights = weights(sort_index);
    
    % Compute cumulative sum of weights
    cum_weights = cumsum(sorted_weights);
    
    % Find the index where cumulative weight exceeds half of total weight
    id = find(cum_weights >= 0.5*sum(weights), 1, 'first');
    
    % Return the corresponding data value
    wm = sorted_data(id);
end
