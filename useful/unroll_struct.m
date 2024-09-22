function unroll_struct(struct_name)
% Create variables from fields of structure

eval_str = sprintf('fieldnames(%s);', struct_name);
fldnames = evalin('caller', eval_str);

for n = 1 : length(fldnames)
   
    fld_name = fldnames{n};
    eval_str = sprintf('%s = %s.%s;', fld_name, struct_name, fld_name);
    evalin('caller', eval_str);
    
end

end

