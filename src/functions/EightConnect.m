% 
% Check the Eight-connectivity of an pixel and get the middle image
%
% The input is a binary image (ImgIn), and it has four outputs: Segmented image without
% label (ImgOut), the number of all segemented parts (c), 's' and 't' are adjacent
% parts that needed to be combined

function [ImgOut, c, s, t] = EightConnect(ImgIn)
    s = [];
    t = [];
    % Expand the image from N*N to (N+1)*(N+1) to check all the pixels of
    % the original image
    ImgIn = padarray(ImgIn, [1 1], 0);
    c = 1;
    [m, n] = size(ImgIn);
    ImgOut = zeros([m, n]);
    % From the second row and the second column to do the traversal
    % For 8-conncetivity, you need to check all surrounding pixels, like
    % ImgIn(i,j), ImgIn(i-1,j), ImgIn(i,j-1), ImgIn(i-1,j-1), and the
    % segmented parts must be less than 4-connectivity labeled parts
    for i = 2:1:m
        for j = 2:1:(n-1)
          
            if ImgIn(i,j) == 1
                Total = ImgIn(i-1,j-1)+ImgIn(i-1,j)+ImgIn(i-1,j+1)+ImgIn(i,j-1);
                switch Total
                    case 0
                        ImgOut(i,j) = c;
                        c = c + 1;
                    case 1
                        ImgOut(i,j) = max([ImgOut(i-1,j-1),ImgOut(i-1,j),ImgOut(i-1,j+1),ImgOut(i,j-1)]);
                    case 2
                        ImgOut(i,j) = max([ImgOut(i-1,j-1),ImgOut(i-1,j),ImgOut(i-1,j+1),ImgOut(i,j-1)]);
                        temp = ImgOut;
                        t(end+1) = max([temp(i-1,j-1),temp(i-1,j),temp(i-1,j+1),temp(i,j-1)]);
                        % Set values of 0 or less to infinity so that we
                        % can find the smallest label
                        temp(temp == 0) = max([temp(i-1,j-1),temp(i-1,j),temp(i-1,j+1),temp(i,j-1)]);
                        s(end+1) = min([temp(i-1,j-1),temp(i-1,j),temp(i-1,j+1),temp(i,j-1)]);

                    case 3
                        ImgOut(i,j) = max([ImgOut(i-1,j-1),ImgOut(i-1,j),ImgOut(i-1,j+1),ImgOut(i,j-1)]);
                        temp = ImgOut;
                        t(end+1) = max([temp(i-1,j-1),temp(i-1,j),temp(i-1,j+1),temp(i,j-1)]);
                        temp(temp == t(end)) = max([temp(i-1,j-1),temp(i-1,j),temp(i-1,j+1),temp(i,j-1)]);
                        % As long as not all the pixels are 0 now, we can
                        % continue
                        if max([temp(i-1,j-1),temp(i-1,j),temp(i-1,j+1),temp(i,j-1)]) > 0
                            t(end+1) = max([temp(i-1,j-1),temp(i-1,j),temp(i-1,j+1),temp(i,j-1)]);
                            % Set values of 0 or less to infinity so that we
                            % can find the smallest label
                            temp(temp == 0) = max([temp(i-1,j-1),temp(i-1,j),temp(i-1,j+1),temp(i,j-1)]);
                            s(end+1) = min([temp(i-1,j-1),temp(i-1,j),temp(i-1,j+1),temp(i,j-1)]);
                            s(end+1) = s(end);
                        else
                            temp(temp == 0) = max([temp(i-1,j-1),temp(i-1,j),temp(i-1,j+1),temp(i,j-1)]);
                            s(end+1) = min([temp(i-1,j-1),temp(i-1,j),temp(i-1,j+1),temp(i,j-1)]);
                        end
                    case 4
                        ImgOut(i,j) = max([ImgOut(i-1,j-1),ImgOut(i-1,j),ImgOut(i-1,j+1),ImgOut(i,j-1)]);
                        temp = ImgOut;
                        for tempcount = 1:3
                            t(end+1) = max([temp(i-1,j-1),temp(i-1,j),temp(i-1,j+1),temp(i,j-1)]);
                            temp(temp == t(end)) = min([temp(i-1,j-1),temp(i-1,j),temp(i-1,j+1),temp(i,j-1)]);
                            temp(temp == 0) = max([temp(i-1,j-1),temp(i-1,j),temp(i-1,j+1),temp(i,j-1)]);
                            s(end+1) = min([temp(i-1,j-1),temp(i-1,j),temp(i-1,j+1),temp(i,j-1)]);
                        end
                end
            end
        end
    end
    % The output image is (N+1)*(N+1), and it needs to be shrunk to N*N,
    % and it's the Middle Image of the whole processing
    ImgOut = ImgOut(2:end-1,2:end-1);
    % c-1 is the final number of segmented parts
    c = c-1;
end

