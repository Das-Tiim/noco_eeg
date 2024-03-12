%%
close all;
sca;
clear all;
KbName('UnifyKeyNames');
% %comment section below
% Screen('Preference', 'SkipSyncTests', 1);
% Screen('Preference', 'ConserveVRAM',4096);
%PsychDebugWindowConfiguration()
% AssertOpenGL
%until here

Screen('Preference', 'SkipSyncTests', 0); %change to this for computer to 0
Screen('Preference', 'ConserveVRAM', 4096); %%%% See helpwin Beampositionqueries

%%
InitializePsychSound(1);    % Initialize Sound driver
count = PsychPortAudio('GetOpenDeviceCount');
if (count>0)
    PsychPortAudio('Close');                            % Better to close everything to prevent interaction
end
%PsychDebugWindowConfiguration
PsychPortAudio('Verbosity', 0);



% randomize random
rand('state', sum(100*clock)); %to avoid having always the same random number per session; uniform distribution
mainvar.clock = clock;

% PsychPortAudio('Verbosity', 0);
% devices = PsychPortAudio('GetDevices' ,[] ,[]); %%%% which Audio deviced do we have
% Audi_ID = devices(length(devices)).DeviceIndex;
% Fs= devices(Audi_ID+1).DefaultSampleRate;
% pahandle = PsychPortAudio('Open', Audi_ID, [], 1, Fs);
%% Initial Set Up for EEG


% Initializing the port for EEG
% is the EEG connected? --> Change to 1 if EEG
mainvar.EEG = 1;
p_port_init=mainvar.EEG;
% 25.07.2019 Elisabeth & Felicia entered the triggers
if p_port_init
    %  for installation, read "Install parallel port for sending EEG
    %  triggers.odt"
    ppdev_mex('Open', 2); % find the right port, in terminal: dmesg | grep parport
    %     ioObj = io64;
    %     status_ltp=io64(ioObj);
    %     adress_ltp=hex2dec('E030');
    %     %%%%To find your port address, right click 'my computer'
    %     %%%%, 'properties', 'hardware', 'device manager', 'ports (com & lpt)',
    %     %%%%double click an lpt port, 'resources', 'i/o range'.
    %     %%%%The first value listed is the port's base hex address.
    %     io64(ioObj,adress_ltp,0);
    %     myobj.obj=ioObj;
    %     myobj.adress_ltp=adress_ltp;
    myobj.p_port_init=1;
else
    myobj.p_port_init=0;
end


% %%%%%%%%check if communication to Parallel port is set
% if myobj.p_port_init
%     ioObj=myobj.obj;
%     adress_ltp=myobj.adress_ltp;
% end


%% Initial Set Up


% Initialize Port for EEG
% is the EEG connected? --> Change to 1 if EEG
%mainvar.EEG = 0;

% number of trials per condition
mainvar.trialXcond = 1;

% number of blocks required:change this accordingly
mainvar.nblock = 15; %23 20

% randomize conditions
mainvar.isRandom = 1;

% is this training script? do not change this!
mainvar.training = 0;

%eyetracking or not
mainvar.dummyMod = 1;

% is the EEG connected? --> Change to 1 if EEG
% mainvar.EEG = 0;

%% Participants ID, File and Folder Name

% which computer am I using?
mainvar.whichMachine = 6; % 1 = sthelse; 2 = office; 3 = macbook

% go to program directory
display = dapa_path(mainvar); % change display width and path in the function manually

% create file name and store participants' ID
% mainvar = dapa_fileID(mainvar);


% have we escaped before?
mainvar.escape=0;
mainvar.bb=1;% implemented according to the base condition on 07.02.2020

% create file name and store participants' ID
mainvar = dapa_fileID_new(mainvar);

if mainvar.bb>1
    mainvar.new_participant=0;
    load(mainvar.fdata);
    mainvar.new_participant=0;
    mainvar.escape=mainvar.escape+1;
end


stopLearning = 0;

%% Sound stuff
% duration
stim.soundDur = .1;

% sample rate
stim.sr = 44100;

%high pitch tone
% [hTone] = mkPureTone(stim.sr, 2000, stim.soundDur);
% [hToneL] = tpowerassign(hTone, 81.7); % 73db function??
% [hToneR] = tpowerassign(hTone, 82);
%
% stim.hTone = [hToneL/44100; hToneR/44100];

%volume at computer: MAXIMUM in Tuebingen
%low pitch tone
[lTone] = mkPureTone(stim.sr, 1000, stim.soundDur);
[lToneL] = tpowerassign(lTone, 63.8); % 74dB
[lToneR] = tpowerassign(lTone, 64.3); % 74dB

stim.lTone = [lToneL/44100; lToneR/44100];

%increased intensity - louder+1
[i1Tone] = mkPureTone(stim.sr, 1000, stim.soundDur);
[i1ToneL] = tpowerassign(i1Tone, 64.9); % 75db
[i1ToneR] = tpowerassign(i1Tone, 65.2);   % 75dB

stim.i1Tone = [i1ToneL/44100; i1ToneR/44100];

