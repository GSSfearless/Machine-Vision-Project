% This is a single erosion pass created for the ME5405 Computing Project.
% This function does a simple erosion, accepting a structuring element that
% can contain 0, 1, or 2, where 2 indicates that a pixel is to be ignored.
% This function was created to supplement the skelerode function that aims
% to skeletonize a binary image.

% In effect, this function compares a structuring element with each pixel
% and its immediate 8 neighbors. If the structuring element is exactly the
% same (ignoring pixels labelled as 2), then the image pixel being checked
% is changed from foreground to background.

% Inputs: Padded binary image, number of rows in image, number of columns 
% in image, structuring element to be applied
% Outputs: Updated unpadded final image

function MatUpdated = performerosion(MatOutputPadded, rows, cols, StructElem)
    
    MatUpdated = MatOutputPadded;

    % Start from 2 to the number of rows/columns + 1 due to the extra
    % padding of the input image. x and y are the position of the center
    % pixel within the padded image
    for x = 2:(rows+1)
        for y = 2:(cols+1)
            
            % First, check that the center pixel is a background pixel (0),
            % because we can skip it if it is.
            if (MatOutputPadded(y,x) == 0)
                continue
            end
            
            % This flag is set so that, by default, the center pixel which
            % should be a foreground pixel is changed to a background
            % pixel.
            flag = 0;

            % Next, check each pixel in the 3x3 grid around the center
            % pixel.  
            for x1 = 1:3
                for y1 = 1:3
                    
                    % CurrentPixelX and Y correlate to the position of the
                    % pixel that is being checked, but on the padded image
                    CurrentPixelX = x + x1 - 2;
                    CurrentPixelY = y + y1 - 2;
                    
                    % If the structuring element pixel that is currently
                    % being checked is 2, ignore that pixel.
                    if (StructElem(y1,x1) == 2)
                        continue
                    % Otherwise, if the structuring element pixel and the
                    % image pixel do not match, change the flag to 1 (which
                    % means that the image pixel will remain foreground).
                    elseif (StructElem(y1,x1) ~= MatOutputPadded(CurrentPixelY,CurrentPixelX))
                        flag = 1;
                    end
                end
            end
            % Check to see if the flag is 0, and thus the image pixel will
            % be changed to a background pixel.
            if (flag == 0)
                MatUpdated(y,x) = 0;
            end
        end
    end
end


