function design = testsoa(mainvar, tempo)

design.nstim = 5; % number of stimuli
design.nsoas = numel(tempo.stimSoa); % number of SOAs
design.nTrialCon = mainvar.trialXcond; % predefined number of trials per condition

tr = design.nTrialCon*design.nsoas; % total number of trials
%catchTr = [zeros(1, tr-round(.2*tr)) ones(1, round(.1*tr)) ones(1, round(.1*tr))+1]; % list of catch trials
%catchTr = catchTr(randperm(numel(catchTr))); 

nTrials = 0;
for istim = 1:design.nstim % stim
    %for iact = 1:design.nkey % keys
        for isoa = 1:design.nsoas % soa
            for itr = 1:design.nTrialCon % trials per condition
                nTrials = nTrials+1;
                stim(nTrials) = istim;
                soa(nTrials) = isoa;
                %keypress(nTrials) = iact;
                %congr(nTrials) = iact;      
%                 if (mainvar.mapping == 1) || (mainvar.mapping == 2)
%                     congr(nTrials) = abs(iact-3);
                %end
            end
        end
    %end
end


design.blockTr = nTrials;

% repeat nblock times the trial list and randomize trials
for iblock = 1:mainvar.nblock
    if mainvar.isRandom
        randCond = randperm(nTrials);
    else
        randCond = 1:nTrials;
    end
    design.soa{iblock} = soa(randCond);
    design.stim{iblock} = stim(randCond);
    %design.keypress{iblock} = keypress(randCond);
    %design.congr{iblock} = congr(randCond);
    %design.catch{iblock} = catchTr(randperm(numel(catchTr)));
end

% transform cell blocks in to an array. This way conditions are randomized
% within each block and not across the entire experiment. So in each block
% participants are presented with the same number of congruent and
% incongruent trials, same number of left/right actions etc... 
design.soa = cell2mat(design.soa);
design.stim= cell2mat(design.stim);
%design.keypress = cell2mat(design.keypress);
%design.congr= cell2mat(design.congr);
%design.catch= cell2mat(design.catch);
design.nTrials = numel(design.soa);
end