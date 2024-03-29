% ME5405 Computing Project
% Script Part 1: Chromosomes Image
% Description:
% This script reads an input image in .txt format and converting it into a
% binary image through use of thresholding. It then displays the original
% image, a one-pixel-thick version, an outlined version, and 4- and 8-
% connectivity labeled versions.

close all
clear


%% Pre-Processing ----------------- THIS CAN BE REMOVED FOR THE APP-------
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
prompt = 'Please input the desired thresholding value (from 1 to 32) in the image: ';
threshold = input(prompt);
debugthresh = ['Selected threshold value: ', num2str(threshold)];

% Receive user input for the background color
prompt = 'Please input the background color (B/W): ';
backgroundcolor = input(prompt, 's');
debugbgcolor = ['Selected background color: ', backgroundcolor];

disp(debugfilename);
disp(debugrows);
disp(debugcols);
disp(debugthresh);
disp(debugbgcolor);

%%

% Actually open the file itself
fileID = fopen(filename);

% Read the file and input the data into a matrix of size cols x rows.
% fscanf reads the transpose of the original file, so it has to be
% transposed again after being scanned.
MatOriginal = fscanf(fileID,'%s',[cols,rows]);
MatOriginal = MatOriginal';
fclose(fileID);


%% Task 1: Display the original image on the screen
% Make a new matrix called MatGrayscale that is the grayscaled version of
% MatOriginal.
MatGrayscale = MatOriginal;

% Based on ASCII, we first ensure that any strange character values that
% are not 0-9 or A-V are changed to their corresponding extreme values of 0
% or 31. Values inbetween 9 and A are set to 10.
MatGrayscale(MatGrayscale >= '!' & MatGrayscale <= '/') = 0;
MatGrayscale(MatGrayscale >= 'W' & MatGrayscale <= '~') = 31;
MatGrayscale(MatGrayscale >= ':' & MatGrayscale <= '@') = 10;

% Based on the ASCII table, we must first convert all numbers 0-9 in the
% image which are stored as characters to their corresponding numbers. This
% is done by minusing 48 (as 0 equates to 48 in the ASCII table, 1 to 50,
% and so on).
MatGrayscale(MatGrayscale >= '0' & MatGrayscale <= '9') = MatGrayscale(MatGrayscale >= '0' & MatGrayscale <= '9') - 48;

% Only letters from A to V are left, so we can convert everything that is a
% letter by minusing 55 (as A equates to 65 in the ASCII table). 
MatGrayscale(isletter(MatGrayscale))= MatGrayscale(isletter(MatGrayscale)) - 55;

% Convert to an unsinged integer matrix
MatGrayscale = uint8(MatGrayscale);

% Show the original image on screen as a figure, greyscaled from 0 
% to 31
figure(1), imshow(mat2gray(MatGrayscale,[0,31])), title('Original Image');


%% Task 2: Display a binary version of the image
% Set a threshold according to user's input
MatBinary = (MatGrayscale >= threshold);

% This shows the binary image after thresholding
figure(2), imshow(MatBinary), title('Binary Image');


% Alternative Method: Image Processing Toolbox Function imbinarize
% MatBinaryAlt = imbinarize(MatOriginal,threshold);
% figure(2), imshow(MatBinaryAlt);

%% Task 3: Determine a one-pixel thin image

if (backgroundcolor == 'B')
    MatBinary = 1 - MatBinary;
end

% Use a custom defined function (made by us) called skelerode, then display
% the skeletonized image
MatSkel = skelerode(MatBinary, rows, cols);

if (backgroundcolor == 'B')
    MatBinary = 1 - MatBinary;
    MatSkel = 1 - MatSkel;
end

figure(3), imshow(MatSkel), title('Skeletonized Image');


% Alternative Method: Image Processing Toolbox Function bwareaopen, bwmorph
% MatBinary2 = 1 - MatBinary;
% MatThin = bwareaopen(MatBinary2, 5);
% MatSkeletonAlt = bwmorph(MatThin, 'skel', inf);
% figure(3), imshow(MatSkeletonAlt);

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
    for y = 1:cols
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
figure(4), imshow(MatOutline), title('Outlined Image');


% Alternative Method: Image Processing Toolbox Function bwmorph
% MatOutlineAlt = bwmorph(MatBinary, 'remove');
% figure(4), imshow(MatOutlineAlt);

%% Task 5: Segment the image to separate and label the different characters

% Check the four-connectivity of every pixel using a custom function FourConnect 
if (backgroundcolor == 'W')
    MatFlipped = 1 - MatBinary;
else
    MatFlipped = MatBinary;
end

% Choose between Eight and Four connectivity
[MatWorking, c, counttwo, countone] = EightConnect(MatFlipped);
% [MatWorking, c, counttwo, countone] = FourConnect(MatFlipped);
% Label different parts of the image using a custom function Label
[MatSegmented, NumLabels] = Label(MatWorking, c, counttwo, countone);
% Change gray to RGB and display the labeled parts 
MatSegLabeled = label2rgb(MatSegmented, 'hsv', 'k', 'shuffle');

