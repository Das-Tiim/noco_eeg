clear;close all;clc

maxsoa=1.500;
minsoa=-0.500
soas=round(linspace(minsoa,maxsoa,50),3)
number_trials=130;
expected_time=mean(soas);


exp_PDF=1/expected_time.*exp(-soas./expected_time)
exp_PDF=exp_PDF./sum(exp_PDF);

trials_experiment=exp_PDF.*number_trials
trials_experiment=round(trials_experiment)


subplot(3,1,1)
plot(soas,exp_PDF,".-")
subplot(3,1,2)

% adjusting rt 
bar(soas,trials_experiment)


%trials_experiment

p = trials_experiment/number_trials;
cumP = cumsum(p);
S = 1-cumP;
h = p./S;

subplot(3,1,3)

plot(soas, h, 'k')
%xlim([0 maxsoa])

u=repelem(soas, trials_experiment)
