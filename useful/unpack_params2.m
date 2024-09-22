function unpack_params2(params, fldnames)
% Read structure and create local variables with names and values of its parameters

if ~exist('fldnames', 'var')
	fldnames = fieldnames(params);
end

for n = 1 : length(fldnames)
	
	par_name = fldnames{n};
	par_val = params.(par_name);
    
    assignin('caller', par_name, par_val);
	
end


end

