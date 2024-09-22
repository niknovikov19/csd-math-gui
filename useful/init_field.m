function s = init_field(s, fldname, val)
% Initialize structure field if it doesn't exist

if ~isfield(s, fldname)
    s = setfield(s, fldname, val);
end

end

