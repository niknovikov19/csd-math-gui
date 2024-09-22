

f = @(x)sin(x);

xmin = -5;
xmax = 5;
ymin = -5;
ymax = 5;

x = linspace(-5, 5, 100);
y = linspace(-5, 5, 100);
[xx, yy] = meshgrid(x,y);

Q = (yy < f(xx)) - 0.5;
Qlims = [xmin, ymin, xmax, ymax];

%Q = Q*0+1;

xvals = linspace(-5, 5, 100);
yvals = f(xvals);

r = 0.5;
dash_step = 0.2;
dash_len = 0.2;
%plot_rgn_borders(xvals, yvals, Q, Qlims, r, dash_step, dash_len)
plot_rgn_borders(xvals, yvals, -1, [], r, dash_step, dash_len)
