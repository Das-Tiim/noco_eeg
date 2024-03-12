

% function [f] = exp_foreperiod(meanD, N, minD, maxD, frameD) 


frameD = 1;  % duration of frame in ms. this is the temporal unit.
maxD = 800; % maximal duration
minD = -500 %300; % minimal duration
N = 100;% number of trials;
meanD = 0; % mean of the moment of appearance of the stimulus.

[f] = exp_foreperiod(meanD, N, minD, maxD, frameD);
ff = unique(f);

figure(1)
subplot(121)
hist(f,linspace(minD, maxD, 40));
[n,x] = hist(f,linspace(minD, maxD, 40));
xlim([minD maxD])

p = n/N;
cumP = cumsum(p);
S = 1-cumP;
h = p./S;


subplot(122)
plot(x, h, 'k')
xlim([minD maxD])




%% added by Elisabeth 01.10.2021
count=sum(f<-300)
count1=sum(f>-200 & f<-50)
count2=sum(f>-50 & f<50)
count3=sum(f>50 & f<200)
count5=sum(f>200 & f<400)
count5=sum(f>400)
count5=sum(f)/100
count6=sum(f(f>-1))

length(f)

