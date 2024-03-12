function fs = AnalyzeEEG_groupedagency(Nsub, agency_EEG, peaks)
% Alternative für bisheriges grouping
% low = alles < 3
% medium = 3-5 (incl.)
% high = alles > 5

% diesmal dann auch separated for SOA --> SOA Effekt auf Agency
clear AgGrp
el_ind = [14,23,32];
eegtime = agency_EEG{19,2};
% sorting für jeden Probanden, getrennt für SOA
% 2. Zeile = mean per condition, for each subject
for el = 1:3
    elec = agency_EEG{el_ind(el),1}(5:end);
    for sb = 1:Nsub
        for ss = 1:4
            soa = ['S' num2str(agency_EEG{ss+8}(5:end-5))];
            lgrp = [];
            mgrp = [];
            hgrp = [];
            for t = 1:length(agency_EEG{ss+8,sb+1})
                if agency_EEG{ss+8,sb+1}(t) < 3
                    lgrp = vertcat(lgrp, agency_EEG{el_ind(el)+ss,sb+1}(t,:));
                elseif agency_EEG{ss+8,sb+1}(t) >= 3 & agency_EEG{ss+8,sb+1}(t) <= 5
                    mgrp = vertcat(mgrp, agency_EEG{el_ind(el)+ss,sb+1}(t,:));
                elseif agency_EEG{ss+8,sb+1}(t) > 5
                    hgrp = vertcat(hgrp, agency_EEG{el_ind(el)+ss,sb+1}(t,:));
                end
            end
            AgGrp.(elec).(soa).low{1,sb} = lgrp;
            AgGrp.(elec).(soa).medium{1,sb} = mgrp;
            AgGrp.(elec).(soa).high{1,sb} = hgrp;

            AgGrp.(elec).(soa).low{2,sb} = mean(lgrp,1);
            AgGrp.(elec).(soa).medium{2,sb} = mean(mgrp,1);
            AgGrp.(elec).(soa).high{2,sb} = mean(hgrp,1);
            
            AgGrp.(elec).(soa).SM{sb} = mean([AgGrp.(elec).(soa).low{2,sb};AgGrp.(elec).(soa).medium{2,sb};AgGrp.(elec).(soa).high{2,sb}],1);
        end
        % all SOAs (all trials, mean)
        % low
        AgGrp.(elec).All.low{1,sb} = vertcat(AgGrp.(elec).S0.low{1,sb},AgGrp.(elec).S50.low{1,sb},...
            AgGrp.(elec).S200.low{1,sb},AgGrp.(elec).S600.low{1,sb});
        AgGrp.(elec).All.low{2,sb} = mean(AgGrp.(elec).All.low{1,sb},1);
        % medium
        AgGrp.(elec).All.medium{1,sb} = vertcat(AgGrp.(elec).S0.medium{1,sb},AgGrp.(elec).S50.medium{1,sb},...
            AgGrp.(elec).S200.medium{1,sb},AgGrp.(elec).S600.medium{1,sb});
        AgGrp.(elec).All.medium{2,sb} = mean(AgGrp.(elec).All.medium{1,sb},1);
        % high
        AgGrp.(elec).All.high{1,sb} = vertcat(AgGrp.(elec).S0.high{1,sb},AgGrp.(elec).S50.high{1,sb},...
            AgGrp.(elec).S200.high{1,sb},AgGrp.(elec).S600.high{1,sb});
        AgGrp.(elec).All.high{2,sb} = mean(AgGrp.(elec).All.high{1,sb},1);
        % SM
        AgGrp.(elec).All.SM{sb} = mean([AgGrp.(elec).All.low{2,sb};AgGrp.(elec).All.medium{2,sb};AgGrp.(elec).All.high{2,sb}],1);
    end
    AgGrp.(elec).S0.GM = mean(vertcat(AgGrp.(elec).S0.SM{1,1:end}),1);
    AgGrp.(elec).S50.GM = mean(vertcat(AgGrp.(elec).S0.SM{1,1:end}),1);
    AgGrp.(elec).S200.GM = mean(vertcat(AgGrp.(elec).S0.SM{1,1:end}),1);
    AgGrp.(elec).S600.GM = mean(vertcat(AgGrp.(elec).S0.SM{1,1:end}),1);
    AgGrp.(elec).All.GM = mean(vertcat(AgGrp.(elec).S0.SM{1,1:end}),1);
   
    for sb = 1:Nsub
        % SM - GM
        AgGrp.(elec).S0.SMGM{sb} = AgGrp.(elec).S0.SM{1,sb}-AgGrp.(elec).S0.GM;
        AgGrp.(elec).S50.SMGM{sb} = AgGrp.(elec).S50.SM{1,sb}-AgGrp.(elec).S50.GM;
        AgGrp.(elec).S200.SMGM{sb} = AgGrp.(elec).S200.SM{1,sb}-AgGrp.(elec).S200.GM;
        AgGrp.(elec).S600.SMGM{sb} = AgGrp.(elec).S600.SM{1,sb}-AgGrp.(elec).S600.GM;
        AgGrp.(elec).All.SMGM{sb} = AgGrp.(elec).All.SM{1,sb}-AgGrp.(elec).All.GM;
        % mean corr
        for ss = 1:4
            soa = ['S' num2str(agency_EEG{ss+8}(5:end-5))];
            if isempty(AgGrp.(elec).(soa).low{2,sb}) == 0
                AgGrp.(elec).(soa).low{3,sb} = AgGrp.(elec).(soa).low{2,sb} - AgGrp.(elec).(soa).SMGM{sb};
                xn.(soa)(sb,1) = min(AgGrp.(elec).(soa).low{2,sb}(peaks{11,6}(1):peaks{11,6}(2)));
                xp.(soa)(sb,1) = max(AgGrp.(elec).(soa).low{2,sb}(peaks{12,6}(1):peaks{12,6}(2)));
            else
                xn.(soa)(sb,1) = nan;
                xp.(soa)(sb,1) = nan;
            end
            if isempty(AgGrp.(elec).(soa).medium{2,sb}) == 0
                AgGrp.(elec).(soa).medium{3,sb} = AgGrp.(elec).(soa).medium{2,sb} - AgGrp.(elec).(soa).SMGM{sb};
                xn.(soa)(sb+Nsub,1) = min(AgGrp.(elec).(soa).medium{2,sb}(peaks{11,6}(1):peaks{11,6}(2)));
                xp.(soa)(sb+Nsub,1) = max(AgGrp.(elec).(soa).medium{2,sb}(peaks{12,6}(1):peaks{12,6}(2)));
            else
                xn.(soa)(sb+Nsub,1) = nan;
                xp.(soa)(sb+Nsub,1) = nan;
            end
            if isempty(AgGrp.(elec).(soa).high{2,sb}) == 0
                AgGrp.(elec).(soa).high{3,sb} = AgGrp.(elec).(soa).high{2,sb} - AgGrp.(elec).(soa).SMGM{sb};
                xn.(soa)(sb+2*Nsub,1) = min(AgGrp.(elec).(soa).high{2,sb}(peaks{11,6}(1):peaks{11,6}(2)));
                xp.(soa)(sb+2*Nsub,1) = max(AgGrp.(elec).(soa).high{2,sb}(peaks{12,6}(1):peaks{12,6}(2)));
            else
                xn.(soa)(sb+2*Nsub,1) = nan;
                xp.(soa)(sb+2*Nsub,1) = nan;
            end 
        end
    end
    for ss = 1:4
        soa = ['S' num2str(agency_EEG{ss+8}(5:end-5))];
        % mean, SE, N per condition
        AgGrp.(elec).(soa).low{5,1} = mean(vertcat(AgGrp.(elec).(soa).low{3,1:end}),1);
        AgGrp.(elec).(soa).low{6,1} = std(vertcat(AgGrp.(elec).(soa).low{3,1:end}),0,1)/sqrt(Nsub);
        AgGrp.(elec).(soa).low{7,1} = size(vertcat(AgGrp.(elec).(soa).low{1,1:end}),1);
   
        AgGrp.(elec).(soa).medium{5,1} = mean(vertcat(AgGrp.(elec).(soa).medium{3,1:end}),1);
        AgGrp.(elec).(soa).medium{6,1} = std(vertcat(AgGrp.(elec).(soa).medium{3,1:end}),0,1)/sqrt(Nsub);
        AgGrp.(elec).(soa).medium{7,1} = size(vertcat(AgGrp.(elec).(soa).medium{1,1:end}),1);
    
        AgGrp.(elec).(soa).high{5,1} = mean(vertcat(AgGrp.(elec).(soa).high{3,1:end}),1);
        AgGrp.(elec).(soa).high{6,1} = std(vertcat(AgGrp.(elec).(soa).high{3,1:end}),0,1)/sqrt(Nsub);
        AgGrp.(elec).(soa).high{7,1} = size(vertcat(AgGrp.(elec).(soa).high{1,1:end}),1);
    end
    
    for sb = 1:Nsub
        AgGrp.(elec).All.low{3,sb} = AgGrp.(elec).All.low{2,sb} - AgGrp.(elec).All.SMGM{sb};
        AgGrp.(elec).All.medium{3,sb} = AgGrp.(elec).All.medium{2,sb} - AgGrp.(elec).All.SMGM{sb};
        AgGrp.(elec).All.high{3,sb} = AgGrp.(elec).All.high{2,sb} - AgGrp.(elec).All.SMGM{sb};
        
        if isempty(AgGrp.(elec).(soa).low{2,sb}) == 0
            xn.all(sb,1) = min(AgGrp.(elec).(soa).low{2,sb}(peaks{11,6}(1):peaks{11,6}(2)));
            xp.all(sb,1) = max(AgGrp.(elec).(soa).low{2,sb}(peaks{12,6}(1):peaks{12,6}(2)));
        else
            xn.all(sb,1) = nan;
            xp.all(sb,1) = nan;
        end
        if isempty(AgGrp.(elec).(soa).medium{2,sb}) == 0
            xn.all(sb+Nsub,1) = min(AgGrp.(elec).(soa).medium{2,sb}(peaks{11,6}(1):peaks{11,6}(2)));
            xp.all(sb+Nsub,1) = max(AgGrp.(elec).(soa).medium{2,sb}(peaks{12,6}(1):peaks{12,6}(2)));
        else
            xn.all(sb+Nsub,1) = nan;
            xp.all(sb+Nsub,1) = nan;
        end
        if isempty(AgGrp.(elec).(soa).high{2,sb}) == 0
            xn.all(sb+2*Nsub,1) = min(AgGrp.(elec).(soa).high{2,sb}(peaks{11,6}(1):peaks{11,6}(2)));
            xp.all(sb+2*Nsub,1) = max(AgGrp.(elec).(soa).high{2,sb}(peaks{12,6}(1):peaks{12,6}(2)));
        else
            xn.all(sb+2*Nsub,1) = nan;
            xp.all(sb+2*Nsub,1) = nan;
        end
    end

    % mean,SE,N All
    AgGrp.(elec).All.low{5,1} = mean(vertcat(AgGrp.(elec).All.low{3,1:end}),1);
    AgGrp.(elec).All.low{6,1} = std(vertcat(AgGrp.(elec).All.low{3,1:end}),0,1)/sqrt(Nsub);
    AgGrp.(elec).All.low{7,1} = size(vertcat(AgGrp.(elec).All.low{1,1:end}),1);
   
    AgGrp.(elec).All.medium{5,1} = mean(vertcat(AgGrp.(elec).All.medium{3,1:end}),1);
    AgGrp.(elec).All.medium{6,1} = std(vertcat(AgGrp.(elec).All.medium{3,1:end}),0,1)/sqrt(Nsub);
    AgGrp.(elec).All.medium{7,1} = size(vertcat(AgGrp.(elec).All.medium{1,1:end}),1);
   
    AgGrp.(elec).All.high{5,1} = mean(vertcat(AgGrp.(elec).All.high{3,1:end}),1);
    AgGrp.(elec).All.high{6,1} = std(vertcat(AgGrp.(elec).All.high{3,1:end}),0,1)/sqrt(Nsub);
    AgGrp.(elec).All.high{7,1} = size(vertcat(AgGrp.(elec).All.high{1,1:end}),1);
   

    % Statistik: Anova, t-tests
    xn.S0(:,2) = [ones(Nsub,1);ones(Nsub,1)*2;ones(Nsub,1)*3];
    xn.S0(:,3) = [1:Nsub,1:Nsub,1:Nsub]';
    disp(['Anova_N0_' num2str(elec)])
    RMAOV1(xn.S0)


    xn.S50(:,2) = [ones(Nsub,1);ones(Nsub,1)*2;ones(Nsub,1)*3];
    xn.S50(:,3) = [1:Nsub,1:Nsub,1:Nsub]';
    disp(['Anova_N50_' num2str(elec)])
    RMAOV1(xn.S50)

    xn.S200(:,2) = [ones(Nsub,1);ones(Nsub,1)*2;ones(Nsub,1)*3];
    xn.S200(:,3) = [1:Nsub,1:Nsub,1:Nsub]';
    disp(['Anova_N200_' num2str(elec)])
    RMAOV1(xn.S200)
    
    xn.S600(:,2) = [ones(Nsub,1);ones(Nsub,1)*2;ones(Nsub,1)*3];
    xn.S600(:,3) = [1:Nsub,1:Nsub,1:Nsub]';
    disp(['Anova_N600_' num2str(elec)])
    RMAOV1(xn.S600)
    
    xn.all(:,2) = [ones(Nsub,1);ones(Nsub,1)*2;ones(Nsub,1)*3];
    xn.all(:,3) = [1:Nsub,1:Nsub,1:Nsub]';
    disp(['Anova_Nall_' num2str(elec)])
    RMAOV1(xn.all)

    xp.S0(:,2) = [ones(Nsub,1);ones(Nsub,1)*2;ones(Nsub,1)*3];
    xp.S0(:,3) = [1:Nsub,1:Nsub,1:Nsub]';
    disp(['Anova_P0_' num2str(elec)])
    RMAOV1(xp.S0)

    xp.S50(:,2) = [ones(Nsub,1);ones(Nsub,1)*2;ones(Nsub,1)*3];
    xp.S50(:,3) = [1:Nsub,1:Nsub,1:Nsub]';
    disp(['Anova_P50_' num2str(elec)])
    RMAOV1(xp.S50)

    xp.S200(:,2) = [ones(Nsub,1);ones(Nsub,1)*2;ones(Nsub,1)*3];
    xp.S200(:,3) = [1:Nsub,1:Nsub,1:Nsub]';
    disp(['Anova_P200_' num2str(elec)])
    RMAOV1(xp.S200)
    
    xp.S600(:,2) = [ones(Nsub,1);ones(Nsub,1)*2;ones(Nsub,1)*3];
    xp.S600(:,3) = [1:Nsub,1:Nsub,1:Nsub]';
    disp(['Anova_P600_' num2str(elec)])
    RMAOV1(xp.S600)
    
    xp.all(:,2) = [ones(Nsub,1);ones(Nsub,1)*2;ones(Nsub,1)*3];
    xp.all(:,3) = [1:Nsub,1:Nsub,1:Nsub]';
    disp(['Anova_Pall_' num2str(elec)])
    RMAOV1(xp.all)
    
    % figure
    %cd('../Figures')
    figure('Position', [150,100, 1200, 600]) % different SOAs
    subplot(2,2,1)
    hold on
    plot([-200,400],[0 0], 'Color', [153/255, 153/255, 153/255]) % Nulllinie x
    plot([0 0],[-15, 15], 'Color', [153/255, 153/255, 153/255]) % Nulllinie y
    
    fill([eegtime, eegtime(end:-1:1)], [AgGrp.(elec).S0.low{5,1}-AgGrp.(elec).S0.low{6,1},flip(AgGrp.(elec).S0.low{5,1}+AgGrp.(elec).S0.low{6,1})],...
        'g', 'FaceAlpha', 0.3, 'EdgeColor', 'none')
    p1 = plot(eegtime, AgGrp.(elec).S0.low{5,1}, 'g');
    fill([eegtime, eegtime(end:-1:1)], [AgGrp.(elec).S0.medium{5,1}-AgGrp.(elec).S0.medium{6,1},flip(AgGrp.(elec).S0.medium{5,1}+AgGrp.(elec).S0.medium{6,1})],...
        'b', 'FaceAlpha', 0.3, 'EdgeColor', 'none')
    p2 = plot(eegtime, AgGrp.(elec).S0.medium{5,1}, 'b');
    fill([eegtime, eegtime(end:-1:1)], [AgGrp.(elec).S0.high{5,1}-AgGrp.(elec).S0.high{6,1},flip(AgGrp.(elec).S0.high{5,1}+AgGrp.(elec).S0.high{6,1})],...
        'r', 'FaceAlpha', 0.3, 'EdgeColor', 'none')
    p3 = plot(eegtime, AgGrp.(elec).S0.high{5,1}, 'r');
    lgd = legend([p1,p2,p3],{['low (N = ' num2str(AgGrp.(elec).S0.low{7,1}) ')'],['medium (N = ' num2str(AgGrp.(elec).S0.medium{7,1}) ')'],['high (N = ' num2str(AgGrp.(elec).S0.high{7,1}) ')']}, 'Location','northwest', 'FontSize',7);
    %title(lgd,'rating')
    
    xlim([-200 400])
    ylim([-15 15])
    xlabel('time relative to tone onset [ms]')
    ylabel('mean amplitude [µV]')
    title([num2str(elec) '| SOA 0'])
    
    subplot(2,2,2)
    hold on
    plot([-200,400],[0 0], 'Color', [153/255, 153/255, 153/255]) % Nulllinie x
    plot([0 0],[-15, 15], 'Color', [153/255, 153/255, 153/255]) % Nulllinie y
    
    fill([eegtime, eegtime(end:-1:1)], [AgGrp.(elec).S50.low{5,1}-AgGrp.(elec).S50.low{6,1},flip(AgGrp.(elec).S50.low{5,1}+AgGrp.(elec).S50.low{6,1})],...
        'g', 'FaceAlpha', 0.3, 'EdgeColor', 'none')
    p1 = plot(eegtime, AgGrp.(elec).S50.low{5,1}, 'g');
    fill([eegtime, eegtime(end:-1:1)], [AgGrp.(elec).S50.medium{5,1}-AgGrp.(elec).S50.medium{6,1},flip(AgGrp.(elec).S50.medium{5,1}+AgGrp.(elec).S50.medium{6,1})],...
        'b', 'FaceAlpha', 0.3, 'EdgeColor', 'none')
    p2 = plot(eegtime, AgGrp.(elec).S50.medium{5,1}, 'b');
    fill([eegtime, eegtime(end:-1:1)], [AgGrp.(elec).S50.high{5,1}-AgGrp.(elec).S50.high{6,1},flip(AgGrp.(elec).S50.high{5,1}+AgGrp.(elec).S50.high{6,1})],...
        'r', 'FaceAlpha', 0.3, 'EdgeColor', 'none')
    p3 = plot(eegtime, AgGrp.(elec).S50.high{5,1}, 'r');
    
    lgd = legend([p1,p2,p3],{['low (N = ' num2str(AgGrp.(elec).S50.low{7,1}) ')'],['medium (N = ' num2str(AgGrp.(elec).S50.medium{7,1}) ')'],['high (N = ' num2str(AgGrp.(elec).S50.high{7,1}) ')']}, 'Location','northwest','FontSize',7);
    %title(lgd,'rating')
    
    xlim([-200 400])
    ylim([-15 15])
    xlabel('time relative to tone onset [ms]')
    ylabel('mean amplitude [µV]')
    title([num2str(elec) '| SOA 50'])

    subplot(2,2,3)
    hold on
    plot([-200,400],[0 0], 'Color', [153/255, 153/255, 153/255]) % Nulllinie x
    plot([0 0],[-15, 15], 'Color', [153/255, 153/255, 153/255]) % Nulllinie y
    
    fill([eegtime, eegtime(end:-1:1)], [AgGrp.(elec).S200.low{5,1}-AgGrp.(elec).S200.low{6,1},flip(AgGrp.(elec).S200.low{5,1}+AgGrp.(elec).S200.low{6,1})],...
        'g', 'FaceAlpha', 0.3, 'EdgeColor', 'none')
    p1 = plot(eegtime, AgGrp.(elec).S200.low{5,1}, 'g');
    fill([eegtime, eegtime(end:-1:1)], [AgGrp.(elec).S200.medium{5,1}-AgGrp.(elec).S200.medium{6,1},flip(AgGrp.(elec).S200.medium{5,1}+AgGrp.(elec).S200.medium{6,1})],...
        'b', 'FaceAlpha', 0.3, 'EdgeColor', 'none')
    p2 = plot(eegtime, AgGrp.(elec).S200.medium{5,1}, 'b');
    fill([eegtime, eegtime(end:-1:1)], [AgGrp.(elec).S200.high{5,1}-AgGrp.(elec).S200.high{6,1},flip(AgGrp.(elec).S200.high{5,1}+AgGrp.(elec).S200.high{6,1})],...
        'r', 'FaceAlpha', 0.3, 'EdgeColor', 'none')
    p3 = plot(eegtime, AgGrp.(elec).S200.high{5,1}, 'r');
    
    lgd = legend([p1,p2,p3],{['low (N = ' num2str(AgGrp.(elec).S200.low{7,1}) ')'],['medium (N = ' num2str(AgGrp.(elec).S200.medium{7,1}) ')'],['high (N = ' num2str(AgGrp.(elec).S200.high{7,1}) ')']}, 'Location','northwest','FontSize',7);
    %title(lgd,'rating')
    
    xlim([-200 400])
    ylim([-15 15])
    xlabel('time relative to tone onset [ms]')
    ylabel('mean amplitude [µV]')
    title([num2str(elec) '| SOA 200'])

    subplot(2,2,4)
    hold on
    plot([-200,400],[0 0], 'Color', [153/255, 153/255, 153/255]) % Nulllinie x
    plot([0 0],[-15, 15], 'Color', [153/255, 153/255, 153/255]) % Nulllinie y
    
    fill([eegtime, eegtime(end:-1:1)], [AgGrp.(elec).S600.low{5,1}-AgGrp.(elec).S600.low{6,1},flip(AgGrp.(elec).S600.low{5,1}+AgGrp.(elec).S600.low{6,1})],...
        'g', 'FaceAlpha', 0.3, 'EdgeColor', 'none')
    p1 = plot(eegtime, AgGrp.(elec).S600.low{5,1}, 'g');
    fill([eegtime, eegtime(end:-1:1)], [AgGrp.(elec).S600.medium{5,1}-AgGrp.(elec).S600.medium{6,1},flip(AgGrp.(elec).S600.medium{5,1}+AgGrp.(elec).S600.medium{6,1})],...
        'b', 'FaceAlpha', 0.3, 'EdgeColor', 'none')
    p2 = plot(eegtime, AgGrp.(elec).S600.medium{5,1}, 'b');
    fill([eegtime, eegtime(end:-1:1)], [AgGrp.(elec).S600.high{5,1}-AgGrp.(elec).S600.high{6,1},flip(AgGrp.(elec).S600.high{5,1}+AgGrp.(elec).S600.high{6,1})],...
        'r', 'FaceAlpha', 0.3, 'EdgeColor', 'none')
    p3 = plot(eegtime, AgGrp.(elec).S600.high{5,1}, 'r');
    
    lgd = legend([p1,p2,p3],{['low (N = ' num2str(AgGrp.(elec).S600.low{7,1}) ')'],['medium (N = ' num2str(AgGrp.(elec).S600.medium{7,1}) ')'],['high (N = ' num2str(AgGrp.(elec).S600.high{7,1}) ')']}, 'Location','northwest','FontSize',7);
    %title(lgd,'rating')
    
    xlim([-200 400])
    ylim([-15 15])
    xlabel('time relative to tone onset [ms]')
    ylabel('mean amplitude [µV]')
    title([num2str(elec) '| SOA 600'])
    
    saveas(gcf, ['ERP_AgencyGrouped_ver2_SOAs_' elec '.png'])

    figure()
    hold on
    plot([-200,400],[0 0], 'Color', [153/255, 153/255, 153/255]) % Nulllinie x
    plot([0 0],[-15, 15], 'Color', [153/255, 153/255, 153/255]) % Nulllinie y
    
    fill([eegtime, eegtime(end:-1:1)], [AgGrp.(elec).All.low{5,1}-AgGrp.(elec).All.low{6,1},flip(AgGrp.(elec).All.low{5,1}+AgGrp.(elec).All.low{6,1})],...
        'g', 'FaceAlpha', 0.3, 'EdgeColor', 'none')
    p1 = plot(eegtime, AgGrp.(elec).All.low{5,1}, 'g');
    fill([eegtime, eegtime(end:-1:1)], [AgGrp.(elec).All.medium{5,1}-AgGrp.(elec).All.medium{6,1},flip(AgGrp.(elec).All.medium{5,1}+AgGrp.(elec).All.medium{6,1})],...
        'b', 'FaceAlpha', 0.3, 'EdgeColor', 'none')
    p2 = plot(eegtime, AgGrp.(elec).All.medium{5,1}, 'b');
    fill([eegtime, eegtime(end:-1:1)], [AgGrp.(elec).All.high{5,1}-AgGrp.(elec).All.high{6,1},flip(AgGrp.(elec).All.high{5,1}+AgGrp.(elec).All.high{6,1})],...
        'r', 'FaceAlpha', 0.3, 'EdgeColor', 'none')
    p3 = plot(eegtime, AgGrp.(elec).All.high{5,1}, 'r');
    
    lgd = legend([p1,p2,p3],{['low (N = ' num2str(AgGrp.(elec).All.low{7,1}) ')'],['medium (N = ' num2str(AgGrp.(elec).All.medium{7,1}) ')'],['high (N = ' num2str(AgGrp.(elec).All.high{7,1}) ')']}, 'Location','northwest','FontSize',7);
    %title(lgd,'rating')
    
    xlim([-200 400])
    ylim([-15 15])
    xlabel('time relative to tone onset [ms]')
    ylabel('mean amplitude [µV]')
    title([num2str(elec) '| all SOAs'])
    
    saveas(gcf, ['ERP_AgencyGrouped_ver2_All_' elec '.png'])
    cd('../EEG')
