function params = set_par_by_name(params, par_name, par_val)
% Set value of a parameter by its name
% params - array of structures ('par_name', 'par_val')

par_names = {params.par_name};
par_id = find(strcmp(par_name, par_names));

% If parameter does not exist yet - add it, otherwise - replace its value
if isempty(par_id)
	params(end+1) = struct('par_name', par_name, 'par_val', par_val);
else
	params(par_id).par_val = par_val;
end

end

