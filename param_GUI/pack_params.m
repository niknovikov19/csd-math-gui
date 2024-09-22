function params = pack_params(par_names, params)
% Create or append structure with parameter (name,value) pairs from the list of local variable names

% Create empty param structure array
if ~exist('params', 'var')
	params = struct('par_name', {}, 'par_val', {});
end
	
% Pack all variables from the caller context if other is not specified
if ~exist('par_names', 'var')
	par_names = evalin('caller', 'who');
end

for n = 1 : length(par_names)
   
    par_name = par_names{n};
    par_val = evalin('caller', par_name);
    
    if iscell(par_val)
        par_val = {par_val};
	end
	
	% Look for this param name in the existing array
	id = find(strcmp(par_name, {params.par_name}));
	if isempty(id)
		id = length(params) + 1;
	end
    
	% Add / rewrite parameter
    params(id) = struct('par_name', par_name, 'par_val', par_val);
    
end

end

