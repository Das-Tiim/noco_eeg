function [out1 out2 out3 EEGtime]=AnalyzeEEG_XL(fn,channel);

% Aufruf: [out1 out2 out3 EEGtime]=AnalyzeEEG_XL(fn,channel);
% fn=filename (subject)
% Optional: channel=single channel number [1->32]; all channels by default
% out1=dataNoPress;
% out2=datanosound;
% out3=dataSOA0;
% EEGtime
% 11.08.2022

if nargin<2
	chanlist=[1:1:32]; % Number Channels
else
	chanlist=channel;
end;



%% Patrameter
pre=200; %samples (->1200ms vor Event)
post=600;%samples (->1200ms nach Event)
baseline=50; %samples (1200ms bis 1000ms vor Event, also 200ms Epoche ab pre)
baselinet0pre=50; %start of baseline in samples pre event of interest
y=15; %Y-Achse
tpre=-200; %X-Achse ...
tpost=400;
[B,A] = cheby2(1,3,[0.00004 0.2]); %0.01Hz-45Hz (250Hz=1)
bc='epoc'; %Baseline correction method: 'epoc'/'none'/'file'
%bc='file'; %Baseline correction method: 'epoc'/'none'/'file'




%% No Press
load ([fn 'NoPress']);

EEG.data=double(EEG.data);

for z=1:32
    x=EEG.data(z,:);
    EEG.data(z,:)=filtfilt(B,A,x);
    
end;

EEGtime=[-pre*2:2:post*2];

figure;
n=0;
for z=1:length(EEG.event)
    if strcmp(EEG.event(z).type(1:4),'S  1')
        n=n+1;
        i(n)=round(EEG.event(z).latency);
        
        for zz=chanlist
            %subplot(4,8,zz);
            %hold on;
            data(zz).EEG(n,:)=EEG.data(zz,i(n)-pre:i(n)+post);
            %Baseline Correction
            if bc=='epoc'
                data(zz).EEG(n,:)=data(zz).EEG(n,:)-mean(data(zz).EEG(n,pre-baselinet0pre:pre-baselinet0pre+baseline));
                %plot(EEGtime,data(zz).EEG(n,:),'k-');
            end;
        end;
        
    end;
end;

nnopress=n;

if bc=='file'
    for zz=chanlist
        filebase=mean(mean(data(zz).EEG(:,pre-baselinet0pre:pre-baselinet0pre+baseline)));
        for z=1:nnopress
            data(zz).EEG(z,:)=data(zz).EEG(z,:)-filebase;
            %plot(EEGtime,data(zz).EEG(n,:),'k-');
        end;
    end;
end;

for zz=chanlist
	if length(chanlist)>1
	    subplot(4,8,zz);
	end;
    hold on;
    title([num2str(zz) '|' EEG.chanlocs(zz).labels]);
    plot(EEGtime,mean(data(zz).EEG),'r-');
    plot(EEGtime,mean(data(zz).EEG)+std(data(zz).EEG)./sqrt(n),'r:');
    plot(EEGtime,mean(data(zz).EEG)-std(data(zz).EEG)./sqrt(n),'r:');
    axis([tpre tpost -y y]);
    line([tpre tpost],[0 0],'color','blue');
    line([0 0],[-y y],'color','blue');
    
    dataNoPress(zz,:)=mean(data(zz).EEG);

    
end;


%% PRESS AKA NoSound

clear EEG;
load ([fn 'NoSound']);

EEG.data=double(EEG.data);

for z=1:32
    x=EEG.data(z,:);
    EEG.data(z,:)=filtfilt(B,A,x);
end;

clear data;

n=0;
for z=1:length(EEG.event)
    if strcmp(EEG.event(z).type(1:4),'S 10')
        n=n+1;
        i(n)=round(EEG.event(z).latency);
        
        for zz=chanlist
            %subplot(4,8,zz);
            %hold on;
            data(zz).EEG(n,:)=EEG.data(zz,i(n)-pre:i(n)+post);
            %Baseline Correction
            if bc=='epoc'
                data(zz).EEG(n,:)=data(zz).EEG(n,:)-mean(data(zz).EEG(n,pre-baselinet0pre:pre-baselinet0pre+baseline));
                %plot(EEGtime,data(zz).EEG(n,:),'k-');
            end;
        end;
        
    end;
end;

nnosound=n;

if bc=='file'
    for zz=chanlist
        filebase=mean(mean(data(zz).EEG(:,pre-baselinet0pre:pre-baselinet0pre+baseline)));
        for z=1:nnosound
            data(zz).EEG(z,:)=data(zz).EEG(z,:)-filebase;
            %plot(EEGtime,data(zz).EEG(n,:),'k-');
        end;
    end;
end;

for zz=chanlist
%     subplot(4,8,zz);
%     hold on;
%     axis([tpre tpost -y y]);

    datanosound(zz,:)=mean(data(zz).EEG);
    %plot(EEGtime,datanosound(zz,:),'k-');
end;




%% Sound

clear EEG;
load ([fn 'Sound']);
EEG.data=double(EEG.data);

for z=1:32
    x=EEG.data(z,:);
    EEG.data(z,:)=filtfilt(B,A,x);
end;

clear data;

%% SOA 0

n=0;
for z=1:length(EEG.event)
    if strcmp(EEG.event(z).type(1:4),'S  4')
        n=n+1;
        i(n)=round(EEG.event(z).latency);
        
        for zz=chanlist
            %subplot(4,8,zz);
            %hold on;
            data(zz).EEG(n,:)=EEG.data(zz,i(n)-pre:i(n)+post);
            %Baseline Correction
            if bc=='epoc'
                data(zz).EEG(n,:)=data(zz).EEG(n,:)-mean(data(zz).EEG(n,pre-baselinet0pre:pre-baselinet0pre+baseline));
                %plot(EEGtime,data(zz).EEG(n,:),'k-');
            end;
        end;
        
    end;
end;

nSOA0=n;

if bc=='file'
    for zz=chanlist
        filebase=mean(mean(data(zz).EEG(:,pre-baselinet0pre:pre-baselinet0pre+baseline)));
        for z=1:nSOA0
            data(zz).EEG(z,:)=data(zz).EEG(z,:)-filebase;
            plot(EEGtime,data(zz).EEG(n,:),'k-');
        end;
    end;
end;

for zz=chanlist
	if length(chanlist)>1
	    subplot(4,8,zz);
	end;
    hold on;
    plot(EEGtime,mean(data(zz).EEG),'g-');
    plot(EEGtime,mean(data(zz).EEG)+std(data(zz).EEG)./sqrt(n),'g:');
    plot(EEGtime,mean(data(zz).EEG)-std(data(zz).EEG)./sqrt(n),'g:');
    plot(EEGtime,mean(data(zz).EEG-datanosound(zz,:)),'b-');
    plot(EEGtime,mean(data(zz).EEG)-datanosound(zz,:)+std(data(zz).EEG)./sqrt(n),'b:');
    plot(EEGtime,mean(data(zz).EEG)-datanosound(zz,:)-std(data(zz).EEG)./sqrt(n),'b:');
    axis([tpre tpost -y y]);

    

    dataSOA0(zz,:)=mean(data(zz).EEG);
    
end; 


out1=dataNoPress;
out2=datanosound;
out3=dataSOA0;



