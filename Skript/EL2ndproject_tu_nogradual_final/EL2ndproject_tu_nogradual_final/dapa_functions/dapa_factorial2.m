function design2 = dapa_factorial2(mainvar, tempo)

design.nstim = 2; % number of stimuli
%design.nkey = 2; % number of actions required
%design.nsoas = numel(tempo.stimSoa); % number of SOAs
design.nTrialCon = mainvar.trialXcond; % predefined number of trials per condition

tr=numerrortr;
%tr = design.nTrialCon*design.nsoas*design.nstim*design.nkey; % total number of trials
%tr = design.nTrialCon*design.nstim*design.nkey; % total number of trials
catchTr = [zeros(1, tr-round(.2*tr)) ones(1, round(.2*tr))]; % list of catch trials
catchTr = catchTr(randperm(numel(catchTr)));  % shuffle

nTrials=0
     for itr = 1:ceil(tr/2) % here I put no of errortrials divided by 2 so we maintain 50% conditions
         for iact=1:design.nstim
            nTrials= nTrials+1;
            %stim(nTrials) = istim;
            %soa(nTrials) = isoa;
            %keypress(nTrials) = iact;
            congr(nTrials) = iact;
         end
            if (mainvar.mapping == 1 && istim == 2) || (mainvar.mapping == 2 && istim == 1)
                congr(nTrials) = abs(iact-3);
            end
     end




%design.blockTr = nTrials;

% repeat nblock times the trial list and randomize trials
for iblock = 1:mainvar.nblock
    if mainvar.isRandom
        randCond = randperm(tr);
    else
        randCond = 1:tr;
    end
    %design.soa{iblock} = soa(randCond);
    %design.stim{iblock} = stim(randCond);
    %design.keypress{iblock} = keypress(randCond);
    design.congr{iblock} = congr(randCond);
    design.catch{iblock} = catchTr(randperm(numel(catchTr)));
end

% transform cell blocks in to an array. This way conditions are randomized
% within each block and not across the entire experiment. So in each block
% participants are presented with the same number of congruent and
% incongruent trials, same number of left/right actions etc... 
%design.soa = cell2mat(design.soa);
%design.stim= cell2mat(design.stim);
%design.keypress = cell2mat(design.keypress);
design.congr= cell2mat(design.congr);
design.catch= cell2mat(design.catch);
design.nTrials = numel(design.congr);

end
