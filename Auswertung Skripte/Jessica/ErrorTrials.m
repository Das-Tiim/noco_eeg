function ErrTr = ErrorTrials(fe)
% fe = filename für EEG

% for sub = 2:13
%     ag = length([psycho{2,sub}.trial.level]);
%     
%     eeg = 0;
%     for a = 1:length(EEG_data{4,sub}.EEG.event)
%         if strcmp(EEG_data{4,sub}.EEG.event(a).type, 'S101')
%             eeg = eeg+1;
%         end
%     end
% 
%     if ag ~= eeg
%         disp(sub)
%     end
% end

% No Press (A)
load([fe 'NoPress']);

tr_start = []; % index of start trigger
for e = 1:length(EEG.event)
    if strcmp(EEG.event(e).type, 'S101')
        tr_start = horzcat(tr_start, e);
    end
end

e_nr = []; % number of trial with error trigger
e_idx = []; % 1.column: index of start trigger, 2.column: index of end trigger
for ee = 1:length(tr_start)-1
    if any(strcmp({EEG.event(tr_start(ee):tr_start(ee+1)).type}, 'S 91'))
        e_nr = horzcat(e_nr, ee);
        e_idx = vertcat(e_idx, [tr_start(ee), tr_start(ee+1)-1]);
    elseif any(strcmp({EEG.event(tr_start(ee):tr_start(ee+1)).type}, 'S 92'))
        e_nr = horzcat(e_nr, ee);
        e_idx = vertcat(e_idx, [tr_start(ee), tr_start(ee+1)-1]);
    elseif any(strcmp({EEG.event(tr_start(ee):tr_start(ee+1)).type}, 'S 93'))
        e_nr = horzcat(e_nr, ee);
        e_idx = vertcat(e_idx, [tr_start(ee), tr_start(ee+1)-1]);
    elseif any(strcmp({EEG.event(tr_start(ee):tr_start(ee+1)).type}, 'S 94'))
        e_nr = horzcat(e_nr, ee);
        e_idx = vertcat(e_idx, [tr_start(ee), tr_start(ee+1)-1]);
    end
end
% letztes trial
if strcmp({EEG.event(tr_start(end):end).type}, 'S 91')
    e_nr = horzcat(e_nr, ee+1);
    e_idx = vertcat(e_idx, [tr_start(end), length(EEG.event)]);
elseif strcmp({EEG.event(tr_start(end):end).type}, 'S 92')
    e_nr = horzcat(e_nr, ee+1);
    e_idx = vertcat(e_idx, [tr_start(end), length(EEG.event)]);
elseif strcmp({EEG.event(tr_start(end):end).type}, 'S 93')
    e_nr = horzcat(e_nr, ee+1);
    e_idx = vertcat(e_idx, [tr_start(end), length(EEG.event)]);
elseif strcmp({EEG.event(tr_start(end):end).type}, 'S 94')
    e_nr = horzcat(e_nr, ee+1);
    e_idx = vertcat(e_idx, [tr_start(end), length(EEG.event)]);
end

[ErrTr{1,2:4}] = deal('A', 'M', 'MA');
[ErrTr{2:3,1}] = deal('Trial Number', 'Start/end index');
[ErrTr{2:3,2}] = deal(e_nr,e_idx);

clear EEG



% No Sound (M)
load([fe 'NoSound']);

tr_start = []; % index of start trigger
for e = 1:length(EEG.event)
    if strcmp(EEG.event(e).type, 'S101')
        tr_start = horzcat(tr_start, e);
    end
end

e_nr = []; % number of trial with error trigger
e_idx = []; % 1.column: index of start trigger, 2.column: index of end trigger
for ee = 1:length(tr_start)-1
    if any(strcmp({EEG.event(tr_start(ee):tr_start(ee+1)).type}, 'S 91'))
        e_nr = horzcat(e_nr, ee);
        e_idx = vertcat(e_idx, [tr_start(ee), tr_start(ee+1)-1]);
    elseif any(strcmp({EEG.event(tr_start(ee):tr_start(ee+1)).type}, 'S 92'))
        e_nr = horzcat(e_nr, ee);
        e_idx = vertcat(e_idx, [tr_start(ee), tr_start(ee+1)-1]);
    elseif any(strcmp({EEG.event(tr_start(ee):tr_start(ee+1)).type}, 'S 93'))
        e_nr = horzcat(e_nr, ee);
        e_idx = vertcat(e_idx, [tr_start(ee), tr_start(ee+1)-1]);
    elseif any(strcmp({EEG.event(tr_start(ee):tr_start(ee+1)).type}, 'S 94'))
        e_nr = horzcat(e_nr, ee);
        e_idx = vertcat(e_idx, [tr_start(ee), tr_start(ee+1)-1]);
    end
