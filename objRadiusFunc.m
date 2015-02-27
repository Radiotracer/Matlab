function [ mse] = objRadiusFunc(x)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
global imgMd; % Measured image with resolution model
global gaussFilter;
%global act;
img=createImg2D(x,80,20,100 ,100, 100 ,100, 5);
imgBlur=imfilter(img,gaussFilter,'same');
tmp=(imgBlur-imgMd).^2;
mse=mean(tmp(:));

end
