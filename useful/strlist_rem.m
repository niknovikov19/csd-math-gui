function lst = strlist_rem(lst, lst_rem)
% Remove string list etries

for n = 1 : length(lst_rem)
	idx = find(strcmp(lst_rem{n}, lst));
	if ~isempty(idx)
		lst(idx) = [];
	end
end

end
