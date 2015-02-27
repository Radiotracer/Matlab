function [ val] = objConFuncShape_v1(p)
%  Constrained objective function + shape
%   Detailed explanation goes here
global imgMd; % Measured image with resolution model
global gaussFilter;
global weight; % weight of the shape constraint;
global nseg;
img=createActImg2D_v1( p );
imgBlur=imfilter(img,gaussFilter,'same');
tmp=(imgBlur-imgMd).^2;
mse=mean(tmp(:));

% compute the variance of radii and thicknesses
radiusP=zeros(1,nseg);
thicknessP=zeros(1,nseg);
for k=1:nseg
    radiusP(k)=p(6+2*(k-1));
    thicknessP(k)=p(7+2*(k-1));
end;
val=mse+weight*(var(radiusP)+var(thicknessP));
end
