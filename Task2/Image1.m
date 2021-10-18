% Yunqi Huang for ME5405 Project
% 16/09/2021
%
% IMPORTANT: You need to add Function file to your working path first
%
%
close all
clear

%% Task 1: Display the original image (charact1)
% Method 1: Use function to transfer letters to numbers (ASCII)
ImgID = fopen('charact1.txt','r');
formatSpec = '%s';
% fscanf read the transpose of the original file, so the matrix needs to be
% transposed after being scaned
Img1 = fscanf(ImgID, formatSpec, [64,64]);
Img = zeros(64);
for i = 1:1:64
    for j = 1:1:64
        Img(i,j) = char2num(Img1(j,i)); % transpose
    end
end
figure(1)
% colormap is to confine the gray level of the displayed image 
colormap(gray(32));
% colormap + image
image(Img);

%% Task 2: Create a binary image using threshold 3
% Method 1: Image Processing Toolbox Function
% BiImg = imbinarize(Img,3);
% figure(2)
% % gray2 means this colormap only have two levels of gray, black and white
% colormap(gray(2))
% % By using this Toolbox Function, the virables of BiImg are logical values, 0-black 1-white
% image(BiImg)
% colorbar

% Method 2: Setting threshold and compare grey level with it
% Set the thresholding number
td = 3;
BiImg = zeros(64);
for i = 1:1:64
    for j = 1:1:64
        if Img(i,j) > td
            BiImg(i,j) = 1;
        else
            BiImg(i,j) = 0;
        end
    end
end

% change double values to logical values to display binary image
BiImg = logical(BiImg);
figure(2)
colormap(gray(2))
image(BiImg)
colorbar

%% Task 3: Determine a one-pixel thin image of the characters.
% Method 1: Image Processing Toolbox Function
% thinImg = bwareaopen(BiImg, 5);
skeletonImg = bwmorph(BiImg, 'skel', inf);
figure(3)
colormap(gray(2))
image(skeletonImg)

% bwmorph 
% https://www.mathworks.com/help/images/ref/bwmorph.html?s_tid=srchtitle_bwmorph_1

%% Task 4: Determine the outline(s) of characters of the image.
% Method 1: Image Processing Toolbox Function

outlineImg = bwmorph(BiImg, 'remove');
figure(4)
colormap(gray(2))
image(outlineImg)

% % Method 2: Use two passes to dectect the edge
% outlineImg = zeros(64);
% % pass 1
% outlineImg1 = zeros(64);
% for i = 1:1:64
%     for j = 2:1:64
%         if BiImg(i,j) == BiImg(i,j-1)
%             outlineImg1(i,j) = 0;
%         else
%             outlineImg1(i,j) = 1;
%         end
%     end
% end
% % pass 2
% outlineImg2 = zeros(64);
% for j = 1:1:64
%     for i = 2:1:64
%         if BiImg(i,j) == BiImg(i-1,j)
%             outlineImg2(i,j) = 0;
%         else
%             outlineImg2(i,j) = 1;
%         end
%     end
% end
% % put together
% for i = 1:1:64
%     for j = 1:1:64
%         if outlineImg1(i,j) == (outlineImg2(i,j) == 1)
%             outlineImg(i,j) = 1;
%         else
%             outlineImg(i,j) = 0;
%         end
%     end
% end
% figure(4)
% imshow(outlineImg)

%% Task 5: Segment the image to separate and label the different characters.

% Method 1:
% Check the four-connectivity of every pixel 
[MidImg, c, s, t] = FourConnect(BiImg);
% Label different parts of the image
[SegImg, label] = Label(MidImg, c, s, t);
% Change gray to RGB and display labeled parts 
RGBSeg = label2rgb(SegImg, 'hsv', 'k', 'shuffle');
figure(5)
image(RGBSeg)


% % Method 2: bwlabel (Toolbox function)
% [SegImg, num] = bwlabel(BiImg);
% RGBSeg = label2rgb(SegImg);
% figure(5);
% imshow(RGBSeg);

% Get all parts out of the image and display every parts
charMeasurements = regionprops(SegImg,'all');
figure(6)
% This 'for loop' name different parts manually
for u = 1 : label
    thisChar = charMeasurements(u).BoundingBox;
    subImg = imcrop(SegImg, thisChar);

    if u < 4
        subplot(2,3,u)
        imshow(subImg)
        caption = sprintf('%d',u);
        title(caption)
    elseif u == 4
        subplot(2,3,6), imshow(subImg), title('C')
    elseif u == 5
        subplot(2,3,4), imshow(subImg), title('A')
    elseif u == 6
        subplot(2,3,5), imshow(subImg), title('B')
    end
    
end

%% Task 6: Arrange the characters in one line with the sequence: AB123C

% AB123C
% Arrange every parts that get from Task 5
t = [];
for u = 1: label
    s = size(charMeasurements(u).Image);
    t(end+1) = s(1);
end
% Check the maximum height of all parts and complement other parts to this
% height
h = max(t);
arrImg = zeros(h,2);
for u = 1: label
    s = size(charMeasurements(u).Image);
    if s(1) < h
        charMeasurements(u).Image = [zeros((h-s(1)), s(2)); [charMeasurements(u).Image]];
    end
    
end
% Joint complemented parts by the required sequence: AB123C
arrImg = cat(2, arrImg, charMeasurements(5).Image, zeros(h,2), charMeasurements(6).Image, zeros(h,2),...
                        charMeasurements(1).Image, zeros(h,2), charMeasurements(2).Image, zeros(h,2),...
                        charMeasurements(3).Image, zeros(h,2), charMeasurements(4).Image, zeros(h,2));

figure(7)
imshow(arrImg)



%% Task 7: Rotate the output image from Step 6 about its center by 30 degrees.

% Rotate every parts that get from Task 5 
t = [];
for u = 1: label
    charMeasurements(u).Image = imrotate(charMeasurements(u).Image, -30);
    s = size(charMeasurements(u).Image);
    t(end+1) = s(1);
end
% Check the maximum height of all rotated parts and complement other parts to this height
h = max(t);
rotImg = zeros(h,1);
for u = 1: label
    s = size(charMeasurements(u).Image);
    if s(1) < h
        charMeasurements(u).Image = [zeros((h-s(1)), s(2)); [charMeasurements(u).Image]];
    end
    
end
% Joint every parts by the required sequence: AB123C
rotImg = cat(2, rotImg, charMeasurements(5).Image, charMeasurements(6).Image,...
                        charMeasurements(1).Image, charMeasurements(2).Image,...
                        charMeasurements(3).Image, charMeasurements(4).Image);
figure(8)
imshow(rotImg)





