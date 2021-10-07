% ME5405 Computing Project
% Script Part 1: Chromosomes Image
% Description:
% This script reads an input image in .txt format and converting it into a
% binary image through use of thresholding. It then displays the original
% image, a one-pixel-thick version, an outlined version, and 4- and 8-
% connectivity labeled versions.

close all
clear

% Receive input for the chosen file from user
prompt = 'Please input the file to open in XXX.txt format: ';
filename = input(prompt, 's');
debugfilename = ['Chosen file: ', filename];

% Receive input for the number of rows and columns in the image from the
% user - this is to enable different picture sizes to be used
prompt = 'Please input the number of rows in the image: ';
rows = input(prompt);
debugrows = ['Number of rows: ', num2str(rows)];

prompt = 'Please input the number of columns in the image: ';
cols = input(prompt);
debugcols = ['Number of columns: ', num2str(cols)];

% Receive user input for the thresholding value
% For app version, also display default / recommended values for image 1
% and 2
prompt = 'Please input the desired thresholding value (from 1 to 32) in the image: ';
threshold = input(prompt);
debugthresh = ['Selected threshold value: ', num2str(threshold)];

disp(debugfilename);
disp(debugrows);
disp(debugcols);
disp(debugthresh);

% Actually open the file itself
fileID = fopen(filename);

% Read the file and input the data into a matrix of size cols x rows
MatOriginal = fscanf(fileID,'%s',[cols,rows]);
MatOriginal = MatOriginal';
fclose(fileID);

% FOR TESTING ---------------------- EDIT THIS ---------------------------
writematrix(MatOriginal, 'test1.txt')

% FROM EXAMPLE --------------------- EDIT THIS ---------------------------
MatOriginal(isletter(MatOriginal))= MatOriginal(isletter(MatOriginal)) - 55;
MatOriginal(MatOriginal >= '0' & MatOriginal <= '9') = MatOriginal(MatOriginal >= '0' & MatOriginal <= '9') - 48;
MatOriginal = uint8(MatOriginal);

%% Task 1: Display the original image on the screen
% Show the original image on screen as a 64x64 picture, greyscaled from 0 
% to 31
figure(1), imshow(mat2gray(MatOriginal,[0,31])), title('Original Image');

% FOR TESTING ---------------------- EDIT THIS ---------------------------
writematrix(MatOriginal, 'test2.txt')

%% Task 2: Display a binary version of the image
% Set a threshold according to user's input
MatBinary = (MatOriginal >= threshold);

% FOR TESTING ---------------------- EDIT THIS ---------------------------
writematrix(MatBinary, 'test3.txt')

% This shows the binary image after thresholding
figure(2), imshow(MatBinary), title('Binary Image');

% Alternative Method: Image Processing Toolbox Function imbinarize
% MatBinary = imbinarize(MatOriginal,threshold);
% figure(2), imshow(MatBinary);

%% Task 3: Determine a one-pixel thin image

% find something for this ---------------------------------------
% StrElems = {8};
% 
% StrElems(1) = boolean([0 0 0;0 1 0;1 1 1]);
% StrElems(2) = boolean([0,0,0;1,1,0;0,1,0]);
% StrElems(3) = boolean([1,0,0;1,1,0;1,0,0]);
% StrElems(4) = boolean([0,1,0;1,1,0;0,0,0]);
% StrElems(5) = boolean([1,1,1;0,1,0;0,0,0]);
% StrElems(6) = boolean([0,1,0;0,1,1;0,0,0]);
% StrElems(7) = boolean([0,0,1;0,1,1;0,0,1]);
% StrElems(8) = boolean([0,0,0;0,1,1;0,1,0]);

% SE1 = boolean([0 0 0;0 1 0;1 1 1]);
% SE2 = boolean([0,0,0;1,1,0;0,1,0]);
% SE3 = boolean([1,0,0;1,1,0;1,0,0]);
% SE4 = boolean([0,1,0;1,1,0;0,0,0]);
% SE5 = boolean([1,1,1;0,1,0;0,0,0]);
% SE6 = boolean([0,1,0;0,1,1;0,0,0]);
% SE7 = boolean([0,0,1;0,1,1;0,0,1]);
% SE8 = boolean([0,0,0;0,1,1;0,1,0]);

