% Writen by Yunqi Huang for ME5405 Project
% 16/09/2021
close all
clear

%% Task 1: Display the original image (charact1)
% Method 1: Use function to transfer letters to numbers (ASCII)
ImgID = fopen('charact1.txt','r');
formatSpec = '%s';
Img1 = fscanf(ImgID, formatSpec, [64,64]);
Img = zeros(64);
for i = 1:1:64
    for j = 1:1:64
        Img(i,j) = char2num(Img1(i,j));
    end
end
figure(1)
colormap(gray(32));
image(Img);

%% Task 2: Create a binary image using threshold 3
% Method 1: Image Processing Toolbox Function
BiImg = imbinarize(Img,3);
figure(2)
imshow(BiImg)

% % Method 2: Setting threshold and compare grey level with it
% td = 3;
% BiImg = zeros(64);
% for i = 1:1:64
%     for j = 1:1:64
%         if Img(i,j) > 3
%             BiImg(i,j) = 1;
%         else
%             BiImg(i,j) = 0;
%         end
%     end
% end
% figure(2)
% imshow(BiImg)

%% Task 3: Determine a one-pixel thin image of the characters.
% Method 1: Image Processing Toolbox Function
%thinImg = bwareaopen(BiImg, 5);
skeletonImg = bwmorph(BiImg, 'skel', inf);
figure(3)
imshow(skeletonImg)

% bwmorph 
% https://www.mathworks.com/help/images/ref/bwmorph.html?s_tid=srchtitle_bwmorph_1

%% Task 4: Determine the outline(s) of characters of the image.
% Method 1: Image Processing Toolbox Function
% 
% outlineImg = bwmorph(BiImg, 'remove');
% figure(4)
% imshow(outlineImg)

% Method 2: Use two passes to dectect the edge
outlineImg = ones(64);
% pass 1
outlineImg1 = zeros(64);
for i = 1:1:64
    for j = 2:1:64
        if BiImg(i,j) == BiImg(i,j-1)
            outlineImg1(i,j) = 0;
        else
            outlineImg1(i,j) = 1;
        end
    end
end
% pass 2
outlineImg2 = zeros(64);
for j = 1:1:64
    for i = 2:1:64
        if BiImg(i,j) == BiImg(i-1,j)
            outlineImg2(i,j) = 0;
        else
            outlineImg2(i,j) = 1;
        end
    end
end
% put together
for i = 1:1:64
    for j = 1:1:64
        if (outlineImg1(i,j) == outlineImg2(i,j)) == 1
            outlineImg(i,j) = 0;
        else
            outlineImg(i,j) = 1;
        end
    end
end
figure(4)
imshow(outlineImg)

%% Task 5: Segment the image to separate and label the different characters.

% Method 1:
% Pass 1: Check the connectivity of four neighbor pixels and get midImg
midImg = zeros(64);
k = 1;
for i = 2:1:64
    for j = 2:1:64
        if BiImg(i,j) == 0
            midImg(i,j) = 0;
        else
            midNum = connectivity4(BiImg(i,j), BiImg(i,j-1), BiImg(i-1,j), k);
            if midNum == k
                midImg(i,j) = k;
                k = k + 1;
            elseif midNum == 1
                midImg(i,j) = midImg(i-1,j);
            elseif midNum == 0
                midImg(i,j) = midImg(i,j-1);
            end
        end
    end
end

% Method 2: bwlabel
[L, num] = bwlabel(BiImg);
RGB = label2rgb(L);
figure(5);
imshow(RGB);

s1 = regionprops(L,'image');
figure(6)
subplot(2,3,1), imshow(s1(1).Image), title('1')
subplot(2,3,2), imshow(s1(2).Image), title('2')
subplot(2,3,3), imshow(s1(3).Image), title('3')
subplot(2,3,4), imshow(s1(5).Image), title('A')
subplot(2,3,5), imshow(s1(6).Image), title('B')
subplot(2,3,6), imshow(s1(4).Image), title('C')


%% Task 6: Arrange the characters in one line with the sequence: AB123C
char1 = imrotate(s1(1).Image, -90);
char1 = flip(char1,2);
% ----------------------------------
char2 = imrotate(s1(2).Image, -90);
char2 = flip(char2,2);
% ----------------------------------
char3 = imrotate(s1(3).Image, 90);
% ----------------------------------
charA = imrotate(s1(5).Image, -90);
% ----------------------------------
charB = imrotate(s1(6).Image, -90);
charB = flip(charB,2);
% ----------------------------------
charC = imrotate(s1(4).Image, 90);
% ----------------------------------
figure(7)
subplot(2,3,1), imshow(char1), title('1')
subplot(2,3,2), imshow(char2), title('2')
subplot(2,3,3), imshow(char3), title('3')
subplot(2,3,4), imshow(charA), title('A')
subplot(2,3,5), imshow(charB), title('B')
subplot(2,3,6), imshow(charC), title('C')

% AB123C

figure(8)
arrImg = montage({charA, charB, char1, char2, char3, charC}, 'Size', [1 6]);

%% Task 7: Rotate the output image from Step 6 about its center by 30 degrees.
C = arrImg.CData;
C = imbinarize(C);
C = imrotate(C, 30);
figure(9)
imshow(C)


% scan each individual image
% find the highest number of rows
% find the total number of cols
% set final image = total number of columns and highest number of rows
% one by one, put the images in



