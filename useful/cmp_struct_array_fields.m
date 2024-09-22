function res = cmp_struct_array_fields(s1, s2, fldnames)
% Compare lengths of two structure arrays and given fields of structures

init_var('fldnames', '{}');

res = 1;

if length(s1) ~= length(s2)
    res = 0;
    return;
end

for n = 1 : length(s1)
    res = res * cmp_struct_fields(s1(n), s2(n), fldnames);
end

end

