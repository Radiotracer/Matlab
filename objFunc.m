function [ mse] = objFunc(x)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
global imgMd; % Measured image with resolution model
global gaussFilter;
img=createImg2D(x(1)*0.1,x(2)*0.01,x(3),x(4),x(5),x(6),x(7),x(8));
imgBlur=imfilter(img,gaussFilter,'same');
tmp=(imgBlur-imgMd).^2;
mse=mean(tmp(:));
% tmp=imgBlur-imgMd;
% mse=tmp(:);
end

