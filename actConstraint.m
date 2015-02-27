function [ c,ceq ] = actConstraint(x)
% x=[ inR,outR,actBp,actMycd1,actMycd2,actMycd3,actMycd4,actBkg]
% Detailed explanation goes here
ceq=[];
c(1)=-x(1);  % inR>=0
c(2)=-x(2);  % outR>=0
c(3)=-x(3);
c(4)=-x(4);
c(5)=-x(5);
c(6)=-x(6);
end

