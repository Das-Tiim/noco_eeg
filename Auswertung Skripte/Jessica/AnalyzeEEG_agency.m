function [out1, out2, out3, out4, EEGtime, soa, con_info, st_lat]=AnalyzeEEG_agency(fn,channel,ErrTr)

% Aufruf: [out1 out2 out3 out4 EEGtime]=AnalyzeEEG_XL_SOA4(fn,channel);
% fn=filename (subject)
% Optional: channel=single channel number [1->32]; all channels by default
% out1=dataNoPress;
% out2=datanosound;
% out3=dataSOA0;
% EEGtime
% 11.08.2022

if nargin<2
	chanlist=[1:1:31]; % Number Channels
else
	chanlist=channel;
end



%% Patrameter
pre=200; %samples (->1200ms vor Event)
post=600;%samples (->1200ms nach Event)
baseline=50; %samples (1200ms bis 1000ms vor Event, also 200ms Epoche ab pre)
baselinet0pre=50; %start of baseline in samples pre event of interest
y=15; %Y-Achse
tpre=-200; %X-Achse [in ms]...
tpost=400;
[B,A] = cheby2(1,3,[0.00004 0.2]); %0.01Hz-45Hz (250Hz=1)
bc='epoc'; %Baseline correction method: 'epoc'/'none'/'file'
%bc='file'; %Baseline correction method: 'epoc'/'none'/'file'
EEGtime=[-pre*2:2:post*2];


%% PRESS AKA NoSound

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


for s=1:4 %SOAs
	
	n=0;
    z =1;
    %for z=1:length(EEG.event)
    while z <= length(EEG.event)
        if isempty(ErrTr{3,3}) == 0 & any([ErrTr{3,3}(:,1)]==z)
            z = ErrTr{3,3}(find(ErrTr{3,3}(:,1)==z),2)+1;
            continue
        end
        if strcmp(EEG.event(z).type(1:4),'S 10')
            n=n+1;
            i(n)=round(EEG.event(z).latency); %wann trial gestartet ist (?)
            
            for zz=chanlist
                data(s,zz).EEG(n,:)=EEG.data(zz,i(n)-pre+SOA(s):i(n)+post+SOA(s));
                %Baseline Correction
                if bc=='epoc'
	                data(s,zz).EEG(n,:)=data(s,zz).EEG(n,:)-mean(data(s,zz).EEG(n,pre-baselinet0pre:pre-baselinet0pre+baseline));
                end
            end
	        
        end
        z = z+1;
    end
    nsoa(s)=n;
    is{s} = i;
end

nnosound=n;

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
        %dataP{s,zz} = data(s,zz).EEG;
    end
end

[con_info{2:4,1}] = deal('NoSound', 'NoPress', 'Sound');
[con_info{1,2:3}] = deal('N trials', 'latencies');
[con_info{2,2:3}] = deal(nsoa, is);
%return;


% %% No Press
% clear EEG
% clear data
% load ([fn 'NoPress']);
% 
% EEG.data=double(EEG.data);
% 
% for z=1:32
%     x=EEG.data(z,:);
%     EEG.data(z,:)=filtfilt(B,A,x);
%     
% end
% 
% for s=1:4
%     n=0;
%     for z=1:length(EEG.event)
%         if strcmp(EEG.event(z).type(1:4),'S  1')
%            n=n+1;
%            i(n)=round(EEG.event(z).latency); % wann trial gestartet ist (?)
%            for zz=chanlist
%                data(s,zz).EEG(n,:)=EEG.data(zz,i(n)-pre:i(n)+post);
%                %Baseline Correction
%                if bc=='epoc'
%                    data(s,zz).EEG(n,:)=data(s,zz).EEG(n,:)-mean(data(s,zz).EEG(n,pre-baselinet0pre:pre-baselinet0pre+baseline));
%                end
%            end
%         end
%     end
%     nsoa(s)=n;
%     is{s} = i;
% end
% 
% nnopress=n;
% 
% if bc=='file'
%     for zz=chanlist
%         for s = 1:4 
%             filebase=mean(mean(data(s,zz).EEG(:,pre-baselinet0pre:pre-baselinet0pre+baseline)));
%             for z=1:nnopress
%                 data(s,zz).EEG(z,:)=data(s,zz).EEG(z,:)-filebase;
%             end
%         end
%     end
% end
% 
% for s = 1:4
%     for zz=chanlist
%         soa(s).datanopress(zz,:) = mean(data(s,zz).EEG);
% %         dataNoPress(zz,:)=mean(data(zz).EEG);
%     end
% end
% 
% %[con_info{2:4,1}] = deal('NoSound', 'NoPress', 'Sound');
% %[con_info{1,2:3}] = deal('N trials', 'latencies');
% [con_info{3,2:3}] = deal(nsoa, is);


