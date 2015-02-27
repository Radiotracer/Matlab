function [ mse] = objConFunc_v1(p)
%  Constrained objective function
%   Detailed explanation goes here
global imgMd; % Measured image with resolution model
global gaussFilter;
img=createActImg2D_v1( p );
imgBlur=imfilter(img,gaussFilter,'same');
tmp=(imgBlur-imgMd).^2;
mse=mean(tmp(:));
end

