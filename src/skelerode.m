% This is the skelerode function created for the ME5405 Computing Project. 
% This function does erosion of a binary image without creating local
% disconnections (skeletonization). It will create an 8-connected
% skeletonized image. This function uses the supplementary custom function
% performerosion.

% Inputs: Unpadded binary image, number of rows in image, number of columns
% in image
% Outputs: Unpadded skeletonized binary image


function MatOutput = skelerode(MatInput, rows, cols)

    % The Structuring elements used for the skeletonization. The 0s
    % represent pixels that must be 0, 1s represent pixels that must be 1,
    % and 2s represent pixels which are ignored.
    SE1 = [0 0 0;2 1 2;1 1 1];
    SE2 = [2 0 0;1 1 0;2 1 2];
    SE3 = [1 2 0;1 1 0;1 2 0]; 
    SE4 = [2 1 2;1 1 0;2 0 0];
    SE5 = [1 1 1;2 1 2;0 0 0];
    SE6 = [2 1 2;0 1 1;0 0 2];
    SE7 = [0 2 1;0 1 1;0 2 1];
    SE8 = [0 0 2;0 1 1;2 1 2];
    
    % Flip the image so that 0 (black) is background for the erosion
    % operation. Also, pad the image so that there is one layer of
    % background pixels on all four sides of the image.
    MatInputFlip = logical(1 - MatInput);
    MatInputPadded = padarray(MatInputFlip, [1 1], 0);
    MatOutputPadded = MatInputPadded;
    
    % Perform a single erosion pass of the whole image using the custom
    % defined function (made by us) called performerosion. Do this pass on
    % each structuring element. 
    while (true)
        MatOutputPrevious = MatOutputPadded;
        MatOutputPadded = performerosion(MatOutputPadded, rows, cols, SE1);
        MatOutputPadded = performerosion(MatOutputPadded, rows, cols, SE2);
        MatOutputPadded = performerosion(MatOutputPadded, rows, cols, SE3);
        MatOutputPadded = performerosion(MatOutputPadded, rows, cols, SE4);
        MatOutputPadded = performerosion(MatOutputPadded, rows, cols, SE5);
        MatOutputPadded = performerosion(MatOutputPadded, rows, cols, SE6);
        MatOutputPadded = performerosion(MatOutputPadded, rows, cols, SE7);
        MatOutputPadded = performerosion(MatOutputPadded, rows, cols, SE8);
        
        % If there is no change to the image after an entire pass through
        % all 8 structuring elements is done, end the loop.
        if (MatOutputPrevious == MatOutputPadded)
            break
        end
    end
    % Unpad the image and flip the binary input so that 1 (white) is 
    % background again, then end this function.
    MatOutput = MatOutputPadded(2:end-1,2:end-1);
    MatOutput = logical(1 - MatOutput);
end