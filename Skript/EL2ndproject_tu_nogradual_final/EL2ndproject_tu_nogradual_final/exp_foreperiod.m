% non aging foreperiod
% 25/04/2007 pedro
function [f] = exp_foreperiod(meanD, N, minD, maxD, frameD) 
    
if nargin<5; frameD = 1; end
if nargin<4; maxD = -1; end
if nargin<3; minD = 0; end
if nargin<2; N = 1; end
    

    meanD = meanD - minD;
    maxD = maxD - minD;
   
    d=exprnd(meanD,N,1);
    if maxD>0;
        while any(d(d>maxD))
            d(d>maxD) = exprnd(meanD,size(d(d>maxD)));
        end
    end

    f = round((d+ minD)/frameD);
    
end