function [idx_best, dmin] = minimize_vec_dist(D, method, nreps)
% Shuffles columns of matrix in order to minimize trace
% [idx, dmin] = minimize_vec_dist(D, method)
% D - dissimilarity matrix
% method = 'ordmin' -- pass coordinates one by one
% method = 'globmin' -- find min in matrix, then go to submatrix
% method = 'full' -- use all possible permutations
% nreps -- number of algorithm repeats with initially permuted columns
% idx_best - shuffled indices of coordinates that yield "mimimum" of mean distance
% between vectors


init_var('method', '''globmin''');
init_var('nreps', '1');


nclust = size(D,1);

D0 = D;


idx = zeros(1,nclust);      % Order of shuffled columns
idx_best = zeros(1,nclust); % Order of shuffled columns (best over initial permutation)

dmin = 1e10;


for m = 1 : nreps
    
    
    % Randomly permute columns of matrix
    idx0 = randperm(nclust);
    D = D0(:,idx0);
    

    if strcmp(method, 'globmin')

        D1 = D;             % Current submatrix

        idx_cur1 = [1 : nclust];    % Rows passed to the current step
        idx_cur2 = [1 : nclust];    % Columns passed to the current step

        for k = 1 : nclust

            % Coordinates minimum element in current submatrix (relative to D1)
            [M, id] = min(D1(:));
            [n1,n2] = ind2sub(size(D1),id);

            % Coordinates of minimum element relative to initial matrix D
            n1_abs = idx_cur1(n1);
            n2_abs = idx_cur2(n2);

            % Appent column shuufling rules
            idx(n1_abs) = n2_abs;

            szcur = nclust - k + 1;
            range1 = [1:(n1-1), (n1+1):szcur];
            range2 = [1:(n2-1), (n2+1):szcur];

            % Discard found element from rows and columns that will pass to the next step
            idx_cur1 = idx_cur1(range1);
            idx_cur2 = idx_cur2(range2);

            % Discard found element from matrix that will be used at the next step
            D1 = D1(range1, range2);

        end

    end

    if strcmp(method, 'ordmin')

        idx_unused = [1 : nclust];

        for m = 1 : nclust

            dvec = D(idx_unused, m);
            [dd id_rel] = min(dvec);

            idx(m) = idx_unused(id_rel);

            idx_unused = idx_unused([1:id_rel-1, id_rel+1:end]);

        end

    end

    if strcmp(method, 'full')

        idx_perm = perms(1:nclust);

        dmin_avg = 1e10;
        nbest = [];

        for n = 1 : size(idx_perm,1)

            D1 = D(:,idx_perm(n,:));    
            davg = mean(diag(D1));
            if davg < dmin_avg
                dmin_avg = davg;
                nbest = n;
            end

        end

        idx = idx_perm(nbest,:);

    end

    % Calculate trace for current found shuffling
    D1 = D(:,idx);
    dmin_cur = sum(diag(D1));
    
    % If result is better than at previous initial permutations -- keep it
    if dmin_cur < dmin
        dmin = dmin_cur;
        idx_best = idx0(idx);   % initial permutation + found shuffling
    end
    
end


% Calculate trace for best shuffling
D1 = D0(:,idx_best);
dmin = sum(diag(D1));


end

