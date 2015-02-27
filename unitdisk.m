function [ c, ceq ] = unitdisk( x )
%  Constrain functions muse be formulated so that they are in the form
%  c(x)<=0 or ceq(x)=0;
%   Detailed explanation goes here
c = x(1)^2+x(2)^2-1;
ceq=[];

end