end
% letztes trial
if strcmp({EEG.event(tr_start(end):end).type}, 'S 91')
    e_nr = horzcat(e_nr, ee+1);
    e_idx = vertcat(e_idx, [tr_start(end), length(EEG.event)]);
elseif strcmp({EEG.event(tr_start(end):end).type}, 'S 92')
    e_nr = horzcat(e_nr, ee+1);
    e_idx = vertcat(e_idx, [tr_start(end), length(EEG.event)]);
elseif strcmp({EEG.event(tr_start(end):end).type}, 'S 93')
    e_nr = horzcat(e_nr, ee+1);
    e_idx = vertcat(e_idx, [tr_start(end), length(EEG.event)]);
elseif strcmp({EEG.event(tr_start(end):end).type}, 'S 94')
    e_nr = horzcat(e_nr, ee+1);
    e_idx = vertcat(e_idx, [tr_start(end), length(EEG.event)]);
end

[ErrTr{2:3,3}] = deal(e_nr,e_idx);

clear EEG


% Sound (MA)
load([fe 'Sound']);

tr_start = []; % index of start trigger
for e = 1:length(EEG.event)
    if strcmp(EEG.event(e).type, 'S101')
        tr_start = horzcat(tr_start, e);
    end
end

e_nr = []; % number of trial with error trigger
e_idx = []; % 1.column: index of start trigger, 2.column: index of end trigger
for ee = 1:length(tr_start)-1
    if any(strcmp({EEG.event(tr_start(ee):tr_start(ee+1)).type}, 'S 91'))
        e_nr = horzcat(e_nr, ee);
        e_idx = vertcat(e_idx, [tr_start(ee), tr_start(ee+1)-1]);
    elseif any(strcmp({EEG.event(tr_start(ee):tr_start(ee+1)).type}, 'S 92'))
        e_nr = horzcat(e_nr, ee);
        e_idx = vertcat(e_idx, [tr_start(ee), tr_start(ee+1)-1]);
    elseif any(strcmp({EEG.event(tr_start(ee):tr_start(ee+1)).type}, 'S 93'))
        e_nr = horzcat(e_nr, ee);
        e_idx = vertcat(e_idx, [tr_start(ee), tr_start(ee+1)-1]);
    elseif any(strcmp({EEG.event(tr_start(ee):tr_start(ee+1)).type}, 'S 94'))
        e_nr = horzcat(e_nr, ee);
        e_idx = vertcat(e_idx, [tr_start(ee), tr_start(ee+1)-1]);
    end
end
% letztes trial
if strcmp({EEG.event(tr_start(end):end).type}, 'S 91')
    e_nr = horzcat(e_nr, ee+1);
    e_idx = vertcat(e_idx, [tr_start(end), length(EEG.event)]);
elseif strcmp({EEG.event(tr_start(end):end).type}, 'S 92')
    e_nr = horzcat(e_nr, ee+1);
    e_idx = vertcat(e_idx, [tr_start(end), length(EEG.event)]);
elseif strcmp({EEG.event(tr_start(end):end).type}, 'S 93')
    e_nr = horzcat(e_nr, ee+1);
    e_idx = vertcat(e_idx, [tr_start(end), length(EEG.event)]);
elseif strcmp({EEG.event(tr_start(end):end).type}, 'S 94')
    e_nr = horzcat(e_nr, ee+1);
    e_idx = vertcat(e_idx, [tr_start(end), length(EEG.event)]);
end

% bei re06 bei sound condition Keyboard Probleme und früher abgebrochen,
% allerdings bei EEG Daten 1 Trial mehr als bei Psychophysik (vermutlich
% kein Rating registriert) --> deswegen letzte EEG Trial rausschmeißen
if strcmp(fe, 're06ICA')
    e_nr = horzcat(e_nr, ee+1);
    e_idx = vertcat(e_idx, [tr_start(end), length(EEG.event)]);