end



%%
% Alternative 3: für jeden Probanden Daten dritteln

% Daten erstmal nach Agency Rating sortieren und dann dritteln
% für SOAs getrennt und dann auch über SOAs?
ch = {'FCz','Fz','Cz'};
agidx = [14,23,32];
for el = 1:3
    elec = ch{el};
    % SOA 0
    AgEEGsort.(elec) = agency_EEG(1,:);
    [AgEEGsort.(elec){3:9,1}] = deal('SOA 0', 'low', 'middle', 'high','corrlow', 'corrmiddle', 'corrhigh');
    [AgEEGsort.(elec){11:17,1}] = deal('SOA 50', 'low', 'middle', 'high','corrlow', 'corrmiddle', 'corrhigh');
    [AgEEGsort.(elec){19:25,1}] = deal('SOA 200', 'low', 'middle', 'high','corrlow', 'corrmiddle', 'corrhigh');
    [AgEEGsort.(elec){27:33,1}] = deal('SOA 600', 'low', 'middle', 'high','corrlow', 'corrmiddle', 'corrhigh');

    ssidx = [3,11,19,27,35];
    for ss = 1:4 % same analysis for each SOA
        for sb = 1:Nsub
            [sorted, idx] = sort([agency_EEG{ss+8,sb+1}]);
            total = length(sorted);
            boun = 1:(total/3):total+1;
            clear grpidx
            for b = 1:length(boun)-1
                grpidx(b,:) = idx(boun(b):boun(b+1)-1);
            end
    
            [AgEEGsort.(elec){ssidx(ss)+1:ssidx(ss)+3,sb+1}] = deal([agency_EEG{ss+agidx(el),sb+1}(grpidx(1,:),:)],[agency_EEG{ss+agidx(el),sb+1}(grpidx(2,:),:)],[agency_EEG{ss+agidx(el),sb+1}(grpidx(3,:),:)]);
            % mean als letzte Zeile
            AgEEGsort.(elec){ssidx(ss)+1,sb+1}(end+1,:) = mean(AgEEGsort.(elec){ssidx(ss)+1,sb+1},1);
            AgEEGsort.(elec){ssidx(ss)+2,sb+1}(end+1,:) = mean(AgEEGsort.(elec){ssidx(ss)+2,sb+1},1);
            AgEEGsort.(elec){ssidx(ss)+3,sb+1}(end+1,:) = mean(AgEEGsort.(elec){ssidx(ss)+3,sb+1},1);
        end

        % variance correction
        % SM
        for sb = 1:Nsub
            sm(sb,1:801) = mean([AgEEGsort.(elec){ssidx(ss)+1,sb+1}(end,:);AgEEGsort.(elec){ssidx(ss)+2,sb+1}(end,:);AgEEGsort.(elec){ssidx(ss)+3,sb+1}(end,:)],1);
        end
        gm = mean(sm,1);
        for sb = 1:Nsub
            % SM - GM
            smcorr = sm(sb,:) - gm;
            % corrected low, medium high
            AgEEGsort.(elec){ssidx(ss)+4,sb+1} = AgEEGsort.(elec){ssidx(ss)+1,sb+1}(end,:) - smcorr;
            AgEEGsort.(elec){ssidx(ss)+5,sb+1} = AgEEGsort.(elec){ssidx(ss)+2,sb+1}(end,:) - smcorr;
            AgEEGsort.(elec){ssidx(ss)+6,sb+1} = AgEEGsort.(elec){ssidx(ss)+3,sb+1}(end,:) - smcorr;
        end
    
        % mean etc.
        [AgEEGsort.(elec){ssidx(ss),Nsub+2:Nsub+4}] = deal('N', 'Mean', 'SE');
        
        for cat = 1:6 % 3 uncorrected categories, 3 corrected categories
            clear n
            clear mu
            for sb = 1:Nsub
                n(sb) = size(AgEEGsort.(elec){cat+ssidx(ss),sb+1},1)-1; % weil letzte Zeile mean
                mu(sb,:) = AgEEGsort.(elec){cat+ssidx(ss),sb+1}(end,:);
            end
            AgEEGsort.(elec){cat+ssidx(ss),Nsub+2} = sum(n); % # trials
            AgEEGsort.(elec){cat+ssidx(ss),Nsub+3} = mean(mu,1); % mean over subjects
            AgEEGsort.(elec){cat+ssidx(ss),Nsub+4} = std(mu,1)/sqrt(Nsub);
        end

        % repeated measures Anova to test whether difference in peak between categories
        % 1 column: peak, 2. column: condition, 3. column: subjects (erst condition
        % für alle subjects durch, dann nächste condition)
        clear peakn peakp
        for sb = 1:Nsub
            peakn(sb,1) = min(AgEEGsort.(elec){ssidx(ss)+1,sb+1}(end,peaks{11,6}(1):peaks{11,6}(2))); % low rating
            peakn(sb+Nsub,1) = min(AgEEGsort.(elec){ssidx(ss)+2,sb+1}(end,peaks{11,6}(1):peaks{11,6}(2))); % medium rating
            peakn(sb+2*Nsub,1) = min(AgEEGsort.(elec){ssidx(ss)+3,sb+1}(end,peaks{11,6}(1):peaks{11,6}(2))); % high rating
            % category number
            peakn(sb,2) = 1;
            peakn(sb+Nsub,2) = 2;
            peakn(sb+2*Nsub,2) = 3;
            % subject number
            peakn(sb,3) = sb;
            peakn(sb+Nsub,3) = sb;
            peakn(sb+2*Nsub,3) = sb;
        
        
            peakp(sb,1) = max(AgEEGsort.(elec){ssidx(ss)+1,sb+1}(end,peaks{12,6}(1):peaks{12,6}(2))); % low rating
            peakp(sb+Nsub,1) = max(AgEEGsort.(elec){ssidx(ss)+2,sb+1}(end,peaks{12,6}(1):peaks{12,6}(2))); % medium rating
            peakp(sb+2*Nsub,1) = max(AgEEGsort.(elec){ssidx(ss)+3,sb+1}(end,peaks{12,6}(1):peaks{12,6}(2))); % high rating
            
            peakp(sb,2) = 1;
            peakp(sb+Nsub,2) = 2;
            peakp(sb+2*Nsub,2) = 3;
        
            peakp(sb,3) = sb;
            peakp(sb+Nsub,3) = sb;
            peakp(sb+2*Nsub,3) = sb;
        end
        
        disp(['vers 3' elec  'SOA_' num2str(ss) '_N'])
        RMAOV1(peakn)
        disp(['vers 3' elec  'SOA_' num2str(ss) '_P'])
        RMAOV1(peakp)
    end

    % figure
    % uncorrected data
