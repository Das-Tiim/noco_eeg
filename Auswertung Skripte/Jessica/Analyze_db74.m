function [outA, outS, EEGtime, N, SD] = Analyze_db74(channel, fn, ErrTr, trA, trS)
% sorts EEG trials whether the same loudness was judged louder or quieter


%% Parameters
if nargin<2
	chanlist = 1:1:31; % Number Channels
else
	chanlist = channel;
end

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



%% motor-only (for motor correction)
load ([fn 'NoSound']);

EEG.data=double(EEG.data);

for z=1:31
    x=EEG.data(z,:);
    EEG.data(z,:)=filtfilt(B,A,x);
end

EEGtime = -pre*2:2:post*2;


n=0;
z = 1;
while z <= length(EEG.event)
    if isempty([ErrTr{3,3}]) == 0 & any([ErrTr{3,3}(:,1)]==z)
        z = ErrTr{3,3}(find(ErrTr{3,3}(:,1)==z),2)+1;
        continue
    end

    if strcmp(EEG.event(z).type(1:4),'S 10')
        n=n+1;
        i(n)=round(EEG.event(z).latency);
        
        for zz=chanlist
            data(zz).EEG(n,:)=EEG.data(zz,i(n)-pre:i(n)+post);
            %Baseline Correction
            if bc=='epoc'
                data(zz).EEG(n,:)=data(zz).EEG(n,:)-mean(data(zz).EEG(n,pre-baselinet0pre:pre-baselinet0pre+baseline));
            end
        end
        
    end
    z = z+1;
end

nnosound=n;
N.ns = nnosound;
if bc=='file'
    for zz=chanlist
        filebase=mean(mean(data(zz).EEG(:,pre-baselinet0pre:pre-baselinet0pre+baseline)));
        for z=1:nnosound
            data(zz).EEG(z,:)=data(zz).EEG(z,:)-filebase;
        end
    end
end

for zz=chanlist  
    dataNoSound(zz,:)=mean(data(zz).EEG);
    sd_ns(zz,:)=std(data(zz).EEG);
end

SD.ns = sd_ns;


%% Auditory-only

clear EEG;
load([fn 'NoPress']);

EEG.data=double(EEG.data);

for z=1:31
    x=EEG.data(z,:);
    EEG.data(z,:)=filtfilt(B,A,x);
end

clear data;

n=0;
z=1;
while z <= length(EEG.event)
    if isempty([ErrTr{3,2}]) == 0 & any([ErrTr{3,2}(:,1)]==z)
        z = ErrTr{3,2}(find(ErrTr{3,2}(:,1)==z),2)+1;
        continue
    end
    
    if strcmp(EEG.event(z).type(1:4),'S  1')
        n=n+1;

        if ismember(n, trA{1,1}) % if index of this trial is 74dB and 1. tone judged louder
            i1(n)=round(EEG.event(z).latency);
    
            for zz=chanlist
                %             subplot(4,8,zz);
                %             hold on;
                data1(zz).EEG(n,:)=EEG.data(zz,i1(n)-pre:i1(n)+post);
                %Baseline Correction
                if bc=='epoc'
                    data1(zz).EEG(n,:)=data1(zz).EEG(n,:)-mean(data1(zz).EEG(n,pre-baselinet0pre:pre-baselinet0pre+baseline));
                    %plot(EEGtime,data(zz).EEG(n,:),'k-');
                end
            end
        elseif ismember(n, trA{1,2}) % if index of this trial is 74dB and 2. tone judged louder
            i2(n)=round(EEG.event(z).latency);
    
            for zz=chanlist
                data2(zz).EEG(n,:)=EEG.data(zz,i2(n)-pre:i2(n)+post);
                %Baseline Correction
                if bc=='epoc'
                    data2(zz).EEG(n,:)=data2(zz).EEG(n,:)-mean(data2(zz).EEG(n,pre-baselinet0pre:pre-baselinet0pre+baseline));
                    %plot(EEGtime,data(zz).EEG(n,:),'k-');
                end
            end
        end
    end
    z = z+1;
end

nnopress=n;
N.np = nnopress;

outA.t1 = data1(chanlist).EEG(trA{1},:);
outA.t2 = data2(chanlist).EEG(trA{2},:);


%% Sound
clear EEG;
load([fn 'Sound']);

EEG.data=double(EEG.data);

for z=1:31
    x=EEG.data(z,:);
    EEG.data(z,:)=filtfilt(B,A,x);
end

clear data1 data2

n=0;
z=1;
while z <= length(EEG.event)
    if isempty([ErrTr{3,4}]) == 0 & any([ErrTr{3,4}(:,1)]==z)
        z = ErrTr{3,4}(find(ErrTr{3,4}(:,1)==z),2)+1;
        continue
    end
    
    if strcmp(EEG.event(z).type(1:4),'S  1') | strcmp(EEG.event(z).type(1:4),'S  2') | strcmp(EEG.event(z).type(1:4),'S  3') | strcmp(EEG.event(z).type(1:4),'S  4')
        n=n+1;

        if ismember(n, trS{1,1}) % if index of this trial is 74dB and 1. tone judged louder
            i1(n)=round(EEG.event(z).latency);
    
            for zz=chanlist
                %             subplot(4,8,zz);
                %             hold on;
                data1(zz).EEG(n,:)=EEG.data(zz,i1(n)-pre:i1(n)+post);
                %Baseline Correction
                if bc=='epoc'
                    data1(zz).EEG(n,:)=data1(zz).EEG(n,:)-mean(data1(zz).EEG(n,pre-baselinet0pre:pre-baselinet0pre+baseline));
                    %plot(EEGtime,data(zz).EEG(n,:),'k-');
                end
            end
        elseif ismember(n, trS{1,2}) % if index of this trial is 74dB and 2. tone judged louder
            i2(n)=round(EEG.event(z).latency);
    
            for zz=chanlist
                data2(zz).EEG(n,:)=EEG.data(zz,i2(n)-pre:i2(n)+post);
                %Baseline Correction
                if bc=='epoc'
                    data2(zz).EEG(n,:)=data2(zz).EEG(n,:)-mean(data2(zz).EEG(n,pre-baselinet0pre:pre-baselinet0pre+baseline));
                    %plot(EEGtime,data(zz).EEG(n,:),'k-');
                end
            end
        end
    end
    z = z+1;
end

nsound=n;
N.s = nsound;

outS.t1 = data1(chanlist).EEG(trS{1},:) - dataNoSound(chanlist,:);
outS.t2 = data2(chanlist).EEG(trS{2},:) - dataNoSound(chanlist,:);

