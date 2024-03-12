function [out1, out2, out3, out4, EEGtime,N,SD]=AnalyzeEEG_XL_SOA4(fn,channel,ErrTr)

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


%figure;

for s=1:4 %SOAs
	
	n=0;
    z = 1;
	%for z=1:length(EEG.event)-2
    while z <= length(EEG.event)-2
        if isempty(ErrTr{3,3}) == 0 & any([ErrTr{3,3}(:,1)]==z)
            z = ErrTr{3,3}(find(ErrTr{3,3}(:,1)==z),2)+1;
            continue
        end

        if strcmp(EEG.event(z).type(1:4),'S 10')
            n=n+1;
            i(n)=round(EEG.event(z).latency); %wann trial gestartet ist (?)

            for zz=chanlist
%                 subplot(4,8,zz);
%                 hold on;
                data(s,zz).EEG(n,:)=EEG.data(zz,i(n)-pre+SOA(s):i(n)+post+SOA(s));
                %Baseline Correction
                if bc=='epoc'
                    data(s,zz).EEG(n,:)=data(s,zz).EEG(n,:)-mean(data(s,zz).EEG(n,pre-baselinet0pre:pre-baselinet0pre+baseline));
%                     plot(EEGtime,data(s,zz).EEG(n,:),'k-');
                end
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
% 				plot(EEGtime,data(zz).EEG(n,:),'k-');
            end
        end
    end
end

for s=1:4
    for zz=chanlist
%         subplot(4,8,zz);
%         hold on;
%         axis([tpre tpost -y y]);
        soa(s).datanosound(zz,:)=mean(data(s,zz).EEG);
        SD(s).ns(zz,:)=std(data(s,zz).EEG);
%         plot(EEGtime,soa(s).datanosound(zz,:),'b-');
    end
end

%return;

%% Sound

clear EEG;
load ([fn 'Sound']);
EEG.data=double(EEG.data);

for z=1:31
	x=EEG.data(z,:);
	EEG.data(z,:)=filtfilt(B,A,x);
end

clear data;


for s=1:4
	TRIGGER=['S  ' num2str(s)];
	n=0;
    z = 1;
	%for z=1:length(EEG.event)
    while z <= length(EEG.event)
        if isempty(ErrTr{3,4}) == 0 & any([ErrTr{3,4}(:,1)]==z)
            z = ErrTr{3,4}(find(ErrTr{3,4}(:,1)==z),2)+1;
            continue
        end

        if strcmp(EEG.event(z).type(1:4),TRIGGER)
            n=n+1;
            i(n)=round(EEG.event(z).latency);

            for zz=chanlist
%                 subplot(4,8,zz);
%                 hold on;
                data(s,zz).EEG(n,:)=EEG.data(zz,i(n)-pre:i(n)+post);
                %Baseline Correction
                if bc=='epoc'
                    data(s,zz).EEG(n,:)=data(s,zz).EEG(n,:)-mean(data(s,zz).EEG(n,pre-baselinet0pre:pre-baselinet0pre+baseline));
%                     plot(EEGtime,data(s,zz).EEG(n,:),'k-');
                end
            end

        end
        z = z+1;
    end
	
	nsoa(s)=n;
end
N.s = nsoa;

if bc=='file'
	for zz=chanlist
		for s=1:4
			filebase=mean(mean(data(s,zz).EEG(:,pre-baselinet0pre:pre-baselinet0pre+baseline)));
			for z=1:nsoa(s)
				data(s,zz).EEG(z,:)=data(s,zz).EEG(z,:)-filebase;
% 				plot(EEGtime,data(zz).EEG(n,:),'k-');
            end
        end
    end
end

cstyle='gcbk';

for zz=chanlist
    if length(chanlist)>1
        subplot(4,8,zz);
    end
    for s=1:4
% 		hold on;
% 		plot(EEGtime,mean(data(s,zz).EEG),[cstyle(s) ':']);
% 		plot(EEGtime,mean(data(s,zz).EEG)-soa(s).datanosound(zz,:),[cstyle(s) '-']);
% 		%plot(EEGtime,mean(data(zz).EEG)+std(data(zz).EEG)./sqrt(n),'g:');
% 		%plot(EEGtime,mean(data(zz).EEG)-std(data(zz).EEG)./sqrt(n),'g:');
% 		%plot(EEGtime,mean(data(zz).EEG-datanosound(zz,:)),'b-');
% 		%plot(EEGtime,mean(data(zz).EEG)-datanosound(zz,:)+std(data(zz).EEG)./sqrt(n),'b:');
% 		%plot(EEGtime,mean(data(zz).EEG)-datanosound(zz,:)-std(data(zz).EEG)./sqrt(n),'b:');
% 		axis([tpre tpost -y y]);
% 		
% 		title([fn(1:end-3) ' | ' num2str(zz) ' | ' EEG.chanlocs(zz).labels]);
% 		line([tpre tpost],[0 0],'color','blue');
% 		line([0 0],[-y y],'color','blue');
% 		
% 		
		soa(s).dataSOA(zz,:)=mean(data(s,zz).EEG);
        SD(s).s(zz,:)=std(data(s,zz).EEG);
        
    end
    out1(zz,:)=mean(data(1,zz).EEG)-soa(1).datanosound(zz,:);
    out2(zz,:)=mean(data(2,zz).EEG)-soa(2).datanosound(zz,:);
    out3(zz,:)=mean(data(3,zz).EEG)-soa(3).datanosound(zz,:);
    out4(zz,:)=mean(data(4,zz).EEG)-soa(4).datanosound(zz,:);
end