end

[ErrTr{2:3,4}] = deal(e_nr,e_idx);


% remove error trials
% EEG data:
% - event list
% - times
% % - data
% for t = length(e_nr):-1:1
%     tst = round(EEG.event(e_idx(t,1)).latency); % start time point
%     ten = round(EEG.event(e_idx(t,2)).latency);
% 
%     EEG.times(tst:ten) = [];
%     EEG.data(:,tst:ten) = [];
% 
%     EEG.event([e_idx(t,1):e_idx(t,2)]) = [];
% end
% 
% save(['NC2_' fe])




% load(fp);
% ps_trial = find([trial.valid] == 0);
% % 
% % if any(e_nr ~= ps_trial)
% %     disp(fe)
% % end
% 
% % Psycho data
% % - design: stim, soa
% % - agency
% % - trial
% % - Mainvar (data, eData, tableData)
% 
% for t = length(ps_trial):-1:1    
%     agency(ps_trial(t)) = [];
%     trial(ps_trial(t)) = [];
%     mainvar.data.action(ps_trial(t)) = [];
%     mainvar.data.errorType(ps_trial(t)) = [];
%     mainvar.data.respComp(ps_trial(t)) = [];
%     mainvar.data.respLatComp(ps_trial(t)) = [];
%     mainvar.data.correctComp(ps_trial(t)) = [];
%     mainvar.data.blocknumber(ps_trial(t)) = [];
%     mainvar.data.tFix(ps_trial(t)) = [];
%     mainvar.data.pressTime(ps_trial(t)) = [];
%     mainvar.data.pressTimeFrame(ps_trial(t)) = [];
%     mainvar.data.intervalpresstime(ps_trial(t)) = [];
%     mainvar.data.soundOnsetbfkeyfr(ps_trial(t)) = [];
%     mainvar.data.soundOnsetaftkey(ps_trial(t)) = [];
%     mainvar.data.soundOnset(ps_trial(t)) = [];
%     mainvar.data.SOA(ps_trial(t)) = [];
%     mainvar.data.actualSOA(ps_trial(t)) = [];
%     mainvar.data.meanRTs(ps_trial(t)) = [];
%     mainvar.data.trialend(ps_trial(t)) = [];
%     mainvar.data.trialtotal(ps_trial(t)) = [];
%     mainvar.data.trialendtobeginning(ps_trial(t)) = [];
%     mainvar.data.gradualend(ps_trial(t)) = [];
%     mainvar.data.soundone(ps_trial(t)) = [];
%     mainvar.data.soundtwo(ps_trial(t)) = [];
%     mainvar.data.endgo(ps_trial(t)) = [];
%     mainvar.data.soundtime(ps_trial(t)) = [];
%     mainvar.data.soundaftkeytime(ps_trial(t)) = [];
%     mainvar.data.RTfrst(ps_trial(t)) = [];
%     mainvar.data.intervallscndsound(ps_trial(t)) = [];
%     mainvar.data.intevalfrst2scnd(ps_trial(t)) = [];
%     mainvar.data.RTscnd(ps_trial(t)) = [];
%     mainvar.data.scndtone(ps_trial(t)) = [];
%     mainvar.data.frame(ps_trial(t)) = [];
%     mainvar.data.agency(ps_trial(t)) = [];
%     mainvar.data.fixation(ps_trial(t)) = [];
%     mainvar.data.triggerOnsetFixation(ps_trial(t)) = [];
%     mainvar.data.triggerOnsetSound1(ps_trial(t)) = [];
%     mainvar.data.triggerOnsetAction1(ps_trial(t)) = [];
%     mainvar.data.triggerOnsetSound2(ps_trial(t)) = [];
%     mainvar.data.triggerOnsetAction2(ps_trial(t)) = [];
%     mainvar.data.triggerOnsetEnd(ps_trial(t)) = [];
%     mainvar.data.triggerOnsetError(ps_trial(t)) = [];
%     mainvar.eData(ps_trial(t),:) = [];
%     mainvar.tableData(ps_trial(t),:) = [];
% end
% 
% save(['NC2_' fp],'agency','design','display','stim','tempo','fn','levellist','z','trial','mainvar');

end

