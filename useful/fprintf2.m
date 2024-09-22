function fprintf2(fid, varargin)
% Output to the file or to the screen

    if isempty(fid)
        fprintf(varargin{:});
    else
        fprintf(fid, varargin{:});
    end

end

