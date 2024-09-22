function h = plot_rgn_borders(xvals, yvals, Q, Qlims, r, dash_step, dash_len, varargin)
% Plot line given by (xvals, yvals), and add dashes to the one side of the line
% Input:
% (xvals, yvals) - line to plot
% Q - matrix used to determine the side of line to add dashes
% (will be added to the side with positive Q)
% or Q is a scalar (+1 or -1), which explicitly determines the side
% Qlims = [Qx_min, Qy_min, Qx_max, Qy_max] - coordinates of borders of Q
% r - distance from a line at which we should look in Q
% dash_d - distance between dashes
% dash_step - length of each dash
% Output:
% h - handle of line

h = [];

if(length(xvals) ~= length(yvals))
    return;
end

if length(xvals) < 2
    return;
end

hold_old = ishold;

% Plot given line
h = plot(xvals, yvals, varargin{:});
hold on;

if isscalar(Q)
    % Normalize Q
    Q = Q / abs(Q);
else
    % Create grid that corresponds to the cells of Q
    Qx = linspace(Qlims(1), Qlims(3), size(Q,2));
    Qy = linspace(Qlims(2), Qlims(4), size(Q,1));
    [Qxx Qyy] = meshgrid(Qx, Qy);
end

% Number of line nodes
nnodes = length(xvals);

node_id_cur = 1;

% Coordinates of nodes between which we now plot dashes
x0 = xvals(node_id_cur);
y0 = yvals(node_id_cur);
x1 = xvals(node_id_cur+1);
y1 = yvals(node_id_cur+1);

% Coordinates of a point from which we plot current dash
xcur = x0;
ycur = y0;

while 1==1   
    
    % Find unit normal to the current line segment
    nx = y1 - y0;
    ny = x0 - x1;
    nr = sqrt(nx^2 + ny^2);
    nx = nx / nr;
    ny = ny / nr;
    
    % Find unit vector parallel to the current line segment
    vx = -ny;
    vy = nx;
    
    % Find vector from the current point to the end of line segment
    Vx = x1 - xcur;
    Vy = y1 - ycur;
    
    % Check Q at each side of a line or use the side given by scalar Q
    if isscalar(Q)
        
        xprime_vis = xcur + nx * dash_len * Q;
        yprime_vis = ycur + ny * dash_len * Q;
        plot([xcur xprime_vis], [ycur yprime_vis], varargin{:});
        
    else
        
        for s = [-1 1]

            % Step from current point by r along normal to the current side
            xprime = xcur + nx * r * s;
            yprime = ycur + ny * r * s;

            % Find closest point in the Q matrix grid
            d = (xprime - Qxx).^2 + (yprime - Qyy).^2;
            [~,id] = min(d(:));
            [id1,id2] = ind2sub(size(d), id);

            % If value in Q is positive - plot dash
            if Q(id1,id2) > 0
                xprime_vis = xcur + nx * dash_len * s;
                yprime_vis = ycur + ny * dash_len * s;
                plot([xcur xprime_vis], [ycur yprime_vis], varargin{:});
            end

        end
        
    end
    
    % Find next node that is farther that dash_step from current point
    need_stop = 0;
    while 1==1        
        
        % Distance from the node to the current point
        R = sqrt((x1 - xcur).^2 + (y1 - ycur).^2);
        
        % Appropriate node found
        if R >= dash_step
            break;
        end
        
        % No more nodes to check - terminate the procedure
        if node_id_cur == (nnodes-1)
            need_stop = 1;
            break;
        end
        
        % Go to the next node
        node_id_cur = node_id_cur + 1;
        x0 = xvals(node_id_cur);
        y0 = yvals(node_id_cur);
        x1 = xvals(node_id_cur+1);
        y1 = yvals(node_id_cur+1);
        
    end
    
    if need_stop
        break;
    end
    
    % Find next point
    a = (x1 - x0)^2 + (y1 - y0)^2;
    b = 2 * ((x1 - x0) * (x0 - xcur) + (y1 - y0) * (y0 - ycur));
    c = (x0 - xcur)^2 + (y0 - ycur)^2 - dash_step^2;
    Drt = sqrt(b^2 - 4*a*c);
    if ~isreal(Drt)
        assert(0==1);
    end
    t = (-b + Drt) / (2*a);
    xnew = x0 + t * (x1 - x0);
    ynew = y0 + t * (y1 - y0);
    
    %{
    t2 = (-b - Drt) / (2*a);
    xnew2 = x0 + t2 * (x1 - x0);
    ynew2 = y0 + t2 * (y1 - y0);
    figure(300); clf; hold on;
    plot([x0 x1], [y0 y1]);
    plot(xcur,ycur,'k.');
    plot(xnew,ynew,'ko');
    plot(xnew2,ynew2,'mo');
    plot(x0,y0,'r.');
    plot(x1,y1,'b.');
    syms x y;
    ezplot((x-xcur)^2+(y-ycur)^2==dash_step^2);
    dd = 0.5;
    xlim([min([x0,x1,xcur])-dd, max([x0,x1,xcur])+dd]);
    ylim([min([y0,y1,ycur])-dd, max([y0,y1,ycur])+dd]);
    drawnow;
    waitforbuttonpress;
    %pause(1);
    %break;
    %}
    
    xcur = xnew;
    ycur = ynew;
    
end

if ~hold_old
    hold off;
end


end

