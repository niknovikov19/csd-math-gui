function open_fig(id, title, mode)

init_var('id', '[]');
init_var('title', '[]');
init_var('mode', '''fs''');

if isempty(id)
    figure;
else
    figure(id);
end

if ~isempty(title)
    set(gcf, 'name', title);
end

if strcmp(mode, 'fs')
    set(gcf, 'units', 'normalized', 'outerposition', [0 0.05 1 0.95]);
    %set(gcf, 'units', 'normalized', 'outerposition', [0 0.05 0.6 0.5]);
end

end

