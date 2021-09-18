% ME5405 Computing Project
% Script Part 1: Chromosomes Image
% Description:
% This script reads an input image in .txt format and converting it into a
% binary image through use of thresholding. It then displays the original
% image, a one-pixel-thick version, an outlined version, and 4- and 8-
% connectivity labeled versions.

% Receive input for the file from user
prompt = 'Please input the file to open in XXX.txt format: ';
filename = input(prompt, 's');
debugfilename = ['Chosen file: ', filename];
disp(debugfilename);

prompt = 'Please input the number of rows in the image: ';
rows = input(prompt);
debugrows = ['Number of rows: ', num2str(rows)];
disp(debugrows);

prompt = 'Please input the number of columns in the image: ';
cols = input(prompt);
debugcols = ['Number of columns: ', num2str(cols)];
disp(debugcols);

fileID = fopen(filename);

% Read the file and input the data into a matrix of size cols x rows
% Also ignore the line feed and carriage return characters
MatA = fscanf(fileID,[char(10) char(13) '%c'],[cols,rows]);
MatA = MatA';
fclose(fileID);

% FOR TESTING ---------------------- EDIT THIS ---------------------------
writematrix(MatA, 'test1.txt')

% FROM EXAMPLE --------------------- EDIT THIS ---------------------------
MatA(isletter(MatA))= MatA(isletter(MatA)) - 55;
MatA(MatA >= '0' & MatA <= '9') = MatA(MatA >= '0' & MatA <= '9') - 48;
MatA = uint8(MatA);

% Show the original image on screen as a 64x64 picture, greyscaled from 0 
% to 31
imshow(mat2gray(MatA,[0,31]));

% FOR TESTING ---------------------- EDIT THIS ---------------------------
writematrix(MatA, 'test2.txt')

MatB = (MatA >= 21);

% FOR TESTING ---------------------- EDIT THIS ---------------------------
writematrix(MatB, 'test3.txt')

% This shows the binary image after thresholding
figure, imshow(mat2gray(MatB,[0,1]));


% ------------------------------------------------------------------------
% This section handles the scanning for outline
checkone = 0;
checktwo = 0;
MatC = zeros(cols,rows);
MatC = MatC + 1;

% For each row and column, scan for boundary numbers and input the boundary
% into a third matrix
for x = 1:(rows-1)
    for y = 1:(cols)
        checkone = MatB(y,x);
        checktwo = MatB(y,x+1);
        if (checkone == 0 & checktwo == 1)
            MatC(y,x) = 0;
        else if (checkone == 1 & checktwo == 0)
            MatC(y,x+1) = 0;
            end
        end
    end
end
for y = 1:(cols-1)
    for x = 1:rows
        checkone = MatB(y,x);
        checktwo = MatB(y+1,x);
        if (checkone == 0 & checktwo == 1)
            MatC(y,x) = 0;
        else if (checkone == 1 & checktwo == 0)
            MatC(y+1,x) = 0;
            end
        end
    end
end
% Display the outlined image
figure, imshow(mat2gray(MatC,[0,1]));

% FOR TESTING ---------------------- EDIT THIS ---------------------------
writematrix(MatC, 'test4.txt')
