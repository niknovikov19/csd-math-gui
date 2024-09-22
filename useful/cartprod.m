function result = cartprod(ranges)
% Cartesian product

ranges = ranges(end:-1:1);

c = cell(1, numel(ranges));
[c{:}] = ndgrid(ranges{:});
result = cell2mat( cellfun(@(v)v(:), c, 'UniformOutput',false) );

result = result(:,end:-1:1);

end