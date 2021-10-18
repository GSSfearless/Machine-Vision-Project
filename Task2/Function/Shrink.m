function [ImgOut] = Shrink(ImgIn)
% Shrink the (N+1)*(N+1) image to N*N
%
    [m, n] = size(ImgIn);
    ImgOut = ImgIn(2:m,2:n);
end

