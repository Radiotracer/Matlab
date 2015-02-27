function [ img ] = createImg2D(inR,outR,actBp,actMycd1,actMycd2,actMycd3,actMycd4,actBkg)
% This function creates a 256*256 2D image simulating a short-axis view of
% left ventricle (LV), modeled as a concentric circular sector with four
% segments.
% Detailed explanation goes here
dimX=256;
dimY=256;
img=zeros(dimY,dimX);
cX=(1+dimX)/2;
cY=(1+dimY)/2;
for y=1:dimY
    for x=1:dimX
        if (y-cY)^2+(x-cX)^2>outR^2  %Background
            img(y,x)=actBkg;                       
        elseif (y-cY)^2+(x-cX)^2<inR^2 %Bloodpool
            img(y,x)=actBp;
        else  % Myocardium            
            if (x-cX)<0 && (y-cY)<=0  %seg1
                img(y,x)=actMycd1;
            elseif (x-cX)>=0 && (y-cY)<0  % seg2
                img(y,x)=actMycd2;
            elseif (x-cX)>0 && (y-cY)>=0  % seg3
                img(y,x)=actMycd3;
            else  %seg4
                img(y,x)=actMycd4;
            end;             
                
        end;       
        
    end;
end

end

