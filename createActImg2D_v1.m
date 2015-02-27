function [img] = createActImg2D_v1( p )
%%% This version assumes uniform myocardial activity and avoid the loops in
%%% assigning activities.

% This function creates a 256*256 2D image simulating a short-axis view of
% left ventricle (LV), modeled as a concentric circular sector with eight
% segments.
%  Parameters: 
% (a) Center :p(1),p(2)
% (b) Blood pool activity; p(3)
% (c) Background activity; p(4)
% (d) Myocardium activity: p(5)
% For each segment in myocardium (8 segments):
% The 1st segment
%(d)Central point radius on endocardium  p(6) 
%(f)Thickness p(7)
% The qth segment: p(6+2*(q-1):7+2*(q-1))

global nseg;
global dAng;
global hdAng;
global dimX;
global dimY;
inPts=zeros(2,nseg+1);
outPts=zeros(2,nseg+1);

for k=1:nseg
    ang=hdAng+dAng*(k-1);
    inPts(1,k)=p(1)+ p(6+2*(k-1))*cos(ang);
    inPts(2,k)=p(2)+ p(6+2*(k-1))*sin(ang);
    outPts(1,k)=p(1)+ (p(6+2*(k-1))+p(7+2*(k-1)))*cos(ang);
    outPts(2,k)=p(2)+ (p(6+2*(k-1))+p(7+2*(k-1)))*sin(ang);
end
inPts(:,end)=inPts(:,1);
outPts(:,end)=outPts(:,1);
inCurve=fnplt(cscvn(inPts));
outCurve=fnplt(cscvn(outPts));



iBp=p(3);
iMy=p(5);
iBk=p(4);
inMask=poly2mask(inCurve(1,:),inCurve(2,:),dimY,dimX);
outMask=poly2mask(outCurve(1,:),outCurve(2,:),dimY,dimX);
img=(iBp-iMy)*inMask+(iMy-iBk)*outMask+iBk*ones(dimY,dimX);

%%%% Loops are not efficient in Matlab %%%
% img=zeros(dimY,dimX);
% for y=1:dimY
%     for x=1:dimX
%         if  ~inpolygon(x,y,outCurve(1,:),outCurve(2,:)) %Background
%             img(y,x)=p(4);                       
%         elseif inpolygon(x,y,inCurve(1,:),inCurve(2,:)) %Bloodpool
%             img(y,x)=p(3);
%         else  % Myocardium              
%             img(y,x)=p(5);                
%         end;       
%     end;
% end

end

