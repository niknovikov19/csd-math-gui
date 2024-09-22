function s = pack_params2(par_names)
% Create structure from local variables with names and values of its parameters

% If called without argument - pack all variables from the caller scope
if ~exist('par_names', 'var')
	par_names = evalin('caller', 'who');
end

s = struct();

for n = 1 : length(par_names)
	s.(par_names{n}) = evalin('caller', par_names{n});	
end

end

