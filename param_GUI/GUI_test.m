function GUI_test

% Position

x = 100;
y = 50;

edit_w = 80;
edit_h = 20;

margin = 5;

% Parameters

param_id = 13;
param_name = 'J';

val_0 = -1;
val_inc = 0.1;

% Create UI's
figure;
uicontrol('Style', 'text', 'Tag', sprintf('text_%i', param_id), 'Position', [x, y+0.8*edit_h, edit_w, edit_h], 'String', param_name);
uicontrol('Style', 'edit', 'Tag', sprintf('edit_%i', param_id), 'Position', [x, y, edit_w, edit_h], 'String', num2str(val_0), 'Callback', {@cb_edit, param_id});
uicontrol('Style', 'slider', 'Tag', sprintf('slider_%i', param_id), 'Position', [x+edit_w+margin, y, edit_h-1, edit_h],...
	'Value', 0, 'Max', val_inc, 'Min', -val_inc, 'SliderStep', [1,1], 'Callback', {@cb_slider, param_id});

end


function cb_edit(hObject, callbackdata, param_id)

str = get(hObject, 'String');
val = str2num(str);
if isempty(val)
	set(hObject, 'String', '');
	return;
end

fprintf('%i: %f\n', param_id, val);

end

function cb_slider(hObject, callbackdata, param_id)

	% Get increment (+val_inc / -val_inc / 0)
	inc = get(hObject, 'Value');
	
	% Reset Slider 
	set(hObject, 'Value', 0);
	
	% Set updated value in the edit box
	hEdit = findobj('Tag', 'edit_13');
	val = str2num(get(hEdit, 'String'));
	set(hEdit, 'String', num2str(val+inc));

end

