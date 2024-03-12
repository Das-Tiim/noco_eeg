function AnalyzeEEG_All(channel);

%% Patrameter
pre=200; %samples (->1200ms vor Event)
post=600;%samples (->1200ms nach Event)
y=10; %Y-Achse
tpre=-200; %X-Achse ...
tpost=400;


subject{1}='JuliusICA';
subject{2}='EvaICA';
subject{3}='LenaICA';
subject{4}='LorenaICA';
subject{5}='MaxICA';
subject{6}='HansICA';
subject{7}='NinaICA';
subject{8}='RabiaICA';



for z=1:length(subject);
	[out1 out2 out3 out4 EEGtime]=AnalyzeEEG_XL_SOA4(subject{z},channel);
	
	dataSOA1(z,:)=out1(channel,:);
	dataSOA2(z,:)=out2(channel,:);
	dataSOA3(z,:)=out3(channel,:);
	dataSOA4(z,:)=out4(channel,:);
end;

figure;
% subplot(2,1,1);
hold on;
plot(EEGtime,mean(dataSOA1),'g-');
plot(EEGtime,mean(dataSOA2),'c-');
plot(EEGtime,mean(dataSOA3),'b-');
plot(EEGtime,mean(dataSOA4),'k-');
plot(EEGtime,mean(dataNoPress)+std(dataNoPress)./sqrt(length(subject)),'r:');
axis([tpre tpost -y y]);
line([tpre tpost],[0 0],'color','blue');
line([0 0],[-y y],'color','blue');
title('FCz')
legend({'0ms', '50ms', '200ms', '600ms'});
ylabel ('mean amplitude (µV)');
xlabel ('time (ms)');

% subplot(2,1,2);
% hold on;
% axis([tpre tpost -y y]);
% line([tpre tpost],[0 0],'color','blue');
% line([0 0],[-y y],'color','blue');
% plot(EEGtime,mean(datadiff),'k-');
% plot(EEGtime,mean(datadiff)+std(datadiff)./sqrt(length(subject)),'k:');
% plot(EEGtime,mean(datadiff)-std(datadiff)./sqrt(length(subject)),'k:');
% 
for t=1:length(EEGtime)
    p2(t)=signtest(dataSOA1(:,t),dataSOA2(:,t))/2;
    if p2(t)<0.05
        plot(EEGtime(t),mean(dataSOA2(:,t)),'r.');
    end;
    p3(t)=signtest(dataSOA2(:,t),dataSOA3(:,t))/2;
    if p3(t)<0.05
        plot(EEGtime(t),mean(dataSOA3(:,t)),'r.');
    end;
    p4(t)=signtest(dataSOA1(:,t),dataSOA4(:,t))/2;
    if p4(t)<0.05
        plot(EEGtime(t),mean(dataSOA4(:,t)),'r.');
    end;
end;





