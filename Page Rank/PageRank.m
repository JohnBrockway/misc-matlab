% function [p, iters] = PageRank(G, alpha)
%
% Computes the Google Page-rank for the network in the adjacency matrix G.
%
% Input
%   G is an adjacency matrix, G(i,j) = 1 iff node j projects to node i
%   alpha is a scalar between 0 and 1
%
% Output
%   p is a probability vector containing the Page-rank of each node
%   iters is the number of iterations used to achieve a tolerance of 1e-8
%
function [p, iters] = PageRank(G, alpha)
 
    R = size(G,1);  % number of nodes
    p = ones(R,1)/R;
    e = ones(R,1);
    dT = ones(1,R);
    iters = 0;
    
    % Create d-transpose: starts as a vector of 1s; if there is an outgoing
    % path for a node, set that node's entry to zero
    for i = 1:R
        for j = 1:R
            if G(j, i) > 0
                dT(i) = 0;
                break
            end
        end 
    end
    
    % Turn the adjacency matrix G into a probability matrix by dividing
    % each column by the sum of its elements
    for i = 1:R
        column = G(:, i);
        total = sum(column);
        if total ~= 0
            column = column/total;
        end
        G(:, i) = column;
    end
    
    while 1 == 1
        q = (alpha*(G*p)) + (alpha/R)*e*(dT*p) + ((1 - alpha)/R)*e;
        iters = iters + 1;

        % Check biggest change in the probability vector to see if it is
        % less than the tolerance, meaning we can return
        maxDist = abs(q(1) - p(1));
        for i = 2:R
            if abs(q(i) - p(i)) > maxDist
                maxDist = abs(q(i) - p(i));
            end
        end

        p = q;

        if maxDist < 1e-8
            break
        end
    end    