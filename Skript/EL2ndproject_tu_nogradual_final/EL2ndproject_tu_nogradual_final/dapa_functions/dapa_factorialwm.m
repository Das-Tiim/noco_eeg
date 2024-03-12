function design = dapa_factorial(mainvar, tempo)

design.nstim = 2; % number of stimuli
design.nstim2=2; % congruent incongruent sound to mismatch match sign 
design.nkey = 2; % number of actions required
%design.nsoas = numel(tempo.stimSoa); % number of SOAs
design.nTrialCon = mainvar.trialXcond; % predefined number of trials per condition
design.nmmatch = 2;

%tr = design.nTrialCon*design.nsoas*design.nstim*design.nkey; % total number of trials
tr = design.nTrialCon*design.nstim*design.nkey; % total number of trials
catchTr = [zeros(1, tr-round(.2*tr)) ones(1, round(.2*tr))]; % list of catch trials
catchTr = catchTr(randperm(numel(catchTr)));  % shuffle

nTrials = 0;
for istim = 1:design.nstim % stim
    for istim2=1:design.nstim2
    for iact = 1:design.nkey % keys
       % for isoa = 1:design.nsoas % soa
       for immatch = 1:design.nmmatch
            for itr = 1:design.nTrialCon % trials per condition
                nTrials = nTrials+1;
                stim(nTrials) = istim;
                mmatch(nTrials) = immatch;
                %keypress(nTrials) = iact;
                congr(nTrials) = iact;
                if (mainvar.mapping == 1 && istim == 2) || (mainvar.mapping == 2 && istim == 1)
                    congr(nTrials) = abs(iact-3);
                end
            end
       end
    end
    end
end


design.blockTr = nTrials;
design.takebreak = 4; %every 20 blocks the participant takes a break (no movement condition)

% repeat nblock times the trial list and randomize trials
for iblock = 1:mainvar.nblock
    if mainvar.isRandom
        randCond = randperm(nTrials);
    else
        randCond = 1:nTrials;
    end
    %design.soa{iblock} = soa(randCond);
    design.stim{iblock} = stim(randCond);
    %design.keypress{iblock} = keypress(randCond);
    design.congr{iblock} = congr(randCond);
    design.catch{iblock} = catchTr(randperm(numel(catchTr)));
    design.mmatch{iblock} = mmatch(randCond)
end

% transform cell blocks in to an array. This way conditions are randomized
% within each block and not across the entire experiment. So in each block
% participants are presented with the same number of congruent and
% incongruent trials, same number of left/right actions etc... 
%design.soa = cell2mat(design.soa);
design.stim= cell2mat(design.stim);
%design.keypress = cell2mat(design.keypress);
design.congr= cell2mat(design.congr);
design.catch= cell2mat(design.catch);
design.nTrials = numel(design.congr);
design.mmatch = cell2mat(design.mmatch);
end