SE1 = [0 0 0;0 1 0;1 1 1];
SE2 = [0,0,0;1,1,0;0,1,0];
SE3 = [1,0,0;1,1,0;1,0,0];
SE4 = [0,1,0;1,1,0;0,0,0];
SE5 = [1,1,1;0,1,0;0,0,0];
SE6 = [0,1,0;0,1,1;0,0,0];
SE7 = [0,0,1;0,1,1;0,0,1];
SE8 = [0,0,0;0,1,1;0,1,0];

% SE1 = boolean([0;1;1]);
% SE2 = boolean([1,1,0]);
% SE3 = boolean([1;1;0]);
% SE4 = boolean([0,1,1]);

% SE1 = boolean([1;0;0]);
% SE2 = boolean([0,0,1]);
% SE3 = boolean([0;0;1]);
% SE4 = boolean([1,0,0]);

% disp(SE1);
% disp(SE2);

MatSkeleton = logical(1 - MatBinary);
MatSkelPadded = padarray(MatSkeleton,[1 1],0);
figure(9), imshow(MatSkelPadded), title('Debug Padded Image');
% MatSkelPadded = imerode(MatSkelPadded,SE1);
% i = 4
while (true)
    MatSkeletonPrevious = MatSkelPadded;
    MatSkelPadded = imerode(MatSkelPadded,SE1);
%     break
    MatSkelPadded = imerode(MatSkelPadded,SE2);
%     break
    MatSkelPadded = imerode(MatSkelPadded,SE3);
    MatSkelPadded = imerode(MatSkelPadded,SE4);
    MatSkelPadded = imerode(MatSkelPadded,SE5);
    MatSkelPadded = imerode(MatSkelPadded,SE6);
    MatSkelPadded = imerode(MatSkelPadded,SE7);
    MatSkelPadded = imerode(MatSkelPadded,SE8);
%     break
%     if (MatSkeletonPrevious == MatSkelPadded)
%         break
%     end
end

% StrElems = zeros(8);
% SE0 = strel('square',3);
% SE1 = SE1 + {0,0,0;0,1,0;1,1,1};

% Display the outlined image
figure(3), imshow(MatSkelPadded), title('Skeletonized Image');

% Alternative Method: Image Processing Toolbox Function bwareaopen, bwmorph
% MatBinary2 = 1 - MatBinary;
% MatThin = bwareaopen(MatBinary2, 5);
% MatSkeleton = bwmorph(MatThin, 'skel', inf);
% figure(3), imshow(MatSkeleton);

%% Task 4: Determine the outline(s) of the image
% This is done with two passes, saving the outline values in another matrix
% MatOutline
checkone = 0;
checktwo = 0;
MatOutline = zeros(cols,rows);
MatOutline = MatOutline + 1;

% For each row and column, scan for boundary numbers and input the boundary
% into a third matrix
for x = 1:(rows-1)
    for y = 1:(cols)
        checkone = MatBinary(y,x);
        checktwo = MatBinary(y,x+1);
        if (checkone == 0 & checktwo == 1)
            MatOutline(y,x) = 0;
        else if (checkone == 1 & checktwo == 0)
            MatOutline(y,x+1) = 0;
            end
        end
    end
end
for y = 1:(cols-1)
    for x = 1:rows
        checkone = MatBinary(y,x);
        checktwo = MatBinary(y+1,x);
        if (checkone == 0 & checktwo == 1)
            MatOutline(y,x) = 0;
        else if (checkone == 1 & checktwo == 0)
            MatOutline(y+1,x) = 0;
            end
        end
    end
end
% Display the outlined image
% figure(4), imshow(MatOutline);

% FOR TESTING ---------------------- EDIT THIS ---------------------------
writematrix(MatOutline, 'test4.txt')

% Alternative Method: Image Processing Toolbox Function bwmorph
% MatOutline = bwmorph(MatBinary, 'remove');
% figure(4), imshow(MatOutline);

%% Task 5: Segment the image to separate and label the different characters

% For noise removal (TO TEST) ---------------------------------------------
% BW2 = imdilate(MatBinary,[strel('line',11,90)]);
% figure, imshow(BW2);

% Alternative Method: Image Processing Toolbox Function bwlabel
% MatBinary3 = 1 - MatBinary;
% [L, num] = bwlabel(MatBinary2);
% MatSegColor = label2rgb(L);
% figure(5), imshow(MatSegColor);

%% Task 6: Arrange the characters in one line with the sequence: AB123C


%% Task 7: Rotate the output image from Step 6 about its center by 30 degrees.
