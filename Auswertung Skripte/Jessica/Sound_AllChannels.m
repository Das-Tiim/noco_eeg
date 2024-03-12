function Sound_AllChannels(fn)
% plots mean ERP for all channels for the auditory-only condition
% averaged over all subjects (corrected for inter-subject variance)

% general parameters
y = 15; % y-axis?
pre=200; %samples (->400ms vor Event)
post=600;%samples (->1200ms nach Event)
baseline=100; %samples (400ms bis 200ms vor Event, also 200ms Epoche ab pre)
chanlist = 1:31;

% number, index of error trials
ErrTr = ErrorTrials(fn);

clear EEG
load([fn 'NoPress'])

n=0;
for z=1:length(EEG.event)
    if strcmp(EEG.event(z).type(1:4),'S  1')
        n=n+1;
        i(n)=round(EEG.event(z).latency);

        for zz=1:length(chanlist)
%             subplot(4,8,zz);
%             hold on;
            data(zz).EEG(n,:)=EEG.data(zz,i(n)-pre:i(n)+post);
 %           data(zz).EEG(n,:)=detrend(data(zz).EEG(n,:));
            data(zz).EEG(n,:)=data(zz).EEG(n,:)-mean(data(zz).EEG(n,1:baseline));
            %plot([-pre*2:2:post*2],data(zz).EEG(n,:),'k-');
        end;

    end;
end;
