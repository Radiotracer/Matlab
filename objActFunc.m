function [ mse] = objActFunc(x)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
global imgMd; % Measured image with resolution model
global gaussFilter;
global radius;
img=createImg2D(radius(1),radius(2),x(1),x(2),x(3),x(4),x(5),x(6));
imgBlur=imfilter(img,gaussFilter,'same');
tmp=(imgBlur-imgMd).^2;
mse=mean(tmp(:));
end
