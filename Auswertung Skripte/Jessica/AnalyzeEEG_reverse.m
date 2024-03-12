function [soa,SD,N,EEGtime] = AnalyzeEEG_reverse(channel, fn)

% quasi gleiche Vorverarbeitung nur diesmal erst motor correction und dann
% baseline correction

% dann beim motor-only auch erstmal baseline correction weglassen, richtig?


% Input:
% channel = number of EEG channel of interest
% fn = code/name of subject/data
% ErrTr = numbers/indices of error trials for that subject in that condition

% data = 4x32 struct ( 4 SOAs, 32 channels), in jedem Feld dann EEG Daten
%       (rows = trials, columns = 801 data points)
% N = struct, 1 field per condition with number of trials
% SD = struct: rows = soa, columns = condition, per field  1 mean SD for ERP (rows =
%      channel, columns = 801 data points)
% soa = same as SD but with mean

if nargin<2
	chanlist=[1:1:31]; % Number Channels
else
	chanlist=channel;
end

%% Parameter
pre=200; %samples (->1200ms vor Event)
post=600;%samples (->1200ms nach Event)
baseline=50; %samples (1200ms bis 1000ms vor Event, also 200ms Epoche ab pre)
baselinet0pre=50; %start of baseline in samples pre event of interest
y=15; %Y-Achse
tpre=-200; %X-Achse ...
tpost=400;
[B,A] = cheby2(1,3,[0.00004 0.2]); %0.01Hz-45Hz (250Hz=1)
bc='epoc'; %Baseline correction method: 'epoc'/'none'/'file'


%% Error Trials
ErrTr = ErrorTrials(fn);


%% motor-only

clear EEG;
load ([fn 'NoSound']);

EEG.data=double(EEG.data);

for z=1:31
    x=EEG.data(z,:);
    EEG.data(z,:)=filtfilt(B,A,x);
end

clear data;


SOA=[0 50 200 600]; %SOA in ms
SOA=round(SOA./2); % SOA in samples

for s = 1:4
    n=0;
    z=1;
    %for z=1:length(EEG.event)
    while z <= length(EEG.event)
        if isempty(ErrTr{3,3}) == 0 & any([ErrTr{3,3}(:,1)]==z)
            z = ErrTr{3,3}(find(ErrTr{3,3}(:,1)==z),2)+1;
            continue
        end

        if strcmp(EEG.event(z).type(1:4),'S 10')
            n=n+1;
            i(n)=round(EEG.event(z).latency);
            
            for zz=chanlist
                data(s,zz).EEG(n,:)=EEG.data(zz,i(n)-pre+SOA(s):i(n)+post+SOA(s));
                %Baseline Correction
    %             if bc=='epoc'
    %                 data(s,zz).EEG(n,:)=data(s,zz).EEG(n,:)-mean(data(s,zz).EEG(n,pre-baselinet0pre:pre-baselinet0pre+baseline));
    %             end
            end
        
        end
        z = z+1;
    end
end

nnosound=n;
N.ns = nnosound;

if bc=='file'
    for zz=chanlist
        for s=1:4
            filebase=mean(mean(data(s,zz).EEG(:,pre-baselinet0pre:pre-baselinet0pre+baseline)));
            for z=1:nnosound
                data(s,zz).EEG(z,:)=data(s,zz).EEG(z,:)-filebase;
            end
        end
    end
end

for s=1:4
    for zz=chanlist
        soa(s).datanosound(zz,:)=mean(data(s,zz).EEG);
        SD(s).ns(zz,:)=std(data(s,zz).EEG);
    end
end


%% Auditory-only

clear EEG
load ([fn 'NoPress']);

EEG.data=double(EEG.data);

for z=1:31
    x=EEG.data(z,:);
    EEG.data(z,:)=filtfilt(B,A,x);
end

EEGtime=[-pre*2:2:post*2];

n=0;
z = 1;
while z <= length(EEG.event)
%for z=1:length(EEG.event)
    %disp(z)
    if isempty([ErrTr{3,2}]) == 0 & any([ErrTr{3,2}(:,1)]==z)
        z = ErrTr{3,2}(find(ErrTr{3,2}(:,1)==z),2)+1;
        continue
    end

    if strcmp(EEG.event(z).type(1:4),'S  1')
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

nnopress=n;
N.np = nnopress;

if bc=='file'
    for zz=chanlist
        filebase=mean(mean(data(zz).EEG(:,pre-baselinet0pre:pre-baselinet0pre+baseline)));
        for z=1:nnopress
            data(zz).EEG(z,:)=data(zz).EEG(z,:)-filebase;
            %plot(EEGtime,data(zz).EEG(n,:),'k-');
        end
    end
end

for zz=chanlist
    dataNoPress(zz,:)=mean(data(zz).EEG);
    sd_np(zz,:)=std(data(zz).EEG);
end
soa(1).datanopress = dataNoPress;
SD(1).np = sd_np;

%% motor-auditory

clear EEG;
load ([fn 'Sound']);
EEG.data=double(EEG.data);

for z=1:31
    x=EEG.data(z,:);
    EEG.data(z,:)=filtfilt(B,A,x);
end

clear data;

for s = 1:4
    TRIGGER = ['S  ' num2str(s)];
    n=0;
    z=1;
    % for z=1:length(EEG.event)
    while z <= length(EEG.event)
        if isempty(ErrTr{3,4}) == 0 & any([ErrTr{3,4}(:,1)]==z)
            z = ErrTr{3,4}(find(ErrTr{3,4}(:,1)==z),2)+1;
            continue
        end

        if strcmp(EEG.event(z).type(1:4),TRIGGER)
            n=n+1;
            i(n)=round(EEG.event(z).latency);
            
            for zz=chanlist
                data(s,zz).EEG(n,:)=EEG.data(zz,i(n)-pre:i(n)+post);
                % motor correction
                data(s,zz).EEG(n,:) = data(s,zz).EEG(n,:) - soa(s).datanosound(zz,:);
                % Baseline Correction
                if bc=='epoc'
                    data(s,zz).EEG(n,:)=data(s,zz).EEG(n,:)-mean(data(s,zz).EEG(n,pre-baselinet0pre:pre-baselinet0pre+baseline));
                end
            end
        end
        z = z+1;
    end
    nsoa(s) = n;
end

N.s = nsoa;

if bc=='file'
    for zz=chanlist
        for s = 1:4
            filebase=mean(mean(data(s,zz).EEG(:,pre-baselinet0pre:pre-baselinet0pre+baseline)));
            for z=1:nSOA0
                data(s,zz).EEG(z,:)=data(s,zz).EEG(z,:)-filebase;
            end
        end
    end
end

for zz=chanlist
    for s=1:4
        soa(s).dataSOA(zz,:)=mean(data(s,zz).EEG);
        SD(s).s(zz,:)=std(data(s,zz).EEG);
    end 

%     out1=dataNoPress;
%     out2=datanosound;
%     out3=dataSOA0;
end
