function [idx1_adj ,idx2_adj] = get_adj_points(id1, id2, id1_max, id2_max)
% Get indices of the points from the 3x3 neighbourhood

d_vec = [-1, 0, 1];

idx1_adj = [];
idx2_adj = [];

for n1 = 1:3
	for n2 = 1:3
	
		id1_cur = id1 + d_vec(n1);
		id2_cur = id2 + d_vec(n2);
		
		if (id1_cur > 0) && (id2_cur > 0)
			if (id1_cur <= id1_max) && (id2_cur <= id2_max)
				idx1_adj(end+1) = id1_cur;
				idx2_adj(end+1) = id2_cur;
			end
		end
			
	end
end

end

