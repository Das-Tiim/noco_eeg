function [lrn2] = dapa_learn2(display, mainvar, stim, keys, tempo, lrn2)

try
    stopLearning = 0;
    resp=[]; % this will change after the feedback regarding the proportion of left and right key-presses
    
    % number of key-press to perform in the learning phase
    mainvar.trLearn = 100; % if test phase then reproduce 160 sound in the 1st block %chane back to 100
    if mainvar.training == 1
        mainvar.trLearn = 24; % if training phase reproduce only 24 sounds; changed to 21 24.02.2020
    end
    % after the first block independently of training or test, reproduce 24
    % sounds
    if mainvar.bb>1
        mainvar.trLearn = 24; %change to 24; changed to 21 24.02.2020
    end
    
    % select randomly proportion of catch trials
    propCatch = [0 .05 .1 .15];
    
    % catch trial list
    lrn2.catchTrList{mainvar.bb} = zeros(1, mainvar.trLearn);
    randomIdx = randperm(numel(lrn2.catchTrList{mainvar.bb}));
    lrn2.catchTrList{mainvar.bb}(randomIdx(1:round(propCatch(randi(numel(propCatch)))*numel(randomIdx)))) = 1;
    if mainvar.bb == 1 && mainvar.training == 0
        while sum(lrn2.catchTrList{mainvar.bb}(1:10)) >= 1
            lrn2.catchTrList{mainvar.bb} = zeros(1, mainvar.trLearn);
            randomIdx = randperm(numel(lrn2.catchTrList{mainvar.bb}));
            lrn2.catchTrList{mainvar.bb}(randomIdx(1:round(.1*numel(randomIdx)))) = 1;
        end
    elseif  mainvar.bb > 1 || mainvar.training == 1
        while sum(lrn2.catchTrList{mainvar.bb}(1:4)) >= 1
            lrn2.catchTrList{mainvar.bb} = zeros(1, mainvar.trLearn);
            randomIdx = randperm(numel(lrn2.catchTrList{mainvar.bb}));
            lrn2.catchTrList{mainvar.bb}(randomIdx(1:round(propCatch(randi(numel(propCatch)))*numel(randomIdx)))) = 1;
        end
    end
    lrn2.actionList{mainvar.bb} = zeros(2,  mainvar.trLearn);
    
   PsychPortAudio('Close');
    high = PsychPortAudio('Open', [], [], 0, stim.sr);
    low = PsychPortAudio('Open', [], [], 0, stim.sr); % open channel to play high tone
    PsychPortAudio('FillBuffer', high, stim.hTone);
    PsychPortAudio('FillBuffer', low, stim.lTone);
%     bufferhandle(1) = PsychPortAudio('CreateBuffer' ,pahandle, stim.hTone);
%     bufferhandle(2) = PsychPortAudio('CreateBuffer' ,pahandle, stim.lTone);
%     high =1; low =2;
    
    % display short blank
    gef_blank(display, 0);
    WaitSecs(tempo.blank);
    
    tt = 1;
    while tt <= mainvar.trLearn
%         if mainvar.new_participant==0 %this whole bunch uncommented on 06.02.2020
%             % Set sounds: open channel
%             high = PsychPortAudio('Open', [], [], 0, stim.sr);
%             low = PsychPortAudio('Open', [], [], 0, stim.sr); % open channel to play high tone
%             
%             %Fill buffer
%             PsychPortAudio('FillBuffer', high, stim.hTone);
%             PsychPortAudio('FillBuffer', low, stim.lTone);
%         end % until here
        
        % list of sounds
        effetto = [high low];
        effectID = [1 2];
        
        % if mapping 2 reverse the order of sounds: left trigger low and
        % right high
        if mainvar.mapping == 2 
            effetto = fliplr(effetto);
            effectID = fliplr(effectID);
        end
        
        % Fixation
        Screen('FrameOval', display.windowPtr, [stim.fixColor], stim.xyFixation(1,:));
        Screen('Flip',display.windowPtr);
        
        if tt==1 || exist('startITI','var')==0
            ITIend=0;
        else
            ITIend=toc(startITI);
        end
        
        %% WAIT FOR ACTION TO DISPLAY STIMULUS
        
        wKey = NaN; pressTime = NaN; doubleKey = NaN;
        while isnan(wKey)
            [keyIsDown, secs, keyCode] = KbCheck;
            if keyIsDown
                if (keyCode(keys.lKey) || keyCode(keys.rKey))
                    wKey = find(keyCode(keys.r)); % find key pressed
                    pressTime = secs;
                    doubleKey = 0;
                    if numel(wKey) > 1
                        wKey = wKey(1);
                        doubleKey = 1;
                        break
                    end

                    % update list of action executed
                    lrn2.actionList{mainvar.bb}(wKey, tt) = 1;
                    
                    % select sound to play
                    effect2play = effetto(wKey);
                    if lrn2.catchTrList{mainvar.bb}(tt) == 1
                        effect2play = effetto(abs(wKey-3));
                    end

                    % paly sound
                    PsychPortAudio('Start', effect2play);
