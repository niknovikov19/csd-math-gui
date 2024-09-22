function w = calc_halfwidth(x, y)
% Calculate width of x-interval on each y is abouve its half-height

ymin = min(y);
[ymax,id_max] = max(y);

thresh = (ymin + ymax) / 2;

idx = find(y(1:id_max) <= thresh);
id1 = idx(end);

idx = id_max + find(y(id_max+1:end) >= thresh);
id2 = idx(end);

w = x(id2) - x(id1);

%{
figure; hold on;
plot(x,y);
plot(x(id1)*[1,1], [ymin,ymax]);
plot(x(id2)*[1,1], [ymin,ymax]);
%}

end

