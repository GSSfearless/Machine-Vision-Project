function [ImgOut] = Expand(ImgIn)
% Expand the N*N image to (N+1)*(N+1) to check connectivity of every pixel
% of original image

    [m, n] = size(ImgIn);
    ImgOut = [zeros(1, n+1);[zeros(m,1) ImgIn]];
end

