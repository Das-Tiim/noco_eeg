function [dataNoPress, datanosound, dataSOA0, dataSOA0corrected, datadiff, EEGtime,Ns,SDs] = AnalyzeEEG_All(IncAll,channel);

%% Patrameter
pre=200; %samples (->1200ms vor Event)
post=600;%samples (->1200ms nach Event)
y=10; %Y-Achse
tpre=-200; %X-Achse ...
tpost=600;

% 
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
subject{10} = 'lk15ICA';
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


Ns=cell(length(subject),1);
SDs=cell(length(subject),1);
for z=1:length(subject)
    ErrTr = ErrorTrials(subject{z});
	[out1 out2 out3 EEGtime,N,SD]=AnalyzeEEG_XL(subject{z},channel,ErrTr);
	Ns{z,1}=N;
    SDs{z,1}=SD;
	dataNoPress(z,:)=out1(channel,:);
	datanosound(z,:)=out2(channel,:);
	dataSOA0(z,:)=out3(channel,:);
	dataSOA0corrected(z,:)=	dataSOA0(z,:)-datanosound(z,:);
	datadiff(z,:)=dataNoPress(z,:)-dataSOA0corrected(z,:);
    
    saveas(gcf, ['raw_ERP_Cz_' subject{z} '.png'])
end

% 
% figure;
% subplot(2,1,1);
% hold on;
% plot(EEGtime,mean(dataNoPress),'r-');
% plot(EEGtime,mean(dataNoPress)+std(dataNoPress)./sqrt(length(subject)),'r:');
% plot(EEGtime,mean(dataNoPress)-std(dataNoPress)./sqrt(length(subject)),'r:');
% %plot(EEGtime,mean(dataSOA0)-mean(datanosound),'b-');
% plot(EEGtime,mean(dataSOA0corrected),'b-');
% plot(EEGtime,mean(dataSOA0corrected)+std(dataSOA0corrected)./sqrt(length(subject)),'b:');
% plot(EEGtime,mean(dataSOA0corrected)-std(dataSOA0corrected)./sqrt(length(subject)),'b:');
% %plot(EEGtime,mean(dataSOA0),'g:');
% axis([tpre tpost -y y]);
% line([tpre tpost],[0 0],'color','blue');
% line([0 0],[-y y],'color','blue');
% ylabel('mean amplitude [µV]')
% title([num2str(channel) ' | all subjects'])
% legend({'A', '', '', 'corr MA', '', '', '', ''}, 'Location','northeastoutside')
% subplot(2,1,2);
% hold on;
% axis([tpre tpost -y y]);
% line([tpre tpost],[0 0],'color','blue');
% line([0 0],[-y y],'color','blue');
% plot(EEGtime,mean(datadiff),'k-');
% plot(EEGtime,mean(datadiff)+std(datadiff)./sqrt(length(subject)),'k:');
% plot(EEGtime,mean(datadiff)-std(datadiff)./sqrt(length(subject)),'k:');
% xlabel('time relative to tone onset [ms]')
% ylabel('amplitude difference [µV]')
% 
% 
% for t=1:length(EEGtime)
%     %p(t)=signtest(datadiff(:,t))/2;
%     p(t)=signtest(datadiff(:,t))/2;
%     
%     if p(t)<0.05
%         plot(EEGtime(t),mean(datadiff(:,t)),'r.')
%     end
% end