%     col = 'gbr';
%     figure('Position', [150,100, 1200, 600])
%     subplot(2,2,1) % SOA 0
%     hold on
%     plot([-200 400], [0 0], 'Color', [153/255, 153/255, 153/255])
%     plot([0 0], [-15 15], 'Color', [153/255, 153/255, 153/255])
%     for cat = 1:3
%         fill([agency_EEG{19,2},agency_EEG{19,2}(end:-1:1)], [AgEEGsort.(elec){cat+3,Nsub+3}-AgEEGsort.(elec){cat+3,Nsub+4},flip(AgEEGsort.(elec){cat+3,Nsub+3}+AgEEGsort.(elec){cat+3,Nsub+4})], col(cat), 'EdgeColor','none', 'FaceAlpha',0.3)
%         plot(agency_EEG{19,2}, AgEEGsort.(elec){cat+3,Nsub+3},'Color',col(cat))
%     end
%     xlabel('time relative to tone onset [ms]')
%     ylabel('mean amplitude [µV]')
%     title('SOA 0 | N = 347')
%     legend({'','','','low','', 'medium','', 'high'},'Location','northwest')
%     xlim([-200 400])
%     
%     subplot(2,2,2) % SOA 50
%     hold on
%     plot([-200 400], [0 0], 'Color', [153/255, 153/255, 153/255])
%     plot([0 0], [-15 15], 'Color', [153/255, 153/255, 153/255])
%     for cat = 1:3
%         fill([agency_EEG{19,2},agency_EEG{19,2}(end:-1:1)], [AgEEGsort.(elec){cat+11,Nsub+3}-AgEEGsort.(elec){cat+11,Nsub+4},flip(AgEEGsort.(elec){cat+11,Nsub+3}+AgEEGsort.(elec){cat+11,Nsub+4})], col(cat), 'EdgeColor','none', 'FaceAlpha',0.3)
%         plot(agency_EEG{19,2}, AgEEGsort.(elec){cat+11,Nsub+3},'Color',col(cat))
%     end
%     xlabel('time relative to tone onset [ms]')
%     ylabel('mean amplitude [µV]')
%     title('SOA 50 | N = 348')
%     legend({'','','','low','', 'medium','', 'high'},'Location','northwest')
%     xlim([-200 400])
%     
%     subplot(2,2,3) % SOA 200
%     hold on
%     plot([-200 400], [0 0], 'Color', [153/255, 153/255, 153/255])
%     plot([0 0], [-15 15], 'Color', [153/255, 153/255, 153/255])
%     for cat = 1:3
%         fill([agency_EEG{19,2},agency_EEG{19,2}(end:-1:1)], [AgEEGsort.(elec){cat+19,Nsub+3}-AgEEGsort.(elec){cat+19,Nsub+4},flip(AgEEGsort.(elec){cat+19,Nsub+3}+AgEEGsort.(elec){cat+19,Nsub+4})], col(cat), 'EdgeColor','none', 'FaceAlpha',0.3)
%         plot(agency_EEG{19,2}, AgEEGsort.(elec){cat+19,Nsub+3},'Color',col(cat))
%     end
%     xlabel('time relative to tone onset [ms]')
%     ylabel('mean amplitude [µV]')
%     title('SOA 200 | N = 347')
%     legend({'','','','low','', 'medium','', 'high'},'Location','northwest')
%     xlim([-200 400])
%     
%     subplot(2,2,4) % SOA 600
%     hold on
%     plot([-200 400], [0 0], 'Color', [153/255, 153/255, 153/255])
%     plot([0 0], [-15 15], 'Color', [153/255, 153/255, 153/255])
%     for cat = 1:3
%         fill([agency_EEG{19,2},agency_EEG{19,2}(end:-1:1)], [AgEEGsort.(elec){cat+27,Nsub+3}-AgEEGsort.(elec){cat+27,Nsub+4},flip(AgEEGsort.(elec){cat+27,Nsub+3}+AgEEGsort.(elec){cat+27,Nsub+4})], col(cat), 'EdgeColor','none', 'FaceAlpha',0.3)
%         plot(agency_EEG{19,2}, AgEEGsort.(elec){cat+27,Nsub+3},'Color',col(cat))
%     end
%     xlabel('time relative to tone onset [ms]')
%     ylabel('mean amplitude [µV]')
%     title('SOA 600 | N = 348')
%     legend({'','','','low','', 'medium','', 'high'},'Location','northwest')
%     xlim([-200 400])
%     
%     cd('../Figures')
%     saveas(gcf,['ERP_Agencydrittel_uncorrected_' elec '.png'])
%     
    % figure
    % corrected data
    col = 'gbr';
    fs{el,1} = figure('Position', [150,100, 1200, 600]);
    subplot(2,2,1) % SOA 0
    hold on
    plot([-200 400], [0 0], 'Color', [153/255, 153/255, 153/255])
    plot([0 0], [-15 15], 'Color', [153/255, 153/255, 153/255])
    for cat = 1:3
        fill([agency_EEG{19,2},agency_EEG{19,2}(end:-1:1)], [AgEEGsort.(elec){cat+6,Nsub+3}-AgEEGsort.(elec){cat+6,Nsub+4},flip(AgEEGsort.(elec){cat+6,Nsub+3}+AgEEGsort.(elec){cat+6,Nsub+4})], col(cat), 'EdgeColor','none', 'FaceAlpha',0.3)
        plot(agency_EEG{19,2}, AgEEGsort.(elec){cat+6,Nsub+3},'Color',col(cat))
    end
    xlabel('time relative to tone onset [ms]')
    ylabel('mean amplitude [µV]')
    title('SOA 0 | N = 347')
    legend({'','','','low','', 'medium','', 'high'},'Location','northwest')
    xlim([-200 400])
    
    subplot(2,2,2) % SOA 50
    hold on
    plot([-200 400], [0 0], 'Color', [153/255, 153/255, 153/255])
    plot([0 0], [-15 15], 'Color', [153/255, 153/255, 153/255])
    for cat = 1:3
        fill([agency_EEG{19,2},agency_EEG{19,2}(end:-1:1)], [AgEEGsort.(elec){cat+14,Nsub+3}-AgEEGsort.(elec){cat+14,Nsub+4},flip(AgEEGsort.(elec){cat+14,Nsub+3}+AgEEGsort.(elec){cat+14,Nsub+4})], col(cat), 'EdgeColor','none', 'FaceAlpha',0.3)
        plot(agency_EEG{19,2}, AgEEGsort.(elec){cat+14,Nsub+3},'Color',col(cat))
    end
    xlabel('time relative to tone onset [ms]')
    ylabel('mean amplitude [µV]')
    title('SOA 50 | N = 348')
    legend({'','','','low','', 'medium','', 'high'},'Location','northwest')
    xlim([-200 400])
    
    subplot(2,2,3) % SOA 200
    hold on
    plot([-200 400], [0 0], 'Color', [153/255, 153/255, 153/255])
    plot([0 0], [-15 15], 'Color', [153/255, 153/255, 153/255])
    for cat = 1:3
        fill([agency_EEG{19,2},agency_EEG{19,2}(end:-1:1)], [AgEEGsort.(elec){cat+22,Nsub+3}-AgEEGsort.(elec){cat+22,Nsub+4},flip(AgEEGsort.(elec){cat+22,Nsub+3}+AgEEGsort.(elec){cat+22,Nsub+4})], col(cat), 'EdgeColor','none', 'FaceAlpha',0.3)
        plot(agency_EEG{19,2}, AgEEGsort.(elec){cat+22,Nsub+3},'Color',col(cat))
    end
    xlabel('time relative to tone onset [ms]')
    ylabel('mean amplitude [µV]')
    title('SOA 200 | N = 347')
    legend({'','','','low','', 'medium','', 'high'},'Location','northwest')
    xlim([-200 400])
    
    subplot(2,2,4) % SOA 600
    hold on
    plot([-200 400], [0 0], 'Color', [153/255, 153/255, 153/255])
    plot([0 0], [-15 15], 'Color', [153/255, 153/255, 153/255])
    for cat = 1:3
        fill([agency_EEG{19,2},agency_EEG{19,2}(end:-1:1)], [AgEEGsort.(elec){cat+30,Nsub+3}-AgEEGsort.(elec){cat+30,Nsub+4},flip(AgEEGsort.(elec){cat+30,Nsub+3}+AgEEGsort.(elec){cat+30,Nsub+4})], col(cat), 'EdgeColor','none', 'FaceAlpha',0.3)
        plot(agency_EEG{19,2}, AgEEGsort.(elec){cat+30,Nsub+3},'Color',col(cat))
    end
    xlabel('time relative to tone onset [ms]')
    ylabel('mean amplitude [µV]')
    title('SOA 600 | N = 348')
    legend({'','','','low','', 'medium','', 'high'},'Location','northwest')
    xlim([-200 400])
    