% Display the segmented and labelled image
figure(5), imshow(MatSegLabeled), title('Segmented Image');

% Get all parts out of the image and display every part
charMeasurements = regionprops(MatSegmented,'all');
figure(6)
% This loop labels each different segment in the image
for u = 1:NumLabels
    thisChar = charMeasurements(u).BoundingBox;
    SplitImage = imcrop(MatSegmented, thisChar);

    NumLabels = int8(NumLabels);
    LabelRows = double(idivide(NumLabels,2,'ceil'));
    subplot(2,LabelRows,u)
    imshow(SplitImage)
    Caption = sprintf('%d',u);
    title(Caption)
end


% Alternative Method: Image Processing Toolbox Function bwlabel
% MatBinary = 1 - MatBinary;
% [L, num] = bwlabel(MatBinary);
% MatSegmentAlt = label2rgb(L);
% figure(5), imshow(MatSegmentAlt);

%% Task 6: Arrange the characters in one line with the sequence: AB123C
% Arrange every part we get from Task 5 into a different arrangement on the
% same image
countone = [];
for u = 1:NumLabels
    counttwo = size(charMeasurements(u).Image);
    countone(end + 1) = counttwo(1);
end
% Check the maximum height of all parts and complement other parts to this
% height
h = max(countone);
MatArranged = zeros(h,2);
for u = 1:NumLabels
    counttwo = size(charMeasurements(u).Image);
    if counttwo(1) < h
        charMeasurements(u).Image = [zeros((h-counttwo(1)), counttwo(2)); [charMeasurements(u).Image]];
    end
    
end
% Joint complemented parts by the required sequence: AB123C. This is done
% by concatenating the individual segmented images
MatArranged = cat(2, MatArranged, charMeasurements(4).Image, zeros(h,2), charMeasurements(5).Image, zeros(h,2),...
                        charMeasurements(1).Image, zeros(h,2), charMeasurements(2).Image, zeros(h,2),...
                        charMeasurements(3).Image, zeros(h,2), charMeasurements(6).Image, zeros(h,2));

figure(7), imshow(MatArranged), title('Re-Arranged Image');


%% Task 7: Rotate the output image from Task 6 about its center by 30 degrees.
% By using nearest neighbour interpolation, we rotate the image about its
% center point
[arrangedcols,arrangedrows,p]=size(MatArranged);
angle = deg2rad(30);

% Because rotating the image will result in a larger image, we set the new
% image size to be the maximum possible first (a square output that is the
% higher of the two numbers)
newsize = max([arrangedcols,arrangedrows]);

% For each pixel of the new image, we find the corresponding nearest pixel
% in the original image and set it to that value
for x = 1:newsize
   for y = 1:newsize
      TempOne = uint16((x-newsize/2)*cos(angle)+(y-newsize/2)*sin(angle)+arrangedcols/2);
      TempTwo = uint16(-(x-newsize/2)*sin(angle)+(y-newsize/2)*cos(angle)+arrangedrows/2);
      
      % Check to see if the pixel is within the boundary of the image
      if ((TempOne>0) && (TempOne<=arrangedcols) && (TempTwo>0) && (TempTwo<=arrangedrows))        
         MatRotated(x,y,:) = MatArranged(TempOne, TempTwo, :);
      end
   end
end

figure(8), imshow(MatRotated), title('Rotated Image');


% Alternative Output: Rotate each part obtained in Task 5 before
% concatenating them.
% Rotate every segmented part that we get from Task 5
% t = [];
% for u = 1: NumLabels
%     charMeasurements(u).Image = imrotate(charMeasurements(u).Image, 30);
%     s = size(charMeasurements(u).Image);
%     t(end+1) = s(1);
% end
% % Check the maximum height of all rotated parts and complement other parts to this height
% h = max(t);
% MatRotatedCat = zeros(h,1);
% for u = 1: NumLabels
%     s = size(charMeasurements(u).Image);
%     if s(1) < h
%         charMeasurements(u).Image = [zeros((h-s(1)), s(2)); [charMeasurements(u).Image]];
%     end
%     
% end
% % Joint every parts by the required sequence: AB123C
% MatRotatedCat = cat(2, MatRotatedCat, charMeasurements(4).Image, charMeasurements(5).Image,...
%                         charMeasurements(1).Image, charMeasurements(2).Image,...
%                         charMeasurements(3).Image, charMeasurements(6).Image);
% figure(9), imshow(MatRotatedCat), title('Rearranged Rotated Image');


% Alternative Method: Image Processing Toolbox Function imrotate
% MatRotated = imrotate(MatArranged, 30);
% figure(8), imshow(MatRotatedAlt), title('Alternative Rotated Image');
