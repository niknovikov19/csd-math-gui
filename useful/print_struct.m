function print_struct(s, fid, tb)
% Print structure fields

init_var('fid', '[]');
init_var('tb', '''''');

fldnames = fieldnames(s);

for n = 1 : length(fldnames);
    
    fldname = fldnames{n};    
    x = getfield(s, fldname);
	print_field(x, fldname, fid, tb);

end

end


function print_field(x, fldname, fid, tb)

delim = '  ';

fprintf2(fid, '%s%s:  ', tb, fldname);
	
if isstruct(x)
	
	fprintf2(fid, '%sSTRUCT\n', tb);
	tb1 = [tb, delim];
	for m = 1 : length(x)
		fprintf2(fid, '%sstruct %i:\n', tb1, m);
		print_struct(x(m), fid, tb1);
	end
	
else
	
	if isnumeric(x)
		x = x(:);
		if length(x) < 5
			fprintf2(fid, '%s%s\n', tb, sprintf('%.06f ', x));
		else
			fprintf2(fid, '%s%.06f ... %.06f  (n = %i)  [%.06f; %.06f]  M = %.06f\n',...
				tb, x(1), x(end), length(x), min(x), max(x), mean(x));
		end
		
	elseif isstr(x)
		fprintf2(fid, '%s%s\n', tb, x);
		
	elseif iscellstr(x)
		if length(x) < 5
			fprintf2(fid, '%s%s\n', tb, sprintf('%s ', x{:}));
		else
			fprintf2(fid, '%s%s ... %s\n', tb, x{1}, x{end});
		end
		
	elseif iscell(x)
		fprintf2(fid, '%sCELL\n', tb);
		tb1 = [tb, delim];
		for m = 1 : length(x)
			print_field(x{m}, sprintf('cell %i', m), fid, tb1);
		end
		
	else
		fprintf2(fid, '%s<some data>\n', tb);
	end
	
end

end