%     saveas(gcf,['ERP_Agencydrittel_corrected_' elec '.png'])
%     cd('../EEG')
%     %%%%%%%% --- All SOAs together ------- %%%%
    [AgEEGsort.(elec){35:41,1}] = deal('all SOA', 'low', 'middle', 'high','corrlow', 'corrmiddle', 'corrhigh');
    
    for sb = 1:Nsub
        for c = 1:3
            AgEEGsort.(elec){35+c,sb+1} = [AgEEGsort.(elec){3+c,sb+1}(1:end-1,:);AgEEGsort.(elec){11+c,sb+1}(1:end-1,:);AgEEGsort.(elec){19+c,sb+1}(1:end-1,:);AgEEGsort.(elec){27+c,sb+1}(1:end-1,:)]; % SOAs zusammengefasst
            AgEEGsort.(elec){35+c,sb+1}(end+1,:) = mean(AgEEGsort.(elec){35+c,sb+1},1); % mean
        end
        sm(sb,:) = mean([AgEEGsort.(elec){36,sb+1}(end,:);AgEEGsort.(elec){37,sb+1}(end,:);AgEEGsort.(elec){38,sb+1}(end,:)],1);
        nl(sb) = size(AgEEGsort.(elec){36,sb+1},1)-1;
        nm(sb) = size(AgEEGsort.(elec){37,sb+1},1)-1;
        nh(sb) = size(AgEEGsort.(elec){38,sb+1},1)-1;
    end
    gm = mean(sm,1);
    for sb = 1:Nsub
        smgm(sb,:) = sm(sb,:)-gm;
        AgEEGsort.(elec){39,sb+1} = AgEEGsort.(elec){36,sb+1}(end,:) - smgm(sb);
        AgEEGsort.(elec){40,sb+1} = AgEEGsort.(elec){37,sb+1}(end,:) - smgm(sb);
        AgEEGsort.(elec){41,sb+1} = AgEEGsort.(elec){38,sb+1}(end,:) - smgm(sb);
    end
    % N
    AgEEGsort.(elec){36,Nsub+2} = sum(nl);
    AgEEGsort.(elec){37,Nsub+2} = sum(nm);
    AgEEGsort.(elec){38,Nsub+2} = sum(nh);
    
    % mean, SEM
    for c = 1:6 % 6 "conditions"
        AgEEGsort.(elec){35+c,Nsub+3} = mean([AgEEGsort.(elec){35+c,2}(end,:);AgEEGsort.(elec){35+c,3}(end,:);...
            AgEEGsort.(elec){35+c,4}(end,:);AgEEGsort.(elec){35+c,5}(end,:);AgEEGsort.(elec){35+c,6}(end,:);...
            AgEEGsort.(elec){35+c,7}(end,:);AgEEGsort.(elec){35+c,8}(end,:);AgEEGsort.(elec){35+c,9}(end,:);...
            AgEEGsort.(elec){35+c,10}(end,:);AgEEGsort.(elec){35+c,11}(end,:);AgEEGsort.(elec){35+c,12}(end,:);...
            AgEEGsort.(elec){35+c,13}(end,:);AgEEGsort.(elec){35+c,14}(end,:);AgEEGsort.(elec){35+c,15}(end,:);...
            AgEEGsort.(elec){35+c,16}(end,:);AgEEGsort.(elec){35+c,17}(end,:);AgEEGsort.(elec){35+c,18}(end,:)],1);
    
        AgEEGsort.(elec){35+c,Nsub+4} = std([AgEEGsort.(elec){35+c,2}(end,:);AgEEGsort.(elec){35+c,3}(end,:);...
            AgEEGsort.(elec){35+c,4}(end,:);AgEEGsort.(elec){35+c,5}(end,:);AgEEGsort.(elec){35+c,6}(end,:);...
            AgEEGsort.(elec){35+c,7}(end,:);AgEEGsort.(elec){35+c,8}(end,:);AgEEGsort.(elec){35+c,9}(end,:);...
            AgEEGsort.(elec){35+c,10}(end,:);AgEEGsort.(elec){35+c,11}(end,:);AgEEGsort.(elec){35+c,12}(end,:);...
            AgEEGsort.(elec){35+c,13}(end,:);AgEEGsort.(elec){35+c,14}(end,:);AgEEGsort.(elec){35+c,15}(end,:);...
            AgEEGsort.(elec){35+c,16}(end,:);AgEEGsort.(elec){35+c,17}(end,:);AgEEGsort.(elec){35+c,18}(end,:)],1)/sqrt(Nsub);
    end
    
    % ANOVA
    for sb = 1:Nsub
        N(sb,1) = min(AgEEGsort.(elec){36,sb+1}(end,peaks{11,6}(1):peaks{11,6}(2))); % low rating
        N(sb+Nsub,1) = min(AgEEGsort.(elec){37,sb+1}(end,peaks{11,6}(1):peaks{11,6}(2))); % medium rating
        N(sb+2*Nsub,1) = min(AgEEGsort.(elec){38,sb+1}(end,peaks{11,6}(1):peaks{11,6}(2))); % high rating
        
        P(sb,1) = max(AgEEGsort.(elec){36,sb+1}(end,peaks{12,6}(1):peaks{12,6}(2))); % low rating
        P(sb+Nsub,1) = max(AgEEGsort.(elec){37,sb+1}(end,peaks{12,6}(1):peaks{12,6}(2))); % medium rating
        P(sb+2*Nsub,1) = max(AgEEGsort.(elec){38,sb+1}(end,peaks{12,6}(1):peaks{12,6}(2))); % high rating
    end
    
    N(:,2) = [ones(Nsub,1);ones(Nsub,1)*2;ones(Nsub,1)*3];
    N(:,3) = [1:Nsub,1:Nsub,1:Nsub]';
    P(:,2) = [ones(Nsub,1);ones(Nsub,1)*2;ones(Nsub,1)*3];
    P(:,3) = [1:Nsub,1:Nsub,1:Nsub]';

    disp([elec '_var 3_allSOAs N'])
    RMAOV1(N)

    disp([elec '_var 3_allSOAs P'])
    RMAOV1(P)

    % figure
    col = 'gbr';
    fs{el,2} = figure('Position', [150,100, 1200, 600]);
    hold on
    plot([-200 400], [0 0], 'Color', [153/255, 153/255, 153/255])
    plot([0 0], [-15 15], 'Color', [153/255, 153/255, 153/255])
    for cat = 1:3
        fill([agency_EEG{19,2},agency_EEG{19,2}(end:-1:1)], [AgEEGsort.(elec){cat+38,Nsub+3}-AgEEGsort.(elec){cat+38,Nsub+4},flip(AgEEGsort.(elec){cat+38,Nsub+3}+AgEEGsort.(elec){cat+38,Nsub+4})], col(cat), 'EdgeColor','none', 'FaceAlpha',0.3)
        plot(agency_EEG{19,2}, AgEEGsort.(elec){cat+38,Nsub+3},'Color',col(cat))
    end
    xlim([-200 400])
    ylim([-15 15])
    xlabel('time relative to tone onset [ms]')
    ylabel('mean amplitude [µV]')
    title([elec ' | all SOAs | N = 1690'])
    legend({'','','','low','', 'medium','', 'high'},'Location','northwest')
    %saveas(gcf,['ERP_Agencydrittel_corrected_' elec '.png'])

end

