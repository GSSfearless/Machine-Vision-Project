%
% Get the labeled iamge from the middle image
%
% This part doesn't care about 4-connectivity or 8-connectity. Inputs are
% segmented middle image (ImgIn), number of segmented parts (c), adjacent parts that
% needed to be combined (s and t). Outputs are labeled image (ImgOut) and
% number of labels (label)
% 

function [ImgOut, label] = Label(ImgIn, c, s, t)
    % Get the graph of 's' and 't'
    G = graph(s,t);
    % Array L is used to save segmented parts and corresponding labels
    L = zeros(2,c);
    % The first label is 1
    label = 1;

    for p = 1:1:c
        % The function of dfsearch is to visit all nodes (segmented parts)
        % of the middle image and check their neighbor nodes. The return of
        % dfsearch(G, p) is its neighbor nodes of the visited node
        % https://www.mathworks.com/help/matlab/ref/graph.dfsearch.html?s_tid=doc_ta
        v = dfsearch(G,p);
        L(1,p) = p; 
        % If there is no neighbor nodes of this visited node, it means this
        % segmented part has no adjacent parts with different segment
        % numbers. So this part could be labeled by a new number
        if isempty(v)
            L(2,p) = label;
            label = label + 1;
        % If this visited node has neighbor nodes
        else
            % Check if this node has been labeled, L(2,p) == 0 means it has
            % no label. If this node has a label, then check the next one.
            if L(2,p) == 0
                % 'd' is the number of neighbor nodes
                d = length(v);
                % Every neighbor nodes is labeled by the same number
                for q = 1:d
                    L(1,v(q)) = v(q);
                    L(2,v(q)) = label;
                end
            label = label + 1;
            end
        end
    end
    
    [m, n] = size(ImgIn);
    ImgOut = zeros([m,n]);
    label = label -1;
   
    % Check the original image (middle image) and give every segmented
    % parts their corresponding labels
    for i = 1:1:m
        for j = 1:1:n
            if ImgIn(i,j) ~= 0
                a = ImgIn(i,j);
                ImgOut(i,j) = L(2,a);
            end
        end
    end
end


