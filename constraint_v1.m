function [ c,ceq ] = constraint_v1(p)
%  Parameters: 
% (a) Center :p(1),p(2)
% (b) Blood pool activity; p(3)
% (c) Background activity; p(4)
% (d )Myocardium activity p(5) 
% For each segment in myocardium (8 segments):
% The 1st segment
%(d)Central point radius on endocardium  p(6) 
%(f)Thickness p(7)

% The qth segment: p(6+2*(q-1):7+2*(q-1))

global nseg;

eqIdx=1;
idx=1;
% #1: Uniform myocardial activity
for k=1:(nseg-1)
    ceq(eqIdx)=p(6+(k-1)*2)-p(6+k*2);eqIdx=eqIdx+1;
end

% #2: Uniform myocardium thickness
for k=1:(nseg-1)
    ceq(eqIdx)=p(7+(k-1)*2)-p(7+k*2);eqIdx=eqIdx+1;
end

% #3:Activity
c(idx)=p(3)-p(5);idx=idx+1;
c(idx)=p(4)-p(3);

% #2: Mycardium & Endocardium radius Ratio (assume Truth=0.75),Range=[0.7 0.8]
% for k=1:nseg
%     c(idx)=0.7-p(6+(k-1)*3)/p(5+(k-1)*3);idx=idx+1;
%     c(idx)=p(6+(k-1)*3)/p(5+(k-1)*3)-0.8;idx=idx+1;
% end

% #3: 


end

