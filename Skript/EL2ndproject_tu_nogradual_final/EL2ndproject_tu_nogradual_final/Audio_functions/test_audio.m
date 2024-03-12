function test_audio()

    fs = 44100;         % sample frequency
    rtimeup = 0.005;    % duration of the ramp up in seconds
    rtimedown = 0.05;   % duration of the ramp down
    dur = 0.2;          % duration of the sounds in seconds
    fsnd = 1000;         % frequency of the sounds
    gap = 0.1;          % duration between sounds
    
    InitializePsychSound;                                   % initialize psychsound
    pahandle = PsychPortAudio('Open', [], [], 0, fs, 1);    % open an handle on 
    
    % Compute ramps
    trup = [0:1/fs:rtimeup-1/fs];                   
    lrup = length(trup);
    rampup = (cos(2*pi*trup/rtimeup/2+pi)+1)/2; 
    trdown = [0:1/fs:rtimedown-1/fs];
    lrdown = length(trdown);
    rampdown = (cos(2*pi*trdown/rtimedown/2)+1)/2;

    % compute sound
    x = sin(2*pi*fsnd*(1:dur*fs)/fs);
    lt = length(x);
    x(1:lrup) = x(1:lrup).*rampup;
    x(lt-lrdown+1:end) = x(lt-lrdown+1:end).*rampdown;
    
    figure(1)
    subplot(121)
    plot(rampup)
    subplot(122)
    plot(rampdown)
    figure(2)
    plot(x)
    figure(3)
    subplot(121)
    plot(x(1:lrup))
    subplot(122)
    plot(x(lt-lrdown+1:end))
    
    PsychPortAudio('FillBuffer', pahandle, x);
    
%     startTime = 0;
stop = 0;
    while ~stop
        PsychPortAudio('Start', pahandle);
        pause(gap)
        disp(sprintf('\npress any key to quit'));
        KbWait([],2)
        stop = 1;
    end
    
    PsychPortAudio('Stop', pahandle);
    disp(sprintf('\n\nend'))
end