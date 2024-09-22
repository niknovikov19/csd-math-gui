function P = InterX_contour(C1, C2)
% Perform InterX() for contour matrices

P = [];

X1 = unpack_contour_mat(C1);
X2 = unpack_contour_mat(C2);

for n1 = 1 : length(X1)
	for n2 = 1 : length(X2)
		P = [P, InterX(X1{n1}, X2{n2})];
	end
end			

end