%                     PsychPortAudio('Start', pahandle);

                    % if escape then stop the programme
                elseif keyCode(keys.escape)
                    stopLearning = 1;
                    break;
                end
            end
        end
        % wait until all keys are released
        while KbCheck; end
        
        %% Diplay blank screen after action
        
        gef_blank(display, 0);
        %PsychPortAudio('Close');
        PsychPortAudio('Stop', effect2play);

        % if escape skip this learning phase
        if stopLearning
            break
        end
        
        %% error for double key-press
        
        if doubleKey
            DrawFormattedText(display.windowPtr, 'Error: double press', 'center', 'center');
            Screen('Flip',display.windowPtr);
            WaitSecs(tempo.feedback);

            % if double press add one trial and update list of catch trials
            % and actions executed
            mainvar.trLearn = mainvar.trLearn+1;
            lrn2.catchTrList{mainvar.bb}(end+1) = lrn2.catchTrList{mainvar.bb}(tt);
            lrn2.actionList{mainvar.bb}(:, end+1) = [0;0];
        end
        
        %         %% Response to catch trial
        
        %         miss = 0; hit = 0; fa = 0; catchKey = NaN; catchTime = NaN;
        %         if ~doubleKey %&& lrn.catchTrList{mainvar.bb}(tt) == 1
        %             while GetSecs - pressTime <= tempo.waitCatchLrn
        %                 catchKey = NaN;
        %                 if isnan(catchKey)
        %                     [keyIsDown, secs, keyCode] = KbCheck;
        %                     if keyIsDown
        %                         if (keyCode(keys.lKey) || keyCode(keys.rKey))
        %                             catchKey = sum(find(keyCode(keys.r))); % find key pressed
        %                             catchTime = secs;
        %                             break
        %                         end
        %                     end
        %                 end
        %             end
        %
        %             % catch trial output
        %             text2disp = '';
        %             if lrn.catchTrList{mainvar.bb}(tt) == 1 && ~isnan(catchKey) % if catch trial and key-press it's a HIT
        %                 hit = 1;
        %                 text2disp = 'Hit!';
        %
        %             elseif lrn.catchTrList{mainvar.bb}(tt) == 1 && isnan(catchKey) % if catch trial and no key-press it's a MISS
        %                 miss = 1;
        %                 text2disp = 'Miss!';
        %
        %             elseif lrn.catchTrList{mainvar.bb}(tt) == 0 && ~isnan(catchKey) % If no catch trial but key press it's a FALSE ALARM
        %                 fa = 1;
        %                 text2disp = 'False Alarm!';
        %             end
        %
        %             % display text
        %             DrawFormattedText(display.windowPtr, text2disp, 'center', 'center');
        %             Screen('Flip',display.windowPtr);
        %             WaitSecs(tempo.fdbackText);
        %         end
        
        %% Feedback proportion of key-presses
        
        % provide feedback every 12 actions
        fbActions = 12; 
        if mainvar.bb == 1 && mainvar.training == 0
            fbActions = 12*2;
        end

        if mod(tt, fbActions) == 0
            resp = gef_propAction(display, lrn2.actionList{mainvar.bb});
        end
        
        %% Save data
        
        lrn2.pressTime{mainvar.bb}(1, tt) = pressTime; % store onsetime key press
        lrn2.wKey{mainvar.bb}(1, tt) = wKey; % store key pressed
        lrn2.doubleKey{mainvar.bb}(1, tt) = doubleKey;
        lrn2.sound{mainvar.bb}(1, tt) = effectID(wKey);
        lrn2.catchTr{mainvar.bb}(1, tt) = lrn2.catchTrList{mainvar.bb}(tt);
        %         lrn.respCatch{mainvar.bb}(1, tt) = catchKey; % proportion of correct responses
        %         lrn.whenCatch{mainvar.bb}(1, tt) = catchTime; % proportion of correct responses
        %         lrn.hit{mainvar.bb}(1, tt) = hit; % proportion of correct responses
        %         lrn.miss{mainvar.bb}(1, tt) = miss; % proportion of correct responses
        %         lrn.fa{mainvar.bb}(1, tt) = fa; % proportion of correct responses
        lrn2.timingITI{mainvar.bb}(1, tt)=ITIend;

        % record data if not training session
%         Fel and Elli changed to below 21.10.2019
%         if ~mainvar.training
%             save(mainvar.fdataTr, 'lrn2', 'resp');
%         end
        startITI=tic;         
        tt=tt+1; % next trial!
        WaitSecs(tempo.blank);

    end
%     added from Fel and Elli 21.10.2019
    if ~mainvar.training
        save(mainvar.fdataTr, 'lrn2', 'resp');
    end
    %     gef_phase(display, ['APPRENTISSAGE',  '\n', 'Vous avez attrap? : ', num2str(sum(lrn.hit{mainvar.bb})), ' sur ' num2str(sum(lrn.catchTr{mainvar.bb})), ' sons intrus', '\n', 'Vous avez eu : ', num2str(sum(lrn.fa{mainvar.bb})), ' fausses alarmes'])
    
    replySize = 20;
    RestrictKeysForKbCheck([]);
    lrn2.ansCatch{mainvar.bb} = Ask(display.windowPtr, ' ? ', display.colorText,  display.bkColor, 'GetChar', [display.center(1)-replySize, display.center(2)-replySize, display.center(1)+replySize, display.center(2)+replySize], 'center', 20); 
    Screen('Flip',display.windowPtr);
    
    iscorrect = str2double(lrn2.ansCatch{mainvar.bb}) == sum(lrn2.catchTr{mainvar.bb});
    text4catch = {'Oops! Incorrect', 'Yes! Correct'};
    gef_phase(display, [text4catch{iscorrect+1}, ' : '  num2str(sum(lrn2.catchTr{mainvar.bb}))]);
       
    % display short blank
    gef_blank(display, 0);
    WaitSecs(tempo.blank);
    
    % record data if not training session
    if ~mainvar.training
        save(mainvar.fdataTr, 'lrn2', 'resp');
    end
PsychPortAudio('Close');
catch ME
    Screen('CloseAll');
    rethrow(ME)
end
