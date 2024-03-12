%save LenaNoSound EEG

clear all;
load LorenaNoPress


y=15;
[B,A] = cheby2(1,3,[0.00004 0.2]); %0.01Hz-45Hz (250Hz=1)
%[B,A] = cheby2(1,3,0.16);

% Design a filter with a Q-factor of Q=35 to remove a 60 Hz tone from 
% system running at 300 Hz.
%Wo = 50/(500/2);  BW = Wo/35;
%[b,a] = iirnotch(Wo,BW);  

chanlist=[1:1:32]; % Number Channels


EEG.data=double(EEG.data);

for z=1:32
    x=EEG.data(z,:);
    EEG.data(z,:)=filtfilt(B,A,x);
    %EEG.data(z,:)= filter(b,a,x);
end;

% figure;
%
% for z=1:length(chanlist)
%     subplot(32,1,z);
%     hold on;
%     plot(EEG.data(z,:),'k-');
% end;




figure;

pre=200; %samples (->1200ms vor Event)
post=600;%samples (->1200ms nach Event)
baseline=100; %samples (1200ms bis 1000ms vor Event, also 200ms Epoche ab pre)
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

for zz=1:length(chanlist)
    subplot(4,8,zz);
    hold on;
    title(EEG.chanlocs(zz).labels);
    plot([-pre*2:2:post*2],mean(data(zz).EEG),'r-');
    %plot([-pre*2:2:post*2],median(data(zz).EEG),'r-');
    axis([-pre*2 400 -y y]);
    line([-pre*2 post*2],[0 0],'color','blue');
    line([0 0],[-y y],'color','blue');
    
end;

%% LenaS

clear EEG;
load LorenaSound


y=15;
[B,A] = cheby2(1,3,[0.00004 0.18]); %0.01Hz-45Hz (250Hz=1)
%[B,A] = cheby2(1,3,0.16);

chanlist=[1:1:32]; % Number Channels


EEG.data=double(EEG.data);

for z=1:32
    x=EEG.data(z,:);
    EEG.data(z,:)=filtfilt(B,A,x);
end;

%% LENA SOA 0
clear data;
n=0;
for z=1:length(EEG.event)
    if strcmp(EEG.event(z).type(1:4),'S  1')
        n=n+1;
        i(n)=round(EEG.event(z).latency);
        
        for zz=1:length(chanlist)
            data(zz).EEG(n,:)=EEG.data(zz,i(n)-pre:i(n)+post);
%            data(zz).EEG(n,:)=detrend(data(zz).EEG(n,:));
            data(zz).EEG(n,:)=data(zz).EEG(n,:)-mean(data(zz).EEG(n,1:baseline));
            %plot([-pre*2:2:post*2],data(zz).EEG(n,:),'k-');
        end;
        
    end;
end;

for zz=1:length(chanlist)
    subplot(4,8,zz);
    hold on;
%    plot([-pre*2:2:post*2],median(data(zz).EEG),'g-');
    plot([-pre*2:2:post*2],mean(data(zz).EEG),'g-');
    
    dataSOA0(zz,:)=mean(data(zz).EEG);
end;

%% LENA SOA 600

clear data;
n=0;
for z=1:length(EEG.event)
    if strcmp(EEG.event(z).type(1:4),'S  4')
        n=n+1;
        i(n)=round(EEG.event(z).latency);
        
        for zz=1:length(chanlist)
            data(zz).EEG(n,:)=EEG.data(zz,i(n)-pre:i(n)+post);
            %data(zz).EEG(n,:)=detrend(data(zz).EEG(n,:));
            data(zz).EEG(n,:)=data(zz).EEG(n,:)-mean(data(zz).EEG(n,1:baseline));
            %plot([-pre*2:2:post*2],data(zz).EEG(n,:),'k-');
        end;
        
    end;
end;

for zz=1:length(chanlist)
    subplot(4,8,zz);
    hold on;
    plot([-pre*2:2:post*2],mean(data(zz).EEG),'k-');
%    plot([-pre*2:2:post*2],median(data(zz).EEG),'k-');
end;

%% LenaNoSound

clear EEG;
load LorenaNoSound


y=15;
[B,A] = cheby2(1,3,[0.00004 0.18]); %0.01Hz-45Hz (250Hz=1)
%[B,A] = cheby2(1,3,0.16);

chanlist=[1:1:32]; % Number Channels


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
        
        for zz=1:length(chanlist)
            data(zz).EEG(n,:)=EEG.data(zz,i(n)-pre:i(n)+post);
%            data(zz).EEG(n,:)=detrend(data(zz).EEG(n,:));
            data(zz).EEG(n,:)=data(zz).EEG(n,:)-mean(data(zz).EEG(n,1:baseline));
            %plot([-pre*2:2:post*2],data(zz).EEG(n,:),'k-');
        end;
        
    end;
end;

for zz=1:length(chanlist)
    subplot(4,8,zz);
    hold on;
%    plot([-pre*2:2:post*2],median(data(zz).EEG),'g-');

    plot([-pre*2:2:post*2],mean(data(zz).EEG),'b-');
    plot([-pre*2:2:post*2],dataSOA0(zz,:)-mean(data(zz).EEG),'m-');
end;


