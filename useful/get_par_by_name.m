function par_val = get_par_by_name(params, par_name)
% Get value of a parameter by its name
% params - array of structures ('par_name', 'par_val')

par_names = {params.par_name};
par_id = find(strcmp(par_name, par_names));

if isempty(par_id)
	par_val = [];
	return;
end

par_val = params(par_id).par_val;

end

