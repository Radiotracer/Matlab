function [ c,ceq ] = radiusConstraint(x)
% x=[ inR,outR,actBp,actMycd1,actMycd2,actMycd3,actMycd4,actBkg]
% Detailed explanation goes here
ceq=[];
c(1)=-x(1)+40;  % inR>=0
% c(2)=-x(2);  % outR>=0
% c(3)=x(1)-x(2);


end

