% 
% Check the Four-connectivity of an pixel and get the middle image
%
% The input is a binary image (ImgIn), and it has four outputs: Segmented image without
% label (ImgOut), the number of all segemented parts (c), 's' and 't' are adjacent
% parts that needed to be combined

function [ImgOut, c, s, t] = FourConnect(ImgIn)
    s = [];
    t = [];
    % Expand the image from N*N to (N+1)*(N+1) to check all the pixels of
    % the original image
    ImgIn = Expand(ImgIn);
    c = 1;
    [m, n] = size(ImgIn);
    ImgOut = zeros([m, n]);
    % From the second row and the second column to do the traversal
    % For 8-conncetivity, you need to check all surrounding pixels, like
    % ImgIn(i,j), ImgIn(i-1,j), ImgIn(i,j-1), ImgIn(i-1,j-1), and the
    % segmented parts must be less than 4-connectivity labeled parts
    for i = 2:1:m
        for j = 2:1:n
            
            if ImgIn(i,j) == 1 && ImgIn(i-1,j) == 0 && ImgIn(i,j-1) == 0
                ImgOut(i,j) = c;
                c = c + 1;
            elseif ImgIn(i,j) == 1 && ImgIn(i-1,j) == 1 && ImgIn(i,j-1) == 0
                ImgOut(i,j) = ImgOut(i-1,j);
            elseif ImgIn(i,j) == 1 && ImgIn(i-1,j) == 0 && ImgIn(i,j-1) == 1
                ImgOut(i,j) = ImgOut(i,j-1);
            elseif ImgIn(i,j) == 1 && ImgIn(i-1,j) == 1 && ImgIn(i,j-1) == 1
                ImgOut(i,j) = ImgOut(i-1,j);
                % Every time you find adjacent parts with different labels,
                % you should save their labels to 's' and 't'
                s(end+1) = ImgOut(i-1,j);
                t(end+1) = ImgOut(i,j-1);
            end
            
        end
    end
    % The output image is (N+1)*(N+1), and it needs to be shrinked to N*N,
    % and it's the Middle Image of the whole processing
    ImgOut = Shrink(ImgOut);
    % c-1 is the final number of segmented parts
    c = c-1;
end

