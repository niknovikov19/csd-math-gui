function X = unpack_contour_mat(C)
% C - contour matrix
% X - cell array containing line segments

	X = {};
	n = 1;

	if isempty(C)
		return;
	end

	while 1==1

		% Segment length
		N = C(2,n);

		% Current segment
		X{end+1} = C(:,n+1:n+N);

		% Update position
		n = n + N + 1;
		if n >= size(C,2)
			break;
		end

	end

end
