function AnalyzeEEG_All(channel);

%% Patrameter
pre=200; %samples (->1200ms vor Event)
post=600;%samples (->1200ms nach Event)
y=10; %Y-Achse
tpre=-200; %X-Achse ...
tpost=600;


subject{1}='JuliusICA';
subject{2}='EvaICA';
subject{3}='LenaICA';
subject{4}='LorenaICA';
subject{5}='MaxICA';
subject{6}='HansICA';
subject{7}='NinaICA';
subject{8}='RabiaICA';





for z=1:length(subject);
	[out1 out2 out3 EEGtime]=AnalyzeEEG_XL(subject{z},channel);
	
	dataNoPress(z,:)=out1(channel,:);
	datanosound(z,:)=out2(channel,:);
	dataSOA0(z,:)=out3(channel,:);
	dataSOA0corrected(z,:)=	dataSOA0(z,:)-datanosound(z,:);
	datadiff(z,:)=dataNoPress(z,:)-dataSOA0corrected(z,:);
end;

figure;
subplot(2,1,1);
hold on;
plot(EEGtime,mean(dataNoPress),'r-');
plot(EEGtime,mean(dataNoPress)+std(dataNoPress)./sqrt(length(subject)),'r:');
plot(EEGtime,mean(dataNoPress)-std(dataNoPress)./sqrt(length(subject)),'r:');
%plot(EEGtime,mean(dataSOA0)-mean(datanosound),'b-');
plot(EEGtime,mean(dataSOA0corrected),'b-');
plot(EEGtime,mean(dataSOA0corrected)+std(dataSOA0corrected)./sqrt(length(subject)),'b:');
plot(EEGtime,mean(dataSOA0corrected)-std(dataSOA0corrected)./sqrt(length(subject)),'b:');
%plot(EEGtime,mean(dataSOA0),'g:');
axis([tpre tpost -y y]);
line([tpre tpost],[0 0],'color','blue');
line([0 0],[-y y],'color','blue');
subplot(2,1,2);
hold on;
axis([tpre tpost -y y]);
line([tpre tpost],[0 0],'color','blue');
line([0 0],[-y y],'color','blue');
plot(EEGtime,mean(datadiff),'k-');
plot(EEGtime,mean(datadiff)+std(datadiff)./sqrt(length(subject)),'k:');
plot(EEGtime,mean(datadiff)-std(datadiff)./sqrt(length(subject)),'k:');


for t=1:length(EEGtime)
    %p(t)=signtest(datadiff(:,t))/2;
    p(t)=signtest(datadiff(:,t))/2;
    
    if p(t)<0.05
        plot(EEGtime(t),mean(datadiff(:,t)),'r.')
    end;
end;