%decreased intensity - quiter-1
[d1Tone] = mkPureTone(stim.sr, 1000, stim.soundDur);
[d1ToneL] = tpowerassign(d1Tone, 62.8); % 73dB
[d1ToneR] = tpowerassign(d1Tone, 63.2); % 73dB

stim.d1Tone = [d1ToneL/44100; d1ToneR/44100];

%added 05.05.2021
%increased intensity - louder+2
[i2Tone] = mkPureTone(stim.sr, 1000, stim.soundDur);
[i2ToneL] = tpowerassign(i2Tone, 65.9); % 76db
[i2ToneR] = tpowerassign(i2Tone, 66.2); % 76dB

stim.i2Tone = [i2ToneL/44100; i2ToneR/44100];

%decreased intensity - quiter-1
[d2Tone] = mkPureTone(stim.sr, 1000, stim.soundDur);
[d2ToneL] = tpowerassign(d2Tone, 62.8); % 72db
[d2ToneR] = tpowerassign(d2Tone, 63.2); % 72dB

stim.d2Tone = [d2ToneL/44100; d2ToneR/44100];

stim.tones = {stim.lTone, stim.d1Tone, stim.i1Tone, stim.d2Tone, stim.i2Tone};

% %% Create array of soas and sound volume and combine
%
% maxsoa=1.500;
% minsoa=-0.500;
% soas=round(linspace(minsoa,maxsoa,50),3);
% number_trials=130;
% expected_time=mean(soas);
%
%
% exp_PDF=1/expected_time.*exp(-soas./expected_time);
% exp_PDF=exp_PDF./sum(exp_PDF);
%
% trials_experiment=exp_PDF.*number_trials;
% trials_experiment=round(trials_experiment);
%
% % subplot(3,1,1)
% % plot(soas,exp_PDF,".-")
% % subplot(3,1,2)
% % bar(soas,trials_experiment)
% % p = trials_experiment/number_trials;
% % cumP = cumsum(p);
% % S = 1-cumP;
% % h = p./S;
% % subplot(3,1,3)
% % plot(soas, h, 'k')
%
% u=repelem(soas, trials_experiment);
% u=u';
%
% allsoas=[u; u; u; u; u];
% vol=[ones(length(u),1);ones(length(u),1)+1;ones(length(u),1)+2; ones(length(u),1)+3;ones(length(u),1)+4 ];
%
% design.soa=Shuffle(allsoas');
% design.stim=Shuffle(vol');
%
% design.nTrials=length(design.soa);
% design.blockTr=25;
% design.nstim=5;
% design.nsoas=50;
% design.nTrialCon=1;


%% Display Settings

% provide screen size yes or no?  -- Not really sure why we need that...
display.provideSz = 0;

try
    % Open screen window
    %if ~mainvar.abort % this I do not understand
    display.screenNum = max(Screen('Screens'));
    if display.screenNum > 1; display.screenNum = 2; end
    display.bkColor =round([130 130 130]);
    display.fgColor = display.bkColor*2;
    display.rect = [0 0 1920 1080];
    display = OpenWindow(display); % function
    %end
    display.colorText = display.fgColor;
    
    % Enable alpha blending for smooth points and set font size to 20
    Screen('BlendFunction', display.windowPtr,GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA); % Alpha Blending comines color values of pixels alreadz in the window with new color values from drawing commands. "GL_SRC_ALPHA"=source, "GL_ONE_MINUS_SRC_ALPHA"=destination
    Screen('TextSize', display.windowPtr, 20);
    
    % hide cursor only if in eyelink mode
    ListenChar(2); % suppresses keyboard input, put ListenChar(1) at the end of the code
    HideCursor;
    
    
    %% EEG TRIGGERS
    
    %mainvar.eCue = [21 22];                 % cue onset
    mainvar.eOnsetTr = [101];           % Trial onset
    mainvar.eSound = [1 2 3 4];                 % first sound
    mainvar.eAction = [10 20];              % action marker
    mainvar.eAction2 = [11 22];             % action 2 marker
    mainvar.eTrialEnd = 99;                 % Trial end
    mainvar.eCatch = [30 31];               % catch trial
    mainvar.eError = [91 92 93 94];         % error trial
    mainvar.eSound2 = [111 112 113 114];            % scndsound
    
    mainvar.errorMsg = {'ZU FRUEH', 'FALSCHE TASTE', 'ZU SPAET', 'BEWERTUNG AUSSERHALB DER ANGEGEBENEN SKALA'};
    
    % if mainvar.EEG
    %     [object, port, portstatus] = initializePort(255);
    % end
    %% Time Variables
    
    % time settings
    tempo = dapa_times(display); %Change the time settings for design in function
    
    %% keys settings
    keys = dapa_keyAssign; %Change key assignments in function
    
    %% Fixation
    
    % deg in pixel
    stim.deg2pix = angle2pix(display, 1); % how many pixel in 1 deg
    
    % fixation location
    stim.fixSzDeg = 0.7; %?
    stim.fixSzPix = round((stim.fixSzDeg*stim.deg2pix)/2);
    
    % fixation color
    stim.fixColor = display.fgColor*0; %?
    stim.colorRect = display.fgColor;
    
    % location of the fixation in degree and pixel from the center of the
    % screen
    stim.locFix= [0 0];
    stim.locFixPix = angle2pix(display, stim.locFix);
    
    % center rect, fixation size
    stim.centerRect = [display.center(1) display.center(2) display.center(1) display.center(2)]; % center of the screen
    stim.fixRect = [-stim.fixSzPix -stim.fixSzPix +stim.fixSzPix +stim.fixSzPix]; % size fixation
    
    % location left fixation
    stim.xyFixation = stim.centerRect + stim.fixRect + [stim.locFixPix(1) stim.locFixPix(2) stim.locFixPix(1) stim.locFixPix(2)]; % why we use last matrix?
    
    % color feedback
    stim.feedColor = [200 0 0; 0 200 0];
    
    
    %% Factorial design
    
    % create factorial design: randomize conditions and trials
    design = testsoa(mainvar, tempo);
    
    %try
    %% START THE EXPERIMENT
    startExpt=GetSecs;
    
    % block number
    if mainvar.new_participant == 1
        mainvar.bb=1;
        mainvar.nCorrectTrial=0; % Correct Trial
    end
    
    % % block number
    % mainvar.bb=1;
    
    %% LEARNING PHASE
    HideCursor;
    % % begin the experiment with a learning phase of 100 trials
    % RestrictKeysForKbCheck(keys.space);
    % gef_phase(display, 'LEARNING');
    % RestrictKeysForKbCheck(keys.allowed);
    %
    % % display short blank
    % gef_blank(display, 0);
    % WaitSecs(tempo.blank);
    
    %% Test Phase
    
    % Start the first block of the experiment
    
    % Break at the beginning of each block
    RestrictKeysForKbCheck(keys.space);
    gef_phase(display, [ 'Anzahl der durchgefuehrten Versuche : ', num2str(0), ' von ', num2str(design.nTrials)]);
    
    % restrict active keys to those specified in dynp_keyAssign file
    RestrictKeysForKbCheck(keys.allowed);
    
    % display blank
    gef_blank(display,0);
    WaitSecs(tempo.ITI);
    
    % Default time of action for the first trial is 1.5 + .2 seconds ....
    % really? Check
  %  meanRTs = [tempo.go];
    
    % close all buffers
    PsychPortAudio('Close');
    
    gradualend = zeros(1,1000);
    pressintervalend = zeros(1,1000);
    trialend=zeros(1,1000);
    %trialendtobeginningend=zeros(1,1000);
    agency=cell(1,1000);
    %stragency=sprintf('How strongly do you feel that you caused the first tones? \n     Not at all 1 2 3 4 5 6 7 Completely\n\n           ');
    stragency=sprintf('Wie stark haben Sie das Gefuehl, dass Sie den ersten Ton verursacht haben? \n     Ueberhaupt nicht 1 2 3 4 5 6 7 Absolut\n\n           ');
    
    %     tt = 1;
    %     nCorrectTrial = 0;
    
    if mainvar.new_participant == 1
        nCorrectTrial = 0;
        tt=1;
    else
        nCorrectTrial=mainvar.nCorrectTrial;
        tt=mainvar.tt;
    end
    
    pause=0;
    while tt <= design.nTrials
        
        
        
        trialstart=tic;
        tStart = GetSecs;
        
        
        %%% Set sounds: open and fill buffer
        
        %tStart = GetSecs;
        % Open Psych-Audio port, with the follow arguements
        % (1) [] = default sound device
        % (2) 1 = sound playback only
        % (3) 1 = default level of latency
        % (4) Requested frequency in samples per second
        % (5) 2 = stereo putput
        %high = PsychPortAudio('Open', [], [], 0, stim.sr);
        low = PsychPortAudio('Open', [], [], 0, stim.sr);
        
        % changed 06.05.2021
        %catchsound = PsychPortAudio('Open', [], [], 0, stim.sr);
        
        %         if design.catch(tt)~=0
        %             catchsound = PsychPortAudio('Open', [], [], 0, stim.sr);
        %         end
        
        % Fill the audio playback buffer with the audio data, doubled for stereo
        % presentation
        %        PsychPortAudio('FillBuffer', high, stim.hTone);
        PsychPortAudio('FillBuffer', low, stim.lTone);
        
        % changed 06.05.2021
        %  PsychPortAudio('FillBuffer', catchsound, stim.tones{(design.stim(tt))});
        
        %         if design.catch(tt)~=0
        % %             PsychPortAudio('FillBuffer', catchsound, stim.tones{(design.catch(tt)+1)});
        %                    PsychPortAudio('FillBuffer', catchsound, stim.tones{(design.stim(tt)});
        %
        %         end
        
        % Calculate soa for sound based on average action latency,
        % meanRTs is calculated based on RTs from fixation onset
        % e.g., 1.5 + -.200 = 1.3;
%         tempo.effect4act = meanRTs + tempo.stimSoa(design.soa(tt));
%         tempo.effect = tempo.effect4act;
%         
%         % Default mean reaction time is .4
%         if tt==1
%             tempo.effect = tempo.go + 0.2 + tempo.stimSoa(design.soa(tt));
%         end
%         % convert time into frames
%         tempo.effectFr = secs2frames(display, tempo.effect);
%         
        
        %% FIXATION, ACTION, SOUND
        
        % default values (errorType=3, so error "TOO LATE", becomes 0 if
        % keypress)
        errorType = 3; actionPerf = 0; tempo.soundOnsetMachine=NaN; errorType2 = NaN;
        tempo.tmPress = NaN; tempo.RT = NaN; tempo.pressOnset = NaN; tempo.soundOnset = NaN;
        respCatch = NaN; respLatCatch = NaN; correctCatch = NaN; tempo.pressTmFrame = NaN;
        actionPerf2 = NaN; effect2play3 = NaN; tempo.pressOnset2 = NaN; firsteffect2play= NaN;
        errorType3 = NaN; resptest=[];after2key=NaN; tempo.pressOnsettest=NaN;
        firstkeypress=NaN; RT2=NaN; RT1=NaN; tempo.RT1=NaN; tempo.soundOnsetMachine2 = NaN;
        tempo.tmPress2 = NaN; effect2play=NaN;
        FixPhaseStartTimeID = NaN; PressStartTimeID = NaN;SoundStartTimeID = NaN;BreakFixID = NaN;
        SecondPressTimeID = NaN;SecondSoundID = NaN;
        CatchStartTimeID = NaN; TrialEndTimeID = NaN; ErrorStartTimeID = NaN; squareend=NaN;
        respComp=NaN; respLatComp=NaN; correctComp=NaN; sound2=0; sound3=0;
        sound=NaN; keysound=NaN; intervallscndsound=NaN; timepresssound=NaN;timepress=0; soundsec=NaN; actualSOA=NaN; sound1=0; aragency=99;
        Intevalfrst2scnd=NaN;p.triggerDurEEG = 0.004;%standard: 0.001;
        triggerOnsetFixation=NaN;triggerOnsetSound1=NaN;triggerOnsetAction1=NaN;
        triggerOnsetSound2=NaN;triggerOnsetAction2=NaN;triggerOnsetEnd=NaN;
        triggerOnsetError=NaN;nFrame=NaN;
        
        %%    Fixation only: baseline time
        
        Screen('FrameOval', display.windowPtr, [stim.fixColor], stim.xyFixation(1,:));
        %%%%%% TRIGGER FIXATION %%%%%%%
        %if mainvar.EEG; sendEventCode(object, port, mainvar.eOnsetTr);end
        if mainvar.EEG
            %  if myobj.p_port_init
            triggerOnsetFixation = sendParPortTrigger(1,p.triggerDurEEG,mainvar.eOnsetTr);
            
            %                 io64(ioObj,adress_ltp,0); %%%%%reset to 0
            %                 WaitSecs(0.001);
            %                 io64(ioObj,adress_ltp,mainvar.eOnsetTr);
            %  end
        end
        %%%%%%%%%%
        tFix = Screen('Flip', display.windowPtr);
        fixationstart=tic;
      % WaitSecs(tempo.base);
        
        %% Begin gradual change of fixation
        
%         fixationend(tt)=toc(fixationstart);
%         
         nFrame = 1;
%         gradualstart = tic;
         timesstart=tic;
         bfsound=tic;
         time00=GetSecs;
%         
%         while nFrame <= tempo.goFr + tempo.tooLateFr
%             
%             % Present go signal: gradually change fixation in 1.5 sec (+ 200ms)
%             if nFrame <= numel(tempo.rampStep)
%                 Screen('FrameOval', display.windowPtr, [stim.fixColor 255]+[0 0 0 -tempo.rampStep(nFrame)], stim.xyFixation(1,:));
%                 Screen('FrameRect', display.windowPtr, [stim.colorRect 0] + [0 0 0 +tempo.rampStep(nFrame)], stim.xyFixation(1,:));
%                 tGo = nFrame;
%                 gradualend(tt)=toc(gradualstart);
%                 tgo3=tic;
%                 pressinterval=tic;
%                 tgo2=GetSecs;
%                 time00=GetSecs;
%                 %tgo3=tic;
%             else
%                 Screen('FrameRect',display.windowPtr, [stim.colorRect 255], stim.xyFixation(1,:));
%             end
%             tgo=Screen('Flip', display.windowPtr);
%             
%             nFrame = nFrame +1; % use frame to change the saliency of the fixation
%             
%             times=toc(timesstart);
%             %time00=GetSecs;
%             % Play sound at the required time
%             if isnan(tempo.soundOnset) && tempo.stimSoa(design.soa(tt))<0
%                 if nFrame == tempo.effectFr
%                     PsychPortAudio('Start', low);
%                     %%%%%%%%%%%% TRIGGER SOUND %%%%%%%%%%%
%                     if mainvar.EEG; triggerOnsetSound1 = sendParPortTrigger(1,p.triggerDurEEG,mainvar.eSound(1));
%                     end
%                     tempo.soundOnset = nFrame*display.refreshRate;
%                     tempo.soundOnsetMachine = GetSecs;
%                     sound=toc(bfsound);
%                     soundsec=GetSecs;
%                     sound1=1;
%                     
%                 end
%             end
%             %GetSecs=NaN;

             % Check for keypress
            
            wKey = NaN; pressTime = NaN; doubleKey = NaN;

            %  if isnan(wKey)
          while isnan(wKey)
                [keyIsDown, pressTime, keyCode] = KbCheck;
                if keyIsDown
                    if  keyCode(keys.rKey)
                        wKey = find(keyCode(keys.r)); % find key pressed
                        tempo.tmPress = pressTime;
                        %tempo.pressOnset = tempo.tmPress - tFix;
                        %tempo.pressTmFrame = nFrame;
                        errorType=0; % Consider that no mistake is made
                        timepress=GetSecs;
                        fixationend(tt)=toc(fixationstart);
                        % Find what key was pressed
                        wKey1 = keyCode(keys.r);
                        idxK = logical(wKey1);
                        actionPerf = keys.r(idxK);
                        if length(actionPerf) > 1; actionPerf = actionPerf(1); errorType = 2; end
                        
                        %%%%%%%%%%%% TRIGGER ACTION %%%%%%%%%%%
                        % if mainvar.EEG; sendEventCode(object, port, mainvar.eAction(actionPerf)); end
                        if mainvar.EEG; triggerOnsetAction1 = sendParPortTrigger(1,p.triggerDurEEG,mainvar.eAction(wKey1));
                        end
                        
                      %  break % stop loop if a key press is executed
                        
                        % Escape if esc
                    elseif keyCode(keys.escape)
                        mainvar.escape = mainvar.escape +1;
                        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                        %Finish off the eye tracker and send the data over to the stimulus PC, save as .edf in a folder called X:\#Common\Psychoexp\Reward_Saccade_main\Data\edf
                        %%%%%%%%%%%%%%%%%%%%%%%%%%
                        %                                FinishoffEyeTracker
                        sca; ListenChar(1); ShowCursor; return;
                    end
                end
                
%                pressintervalend(tt)=toc(pressinterval);
          end
            timeafterkeystart=tic;
        %end
        
        %% Error Messages
        
        % error message if press too early
       % if tempo.pressTmFrame <= tempo.goFr; errorType=1; end
        
        % Continue with next part of trial if no error, else jumpe to error
        % sequence and start next trial
        if errorType == 0
            %% Sound to play
            % nCorrectTrial = nCorrectTrial + 1;
            % select sound to play according to whether we have a
            % congruent or incongruent trials
            % design.congr(tt)==1 if congruent, ==2 incongruent
            % wKey==1 is right keypress, wKey==2 is left keypress
            
            
            
            
            %             effect2play = effetto(wKey);
            %             effettorand = effetto(end,randperm(size(effetto,2), 1));
            if isnan(tempo.soundOnset) %&& tempo.stimSoa(design.soa(tt))>=0
                if tempo.stimSoa(design.soa(tt))<0
                    WaitSecs(0);
                else
                    WaitSecs(tempo.stimSoa(design.soa(tt))); %Check
                end
                % Start audio playback
                %if isnan(tempo.soundOnset)
                keysound=toc(timeafterkeystart);
                PsychPortAudio('Start', low);
                %%%%%%%%% TRIGGER SOUND %%%%%%%
                % if mainvar.EEG; sendEventCode(object, port, mainvar.eSound(1)); end
                if mainvar.EEG; triggerOnsetSound1 = sendParPortTrigger(1,p.triggerDurEEG, mainvar.eSound(design.soa(tt)));
                end
                
                soundsec=GetSecs;
                timepresssound=GetSecs-timepress;
                %tempo.soundOnset = nFrame*display.refreshRate;
                tempo.soundOnsetMachine = GetSecs;
                sound=toc(bfsound);
                sound1=1;
                
            end
            
            while KbCheck; end
            %                     tempo.soundOnsetMachine = GetSecs;
            aftersound=tic;
            RT1=pressTime-time00;
            actualSOA=soundsec-timepress;
            disp(['RT: ',num2str(fixationend(tt))])
            disp(['AbsTrialNum: ',num2str(tt)]
            %% if not Catch Trial
            
            %     if design.catch(tt)==0
            
            %% Second stimulus
            %added 06.05.2021
            
            PsychPortAudio('FillBuffer', low, stim.tones{(design.stim(tt))});
            
            Intevalfrst2scnd=GetSecs-tempo.soundOnsetMachine;
            
            waitingtime = tic;
            WaitSecs(1.2 + (1.2-0.8).*rand(1,1)-Intevalfrst2scnd);
            intervallscndsound=toc(waitingtime);
            %changed 06.05.2021
            % PsychPortAudio('Start', catchsound)
            PsychPortAudio('Start', low);
            %%%%%%%%% TRIGGER SOUND 2 %%%%%%%
            %     if mainvar.EEG; sendEventCode(object, port, mainvar.eSound2(1)); end
            if mainvar.EEG; triggerOnsetSound2= sendParPortTrigger(1,p.triggerDurEEG, mainvar.eSound2(1));
            end
            RT2start=tic;
            RestrictKeysForKbCheck(keys.v);
            % catchcorrect=design.catch(tt)
            [respComp, respLatComp, correctComp] = dapa_getResp(keys, mainvar, design.stim(tt));
            
            while KbCheck; end
            %%%%%%%%% TRIGGER ACTION 2 %%%%%%%
            %    if mainvar.EEG; sendEventCode(object, port, mainvar.eAction2(respComp)); end
            if mainvar.EEG; triggerOnsetAction2 = sendParPortTrigger(1,p.triggerDurEEG, mainvar.eAction2(respComp));
            end
            RT2=toc(RT2start);
            sound2=1;
            RestrictKeysForKbCheck(keys.allowed);
            nCorrectTrial=nCorrectTrial+1;
            
            %% Catch Trial
            %             else
            %                 waitingtime = tic;
            %                 WaitSecs(0.8 + (1.2-0.8).*rand(1,1));
            %                 intervallscndsound=toc(waitingtime);
            %                 PsychPortAudio('Start', catchsound)
            %                 RT2start=tic;
            %                 RestrictKeysForKbCheck(keys.v)
            %                 % catchcorrect=design.catch(tt)
            %                 [respCatch, respLatCatch, correctCatch] = dapa_getResp(keys, mainvar, design.catch(tt));
            %                 while KbCheck; end
            %                 RT2=toc(RT2start);
            %                 sound3=1;
            %                 RestrictKeysForKbCheck(keys.allowed);
            %             end
            %
            
            
            %%%%%%%%%%%% TRIGGER END TRIAL %%%%%%%%%%%
            %      if mainvar.EEG; sendEventCode(object, port,  mainvar.eTrialEnd); end
            %end
            if mainvar.EEG; triggerOnsetEnd = sendParPortTrigger(1,p.triggerDurEEG,mainvar.eTrialEnd);
            end
            
            
            RestrictKeysForKbCheck(keys.agency);
            DrawFormattedText(display.windowPtr, stragency,'center', 'center', [], [], [], [], 3.5);
            replySize = 20;
            agency{tt} = Ask(display.windowPtr,' ? ',...
                display.colorText,  display.bkColor, 'GetChar',...
                [display.center(1)-replySize, display.center(2)-replySize, display.center(1)+replySize, display.center(2)+replySize], 'center', 20);
            Screen('Flip',display.windowPtr);
            RestrictKeysForKbCheck(keys.allowed);
            aragency=str2num(agency{tt});
            if isempty(aragency)
                aragency=99;
            end
            
            %% if error in agency judgement
            if isempty(agency{tt})
                errorType=4;
            elseif isempty(str2num(agency{tt}))
                errorType=4;
            elseif ~isnumeric(str2num(agency{tt}))
                errorType=4;
            else if 7<str2num(agency{tt}) || str2num(agency{tt})<1
                    errorType=4;
                end
            end
            
            if errorType==4
                
                
                DrawFormattedText(display.windowPtr, mainvar.errorMsg{errorType}, 'center', 'center');
                Screen(display.windowPtr, 'Flip');
                %%%%%%%%%%%% TRIGGER ERROR %%%%%%%%%%%
                %     if mainvar.EEG; sendEventCode(object, port,  mainvar.eError(errorType)); end
                if mainvar.EEG; triggerOnsetError = sendParPortTrigger(1,p.triggerDurEEG,mainvar.eError(errorType));
                end
                design.nTrials=design.nTrials+1;
                design.stim(end+1)=design.stim(tt);
                design.soa(end+1)=design.soa(tt);
                
                WaitSecs(tempo.waitAfterKey+1);
                %%%%%%%%%%%% TRIGGER END TRIAL %%%%%%%%%%%
                %  if mainvar.EEG; sendEventCode(object, port,  mainvar.eTrialEnd); end
                if mainvar.EEG; triggerOnsetEnd = sendParPortTrigger(1,p.triggerDurEEG,mainvar.eTrialEnd);
                end
            end
        else %% if error in others than agency judgement
            
            %                         WaitSecs(tempo.waitAfterKey);
            DrawFormattedText(display.windowPtr, mainvar.errorMsg{errorType}, 'center', 'center');
            Screen(display.windowPtr, 'Flip');
            %%%%%%%%%%%% TRIGGER ERROR %%%%%%%%%%%
            %     if mainvar.EEG; sendEventCode(object, port,  mainvar.eError(errorType)); end
            if mainvar.EEG; triggerOnsetError = sendParPortTrigger(1,p.triggerDurEEG,mainvar.eError(errorType));
            end
            %% add error trial at end of trial list for repetition
            
            design.nTrials=design.nTrials+1;
            design.stim(end+1)=design.stim(tt);
            design.soa(end+1)=design.soa(tt);
            
            %%%%%%%%%%%% TRIGGER ERROR %%%%%%%%%%%
            %   if mainvar.EEG; sendEventCode(object, port,  mainvar.eError(errorType)); end
            if mainvar.EEG; triggerOnsetError = sendParPortTrigger(1,p.triggerDurEEG,mainvar.eError(errorType));
            end
            
            WaitSecs(tempo.waitAfterKey);
            
            %        %%%%%%%%%%%% TRIGGER END TRIAL %%%%%%%%%%%
            %   if mainvar.EEG; sendEventCode(object, port,  mainvar.eTrialEnd); end
            if mainvar.EEG; triggerOnsetEnd = sendParPortTrigger(1,p.triggerDurEEG,mainvar.eTrialEnd);
            end
        end
        trialend(tt)=toc(trialstart);
        tEnd(tt)=GetSecs;
        ttotal=tEnd(tt)-tStart;
        if tt==1
            endtobeginning=0;
        else
            endtobeginning=tStart-tEnd(tt-1);
        end
        %% SAVE DATA
        
        % Internal variables
        mainvar.data.action(tt,:) = actionPerf; % 1 = left 2 = right                            %2
        %mainvar.data.stim(tt,:) = design.stim(tt); % 1 high 2 low frequency                     %3
        %        mainvar.data.congr(tt,:) = design.congr(tt); % 1 congruent 2 incongruent                %4
        mainvar.data.errorType(tt,:) = errorType; % type of error                               %5
        mainvar.data.respComp(tt,:) = respComp; % 1 = left 2 = right
        mainvar.data.respLatComp(tt,:)=respLatComp;
        mainvar.data.correctComp(tt,:)=correctComp;
        mainvar.data.blocknumber(tt,:) = mainvar.bb;
        
        
        
        % Time variables
        %         mainvar.data.tFix(tt,:) = tFix;% time machine fixation onset                            %6
        mainvar.data.tFix(tt,:) = tFix*display.refreshRate;% time machine fixation onset          %7
        mainvar.data.pressTime(tt,:) = tempo.tmPress;% time machine action onset                %8
        mainvar.data.pressTimeFrame(tt,:) = tempo.pressTmFrame*display.refreshRate; % action onset using frame                  %11
        mainvar.data.intervalpresstime(tt,:)=fixationend(tt);
        mainvar.data.soundOnsetbfkeyfr(tt,:) = tempo.soundOnset;
        mainvar.data.soundOnsetaftkey(tt,:)=timepresssound;
        mainvar.data.soundOnset(tt,:) = tempo.soundOnsetMachine;% time machine sound onset      %9
        mainvar.data.SOA(tt,:)=tempo.stimSoa(design.soa(tt));
        mainvar.data.actualSOA(tt,:)=actualSOA;
        mainvar.data.meanRTs(tt,:) = NaN; % averare RTs                                                %12
        
        %mainvar.data.rtFix(tt,:) = tempo.pressOnset;% rt action - fix onset: using time machine                                 %10
        mainvar.data.trialend(tt,:)=trialend(tt);
        mainvar.data.trialtotal(tt,:)=ttotal;
        mainvar.data.trialendtobeginning(tt,:)=endtobeginning;
        mainvar.data.gradualend(tt,:)=gradualend(tt);
        mainvar.data.soundone(tt,:)=sound1;
        mainvar.data.soundtwo(tt,:)=sound2; % yes or no
        %mainvar.data.catchsound(tt,:)=sound3; % yes or no
        mainvar.data.endgo(tt,:)=NaN;
        mainvar.data.soundtime(tt,:)=sound;
        mainvar.data.soundaftkeytime(tt,:)=keysound;
        mainvar.data.RTfrst(tt,:)=RT1;
        mainvar.data.intervallscndsound(tt,:)=intervallscndsound;
        mainvar.data.intevalfrst2scnd(tt,:)=Intevalfrst2scnd;
        mainvar.data.RTscnd(tt,:)=RT2;
        mainvar.data.scndtone(tt,:)=design.stim(tt);
        
        % Other internal variables
        %         mainvar.data.respCatch(tt,:) = respCatch; % response 1 = high 2 = low                   %17
        %         mainvar.data.correctCatch(tt,:) = correctCatch; % is response correct?                  %18
        %         mainvar.data.respLatCatch(tt,:) = respLatCatch; % RTs in sec                            %19
        mainvar.data.frame(tt,:) = nFrame; % stop loop in frame                                 %20
        %         mainvar.data.catchtrials(tt,:) = design.catch(tt); % 1=yes, 0=no
        mainvar.data.agency(tt,:)=aragency;
        mainvar.data.fixation(tt,:)=fixationend(tt);
        
        %% save trigger onsets
        mainvar.data.triggerOnsetFixation(tt,:)=triggerOnsetFixation;
        mainvar.data.triggerOnsetSound1(tt,:)=triggerOnsetSound1;
        mainvar.data.triggerOnsetAction1(tt,:)=triggerOnsetAction1;
        mainvar.data.triggerOnsetSound2(tt,:)=triggerOnsetSound2;
        mainvar.data.triggerOnsetAction2(tt,:)=triggerOnsetAction2;
        mainvar.data.triggerOnsetEnd(tt,:)=triggerOnsetEnd;
        mainvar.data.triggerOnsetError(tt,:)=triggerOnsetError;
 
        %%
        mainvar.tt=tt;
        mainvar.nCorrectTrial=nCorrectTrial;
        
        % Store data in the same variable matrix
        mainvar.nameVar = fieldnames(mainvar.data);
        mainvar.nVar = numel(fieldnames(mainvar.data));
        mainvar.eData = [];
        for ivar = 1:mainvar.nVar
            mainvar.eData(:,ivar) =  mainvar.data.(mainvar.nameVar{ivar});
        end
        
        %         largeStruct = repmat(mainvar.data,2,1);
        %         mainvar.tableData = struct2table(largeStruct);
        mainvar.tableData = struct2table(mainvar.data);
        
        %%%%%% Chech here again!!!!!!!!!!!!!!!!!
        %         if sound2=1
        %             PsychPortAudio('Stop',low);
        %         elseif sound3=1
        %             PsychPortAudio('Stop',catchsound);
        %         end
        
        %% UPDATE MEAN RT
        
%         % Remove errors
%         allData = mainvar.eData;
%         
%         % If the trials are invalid (only errors), this list and the
%         % following will be empty. MeanRTs will contain NaNs
%         noErrors = allData(allData(:,2) == 0,:);
%         
%         % Select rts
%         if isempty(noErrors)
%             meanRTs=1.2;
%         else
%             meanRTs = mean(noErrors(:,9));
%         end
        
        %%  LEARNING PHASE: every design.blockTr trials
        
        
        % Block Feedback
        if mod(tt, design.blockTr) == 0
            mainvar.bb=mainvar.bb+1; % update block number
            mainvar.tt=tt;
            mainvar.nCorrectTrial=nCorrectTrial;
            RestrictKeysForKbCheck(keys.space);
            gef_phase(display, [ 'Anzahl der durchgefuehrten Versuche : ', num2str(tt), ' von ', num2str(design.nTrials), '\n', 'Blocknummer : ', num2str(mainvar.bb)]);
            RestrictKeysForKbCheck(keys.allowed);
            %% Taking a break after half of all blocks, added  06.05.2021
            % if mod(tt, mainvar.nblock/2) == 0
            %             if mod(mainvar.bb, mainvar.tt==design.nTrials/2) == 0
            if pause==0
                %if mainvar.tt>=design.nTrials/2
                if mainvar.bb-1==floor(mainvar.nblock/2)
                    
                    RestrictKeysForKbCheck(keys.space);
                    gef_phase(display, [ 'Die Haelfte ist geschafft!! Super! Zeit fuer eine kleine Pause :)', '\n', 'Druecken Sie nach der Pause die folgende Taste :']);
                    RestrictKeysForKbCheck(keys.allowed);
                    pause=1;
                end
            end
            
        end
        
        
        mainvar.tt=tt;
        mainvar.nCorrectTrial=nCorrectTrial;
        
        
        
        %% Taking a break after half of all blocks, added  06.05.2021
        
        
        
        
        %% ITI
        
        %         % display a blank screen and wait 600 sec ITI + random jitter
        gef_blank(display,0);
        %         Screen('FrameOval', display.windowPtr, [0 255 0], stim.xyFixation(1,:));
               Screen('Flip',display.windowPtr);
                 WaitSecs(tempo.ITI + abs(.04*rand(1,1)+.02));
        
        
        %% Next trial and save data
        
        % next trial
        
        tt = tt + 1;
        mainvar.tt=tt;
        
        
        PsychPortAudio('Close');
        
        % Save data
        save(mainvar.fdata, 'mainvar','display','agency');
        save(mainvar.fdata2, 'mainvar', 'display','agency');
    end
    %% Display Correct and Errors in Command Window
    TextCorrect=['Number of Correct Trials: ' num2str(mainvar.nCorrectTrial)];
    % disp(TextCorrect)
    nError=sum(mainvar.eData(:,2)~=0);
    TextIncorrect=['Number of Incorrect Trials: ' num2str(nError)];
    % disp(TextIncorrect)
    
catch ME
    Screen('CloseAll');
    rethrow(ME)
    
end
%% The end
save(mainvar.fdata, 'mainvar', 'design', 'display', 'stim', 'tempo','agency');
save(mainvar.fdata2, 'mainvar', 'design', 'display', 'stim', 'tempo','agency');

DrawFormattedText(display.windowPtr, ['Super! Sie haben das Experiment geschafft!' '\n', 'Druecken Sie die Leertaste um das Experiment zu beenden'], 'center', 'center', display.fgColor, [], [], [], 3);
Screen('Flip', display.windowPtr);
KbWait;
while KbCheck; end
% close all buffers
PsychPortAudio('Close');


sca;
ListenChar(1);
ShowCursor;
stopExpt = GetSecs;
durExpt = (stopExpt - startExpt)/60;
disp(['The experiment lasted : ',  num2str(durExpt), ' minutes']);
