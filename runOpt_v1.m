%%   True Parameter Settings
% Activity Ratio: Blood Pool : Myocardium : Background = 17 :93: 5
% Radius=12 mm, Thickness=16 mm 
% For 256*256 matix size with 0.4mm*0.4mm pixel size,
% Radius=30, Thickness=40
% PET resolution FWHM=5mm, Sigma=5mm/(2sqrt(2ln2))=5/2.3548=2.1233mm=5.3p
% 

%%
clear; close all;
global gaussFilter;
gaussFilter= fspecial('gaussian', [29 29], 5.3);
global imgMd;
tp=[128.5 128.5 17 5 93  30 40 30 40 30  40 30  40 30 40 30 40 30 40 30 40];
global nseg;nseg=floor((length(tp)-5)/2);
global dAng;dAng=2*pi/nseg;
global hdAng;hdAng=pi/nseg;
global dimX;dimX=256;
global dimY;dimY=256;
img=createActImg2D_v1(tp);
imgMd=imfilter(img,gaussFilter,'same');
figure;imshow(img,[]);
figure;imshow(imgMd,[]);

initP=[127 127 20 7 70 25 45 25 45 25 45  25 45  25 45 25 45 25 45 25 45];
imgInit=createActImg2D_v1(initP);figure;imshow(imgInit,[]);
options = optimoptions(@fmincon,...
    'Display','iter',...
    'Algorithm','interior-point',...
    'FinDiffType','central',...
    'FinDiffRelStep',0.001,...
    'MaxFunEvals',10000 ...
    );
figure;
plot([objConFunc_v1(initP) compareParameter_v1(initP,tp)],'b*');
xlabel('Objective[1],Center[2-3],Activity[4-6],Radius[7-14],Thickness[15-22]');
ylabel('Difference');
title('Difference between Initial Parameters and Truth');

[ncep,ncfval] = fmincon(@objConFunc_v1,initP,[],[],[],[],[],[],@noconstraint_v1,options);
[ep,fval] = fmincon(@objConFunc_v1,initP,[],[],[],[],[],[],@constraint_v1,options);

global weight;

weight=1;
[ep_w1,fval_w1] = fmincon(@objConFuncShape_v1,initP,[],[],[],[],[],[],@noconstraint_v1,options);

weight=0.1;
[ep_wd1,fval_wd1] = fmincon(@objConFuncShape_v1,initP,[],[],[],[],[],[],@noconstraint_v1,options);


weight=0.5;
[ep_wd5,fval_wd5] = fmincon(@objConFuncShape_v1,initP,[],[],[],[],[],[],@constraint_v1,options);

figure;
plot(0:25,zeros([1 26]),'k-');
hold on;
plot([objConFunc_v1(ncep) compareParameter_v1(ncep,tp)],'g+');
plot([objConFunc_v1(ep_wd1) compareParameter_v1(ep_wd1,tp)],'ro');
plot([objConFunc_v1(ep_wd5) compareParameter_v1(ep_wd5,tp)],'ko');
plot([objConFunc_v1(ep_w1) compareParameter_v1(ep_w1,tp)],'bo');
plot([objConFunc_v1(ep) compareParameter_v1(ep,tp)],'m*');
legend('Truth','Shape weight=0','Shape weight=0.1','Shape weight=0.5','Shape weight=1.0','Hard shape');
xlabel('Objective[1],Center[2-3],Activity[4-6],Radius[7-14],Thickness[15-22]');
ylabel('Difference with truth');

%% The truth has a defect, still assuming uniform activity
close all;
tp_defect=[128.5 128.5 17 5 30 40  80  30 40 93  30  40 93  30  40 93  30 40 93  30 40 93 30 40 93  30 40 93 ];
img_defect=createActImg2D_v2( tp_defect );
imgMd=imfilter(img_defect,gaussFilter,'same');
figure;imshow(img_defect,[]);
figure;imshow(imgMd,[]);

[ncep,ncfval] = fmincon(@objConFunc_v1,initP,[],[],[],[],[],[],@noconstraint_v1,options);
[ep,fval] = fmincon(@objConFunc_v1,initP,[],[],[],[],[],[],@constraint_v1,options);

weight=1;
[ep_w1,fval_w1] = fmincon(@objConFuncShape_v1,initP,[],[],[],[],[],[],@noconstraint_v1,options);

weight=0.1;
[ep_wd1,fval_wd1] = fmincon(@objConFuncShape_v1,initP,[],[],[],[],[],[],@noconstraint_v1,options);

weight=0.5;
[ep_wd5,fval_wd5] = fmincon(@objConFuncShape_v1,initP,[],[],[],[],[],[],@noconstraint_v1,options);

figure;
plot(0:25,zeros([1 26]),'k-');
hold on;
plot([objConFunc_v1(ncep) compareParameter_v1(ncep,tp)],'g+');
plot([objConFunc_v1(ep_wd1) compareParameter_v1(ep_wd1,tp)],'ro');
plot([objConFunc_v1(ep_wd5) compareParameter_v1(ep_wd5,tp)],'ko');
plot([objConFunc_v1(ep_w1) compareParameter_v1(ep_w1,tp)],'bo');
plot([objConFunc_v1(ep) compareParameter_v1(ep,tp)],'m*');
legend('Truth','Shape weight=0','Shape weight=0.1','Shape weight=0.5','Shape weight=1.0','Hard shape');
xlabel('Objective[1],Center[2-3],Activity[4-6],Radius[7-14],Thickness[15-22]');
ylabel('Difference with truth');

%%