function params = del_params(params, par_names)

mask = cellfun(@(x)any(strcmp(x, par_names)), {params.par_name});
params = params(~mask);

end

