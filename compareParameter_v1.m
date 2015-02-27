function [ differencePara ] = compareParameter_v1( measuredPara, truePara )
% Compare the absolute difference between the measured parameters and the
% true parameters after rearranging the parameters into four different
% groups--center, activities, radii and thicknesses.
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
tmpMeasured=measuredPara;
tmpTrue=truePara;
for k=1:nseg
    tmpMeasured(6+(k-1))=measuredPara(6+2*(k-1));
    tmpMeasured(6+nseg+(k-1))=measuredPara(7+2*(k-1));
    tmpTrue(6+(k-1))=truePara(6+2*(k-1));
    tmpTrue(6+nseg+(k-1))=truePara(7+2*(k-1));
end
differencePara=tmpMeasured-tmpTrue;

end

