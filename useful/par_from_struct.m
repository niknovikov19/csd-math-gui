function params = par_from_struct(s)
% Convert a structure into (name,value) pairs

params = struct('par_name', {}, 'par_val', {});

fldnames = fieldnames(s);

for n = 1 : length(fldnames)	
	par_name = fldnames{n};
	par_val = s.(par_name);
    params(end+1) = struct('par_name', par_name, 'par_val', par_val);
end

