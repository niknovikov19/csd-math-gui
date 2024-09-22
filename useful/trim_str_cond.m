function str = trim_str_cond(str, c)
% Remove given symbol from the end of string

if str(end) == c
    str = str(1:end-1);
end

end

