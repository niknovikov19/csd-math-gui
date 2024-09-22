function s = par_to_struct(params)
% Convert (name,value) pairs into a structure

s = struct();

for n = 1 : length(params)
	par_name = params(n).par_name;
	par_val = params(n).par_val;
    s.(par_name) = par_val;
end

end

