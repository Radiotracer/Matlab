clear; close all;
global gaussFilter;
gaussFilter= fspecial('gaussian', [29 29], 5);

global imgMd;
img=createImg2D(50,80,20,100,100,100,100,5);
imgMd=imfilter(img,gaussFilter,'same');

y=zeros(10,1);
for k=1:10
    y(k)=objRadiusFunc(45+k);
end;
figure
plot(46:55,y);


figure;
imshow(img,[]);
figure;
imshow(imgMd,[]);

figure;
plot(imgMd(128,:))
figure;
% plot(img(128,:))

[x,fval] = fmincon(@objFunc,[50 80 5 50 50 50 50  0],...
[],[],[],[],[],[],@constraint);

% global act;
% act=[20 100 100 100 100 5];
% global radius;
% radius=[45 85];
% [r,fval] = fmincon(@objRadiusFunc,radius,[],[],[],[],[],[],@radiusConstraint); 

% global act;
% act=[30 80 80 80 80 10];
% global radius;
% radius=[45 85];
% for k=1:4
%     k
%     [act,fval] = fmincon(@objActFunc,act,[],[],[],[],[],[],@actConstraint);
%     act
%     [radius,fval] = fmincon(@objRadiusFunc,radius,[],[],[],[],[],[],@radiusConstraint); 
%     radius
% end


% 
% img=createImg2D(50,80,50,80,90,100,110,5);
% imshow(img,[]);