%% Sound

clear EEG;
load ([fn 'Sound']);
EEG.data=double(EEG.data);

for z=1:31
	x=EEG.data(z,:);
	EEG.data(z,:)=filtfilt(B,A,x);
end

clear data;

st = [];
for t = 1:length(EEG.event)
    if strcmp(EEG.event(t).type(1:4), 'S101')
        st = horzcat(st, round(EEG.event(t).latency));
    end
end

for s=1:4
	TRIGGER=['S  ' num2str(s)];
	n=0;
    z =1;
    %for z=1:length(EEG.event)
    st_nr = [];
    while z <= length(EEG.event)
        if isempty(ErrTr{3,4}) == 0 & any([ErrTr{3,4}(:,1)]==z)
            z = ErrTr{3,4}(find(ErrTr{3,4}(:,1)==z),2)+1;
            continue
        end
        
        if strcmp(EEG.event(z).type(1:4), 'S101') & strcmp(EEG.event(z+2).type(1:4),TRIGGER)
            l = find(st == round(EEG.event(z).latency));
            if length(fn) == 7 & fn == 'nr08ICA' & l >= 221
                l = l+2;
            end
            st_nr = horzcat(st_nr, l);
        end
        
        if strcmp(EEG.event(z).type(1:4),TRIGGER)
            n=n+1;
            i(n)=round(EEG.event(z).latency);
            
            for zz=chanlist
                data(s,zz).EEG(n,:)=EEG.data(zz,i(n)-pre:i(n)+post);
                %Baseline Correction
                if bc=='epoc'
	                data(s,zz).EEG(n,:)=data(s,zz).EEG(n,:)-mean(data(s,zz).EEG(n,pre-baselinet0pre:pre-baselinet0pre+baseline));
                end
            end
	        
        end
        z = z+1;
    end
	is{s} = i;
	nsoa(s)=n;
    st_lat{s} = st_nr;
end

%[con_info{2:4,1}] = deal('NoSound', 'NoPress', 'Sound');
%[con_info{1,2:3}] = deal('N trials', 'latencies');
[con_info{4,2:3}] = deal(nsoa, is);

if bc=='file'
    for zz=chanlist
        for s=1:4
            filebase=mean(mean(data(s,zz).EEG(:,pre-baselinet0pre:pre-baselinet0pre+baseline)));
            for z=1:nsoa(s)
	            data(s,zz).EEG(z,:)=data(s,zz).EEG(z,:)-filebase;
            end
        end
    end
end

%cstyle='gcbk';

for zz=chanlist
    for s=1:4		
	    soa(s).dataSOA(zz,:)=mean(data(zz).EEG);
    end
    % motor correction
    %     out1(zz,:)=mean(data(1,zz).EEG)-soa(1).datanosound(zz,:);
    %     out2(zz,:)=mean(data(2,zz).EEG)-soa(2).datanosound(zz,:);
    %     out3(zz,:)=mean(data(3,zz).EEG)-soa(3).datanosound(zz,:);
    %     out4(zz,:)=mean(data(4,zz).EEG)-soa(4).datanosound(zz,:);
    out1 = data(1,zz).EEG-soa(1).datanosound(zz,:);
    out2 = data(2,zz).EEG-soa(2).datanosound(zz,:);
    out3 = data(3,zz).EEG-soa(3).datanosound(zz,:);
    out4 = data(4,zz).EEG-soa(4).datanosound(zz,:);
    
end



end
