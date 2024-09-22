function pts_xyz_out = project_2d_pts_to_3d_line(line_xyz, pts_xyz)
% For each 2d point from pts_xyz (one of coords is NaN) find a point on a 3d polyline line_xyz with the closets projection to the 2d subspace
% Inputs:
% line_xyz - vertices of the polyline (nvertices x 3)
% pts_xyz - points of interest (npoints x 3)
% For each point from pts_xyz, one of its coordinates is NaN

	% Number of points of interest
	npts = size(pts_xyz,1);
	
	% Allocate output
	pts_xyz_out = NaN * ones(npts,3);

	for n = 1 : npts
		
		% Coordinates 1 and 2 of the point are given, coordinate 3 has to be reconstructed
		if isnan(pts_xyz(n,3))
			pt_xyz_out = project_xy_pts_to_xyz_line(line_xyz, pts_xyz(n,[1,2]));
		elseif isnan(pts_xyz(n,1))
			pt_xyz_out = project_xy_pts_to_xyz_line(line_xyz(:,[2,3,1]), pts_xyz(n,[2,3]));
			pt_xyz_out = pt_xyz_out([3,1,2]);
		elseif isnan(pts_xyz(n,2))
			pt_xyz_out = project_xy_pts_to_xyz_line(line_xyz(:,[1,3,2]), pts_xyz(n,[1,3]));
			pt_xyz_out = pt_xyz_out([1,3,2]);
		end

		% Store the result
		pts_xyz_out(n,:) = pt_xyz_out;
		
	end

end

% Code for one point
function pt_xyz_out = project_xy_pts_to_xyz_line(line_xyz, pt_xy)
	
	pt1_xy = pt_xy;
	line1_xy = line_xyz(:,[1,2]);
			
	% Vectors connecting points of the projected line
	d = line1_xy(2:end,:) - line1_xy(1:end-1,:);
	
	% Vectors connecting point of interest with points of the projected line
	D = bsxfun(@minus, pt1_xy, line1_xy(1:end-1,:));
	
	% t(i) is the distance from line1_xy(i,:) 
	% to the point of projection of pt1_xy to the segment line1_xy(i+1,:)-line1_xy(i,:)
	t = (d(:,1).*D(:,1) + d(:,2).*D(:,2)) ./ (d(:,1).^2 + d(:,2).^2);
	
	% Find projections of pt1_xy to the segments
	proj_xy = line1_xy(1:end-1,:) + bsxfun(@times, t, d);
	
	% Find line segments such that the projection of pt1_xy to them lies inside them
	idx = find((t>=0) & (t<=1));
	
	% Find a segment with minimal distance to pt1_xy
	proj_xy = proj_xy(idx,:);
	h = bsxfun(@minus, pt1_xy, proj_xy);
	L = h(:,1).^2 + h(:,2).^2;
	[~,id_min] = min(L);
	
	% Vectors connecting points of the initial line
	dxyz = line_xyz(2:end,:) - line_xyz(1:end-1,:);
	
	% Get the result
	t = t(idx);
	line_xyz = line_xyz(idx,:);
	dxyz = dxyz(idx,:);
	t_best = t(id_min);
	pt_xyz_out = line_xyz(id_min,:) + dxyz(id_min,:) * t(id_min);

end
