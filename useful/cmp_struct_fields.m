function [res, mask] = cmp_struct_fields(s1, s2, fldnames)
% Compare given fields of structures and return equality mask

init_var('fldnames', '{}');

if isempty(fldnames)
    fldnames = fieldnames(s1);
end

mask = zeros(1, length(fldnames));

for n = 1 : length(fldnames)

    fldname = fldnames{n};
    
    if ~isfield(s1, fldname) || ~isfield(s2, fldname)
        continue;
    end
        
    x1 = getfield(s1, fldname);
    x2 = getfield(s2, fldname);
    
    if (isstruct(x1) && ~isstruct(x2)) || (~isstruct(x1) && isstruct(x2))
        continue;
    end
    
    if isstruct(x1) && isstruct(x2)
        
        if length(x1) ~= length(x2)
            continue;
        end
        
        b = 1;
        
        for m = 1 : length(x1)
            b = b * cmp_struct_fields(x1(m), x2(m));
        end
        
        mask(n) = b;
        
    elseif isempty(x1) && isempty(x2)
        
        mask(n) = 1;
        
    elseif same(x1,x2)
        
        mask(n) = 1;
        
    end
    
end

res = all(mask);

% Print mismatches
%{
fprintf('Mismatching fiels:\n')
for n = 1 : length(fldnames)
	if ~mask(n)
		fprintf('%s\n', fldnames{n});
	end
end
%}

end

