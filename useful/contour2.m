function h = contour2(Q, Qlims, r, dash_step, dash_len, varargin)
% Plot contour with dashes at one side
% Input:
% Q - matrix used to find contours, determine the side of line to add dashes
% (will be added to the side with positive Q)
% or Q is a scalar (+1 or -1), which explicitly determines the side
% Qlims = [Qx_min, Qy_min, Qx_max, Qy_max] - coordinates of borders of Q
% r - distance from a line at which we should look in Q
% dash_step - distance between dashes
% dash_len - length of each dash
% Output:
% h - handle of last contour segment


Qx = linspace(Qlims(1), Qlims(3), size(Q,2));
Qy = linspace(Qlims(2), Qlims(4), size(Q,1));

% Find contours
C = contourc(Qx, Qy, Q, [0 0]);

pos = 1;

h = [];

% Cycle over contours
while pos <= size(C,2)
   
    % Get contour points
    contour_len = C(2,pos);
    xvals = C(1, pos+1 : pos+contour_len);
    yvals = C(2, pos+1 : pos+contour_len);
    
    % Plot contour
    h = plot_rgn_borders(xvals, yvals, Q, Qlims, r, dash_step, dash_len, varargin{:});
    
    % Update contour starting position
    pos = pos + contour_len + 1;
    
end


end

