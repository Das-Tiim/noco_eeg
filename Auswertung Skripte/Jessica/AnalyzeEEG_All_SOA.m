function [dataSOA1, dataSOA2, dataSOA3, dataSOA4, EEGtime,Ns,SDs] = AnalyzeEEG_All_SOA(IncAll,channel);

%% Patrameter
pre=200; %samples (->1200ms vor Event)
post=600;%samples (->1200ms nach Event)
y=10; %Y-Achse
tpre=-200; %X-Achse ...
tpost=400;


% subject{1}='JuliusICA';
% subject{2}='EvaICA';
% subject{3}='LenaICA';
% subject{4}='LorenaICA';
% subject{5}='MaxICA';
% subject{6}='HansICA';
% subject{7}='NinaICA';
% subject{8}='RabiaICA';

subject{1} = 'ls02ICA';
subject{2} = 'lw03ICA';
subject{3} = 'jb04ICA';
subject{4} = 'mn05ICA';
subject{5} = 're06ICA';
subject{6} = 'ev07ICA';
subject{7} = 'nr08ICA';
subject{8} = 'sw13ICA';
subject{9} = 'lf14ICA';
subject{10} ='lk15ICA';
subject{11} = 'sp16ICA';
subject{12} = 'hr17ICA';
subject{13} = 'sd19ICA';
subject{14} = 'nro20ICA';
subject{15} = 'lb21ICA';
subject{16} = 'jg22ICA';
subject{17} = 'al23ICA';

if IncAll == 1 % GP
    subject{18} = 'fs25ICA';
    subject{19} = 'am26ICA';
    subject{20} = 'lsc27ICA';
    subject{21} = 'rg28ICA';
end


Ns = cell(length(subject),1);
SDs = cell(length(subject),1);
for z=1:length(subject)
    ErrTr = ErrorTrials(subject{z});
	[out1, out2, out3, out4, EEGtime,N,SD]=AnalyzeEEG_XL_SOA4(subject{z},channel,ErrTr);
	Ns{z}=N;
    SDs{z}=SD;
	dataSOA1(z,:)=out1(channel,:);
	dataSOA2(z,:)=out2(channel,:);
	dataSOA3(z,:)=out3(channel,:);
	dataSOA4(z,:)=out4(channel,:);
end

% figure;
% % subplot(2,1,1);
% hold on;
% plot1 = plot(EEGtime,mean(dataSOA1),'g-');
% plot2 = plot(EEGtime,mean(dataSOA2),'c-');
% plot3 = plot(EEGtime,mean(dataSOA3),'b-');
% plot4 = plot(EEGtime,mean(dataSOA4),'k-');
% %plot(EEGtime,mean(dataNoPress)+std(dataNoPress)./sqrt(length(subject)),'r:');
% axis([tpre tpost -y y]);
% line([tpre tpost],[0 0],'color','blue');
% line([0 0],[-y y],'color','blue');
% title(num2str(channel))
% legend([plot1, plot2, plot3, plot4], {'0ms', '50ms', '200ms', '600ms'});
% ylabel ('mean amplitude (µV)');
% xlabel ('time (ms)');

% subplot(2,1,2);
% hold on;
% axis([tpre tpost -y y]);
% line([tpre tpost],[0 0],'color','blue');
% line([0 0],[-y y],'color','blue');
% plot(EEGtime,mean(datadiff),'k-');
% plot(EEGtime,mean(datadiff)+std(datadiff)./sqrt(length(subject)),'k:');
% plot(EEGtime,mean(datadiff)-std(datadiff)./sqrt(length(subject)),'k:');
% 
% for t=1:length(EEGtime)
%     p2(t)=signtest(dataSOA1(:,t),dataSOA2(:,t))/2;
%     if p2(t)<0.05
%         plot(EEGtime(t),mean(dataSOA2(:,t)),'r.');
%     end
%     p3(t)=signtest(dataSOA2(:,t),dataSOA3(:,t))/2;
%     if p3(t)<0.05
%         plot(EEGtime(t),mean(dataSOA3(:,t)),'r.');
%     end
%     p4(t)=signtest(dataSOA1(:,t),dataSOA4(:,t))/2;
%     if p4(t)<0.05
%         plot(EEGtime(t),mean(dataSOA4(:,t)),'r.');
%     end
% end





