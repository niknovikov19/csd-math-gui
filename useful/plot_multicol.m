function plot_multicol(x, y, c, lw)

init_var('lw', '2');

z = zeros(size(x));

surface([x;x],[y;y],[z;z],[c;c],...
        'facecol','no',...
        'edgecol','interp',...
        'linew',lw);
end

