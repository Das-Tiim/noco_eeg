InitializePsychSound;
nrchannels = 2;
freq = 44100;
suono1 = PsychPortAudio('Open', [], [], 0, freq, nrchannels);
suono2 = PsychPortAudio('Open', [], [], 0, freq, nrchannels);
suono3 = PsychPortAudio('Open', [], [], 0, freq, nrchannels);

suonos = [suono1, suono2, suono3]

lowBeep = MakeBeep(1000,1);
lowBeep = [lowBeep; lowBeep]
highBeep = MakeBeep(500,1);
superBeep = MakeBeep(750,1);
% this creates 5 seconds long stimuli. subjects generally pressed the keys for 1-2 seconds. If in your experiment they press the key for much longer you should increase this value.

% % depending on your condition you than have to do:
% if condition1; Beep = lowBeep; else; Beep = highBeep; end

PsychPortAudio('FillBuffer', suono1, lowBeep);
% PsychPortAudio('FillBuffer', suono2, highBeep);
% PsychPortAudio('FillBuffer', suono3, superBeep);


% if key is pressed:
PsychPortAudio('Start', suono1);
WaitSecs(0.5);

% PsychPortAudio('Start', suono2);
% WaitSecs(0.5);
% 
% PsychPortAudio('Start', suono3);

PsychPortAudio('Close');
% % if key is released:
% PsychAudio('Stop', suono, 2); % this forces the sound to stop immediately.
