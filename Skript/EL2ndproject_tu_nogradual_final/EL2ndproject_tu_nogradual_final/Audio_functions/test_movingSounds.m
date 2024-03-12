InitializePsychSound;
% nrchannels = 2;
% freq = 44100;
% suono1 = PsychPortAudio('Open', [], [], 0, freq, nrchannels);
% suono2 = PsychPortAudio('Open', [], [], 0, freq, nrchannels);
% 
% leftRight = MakeBeep(1000,0.6,freq);
% durBeep = length(leftRight)/44100;
% move = linspace(1,0,length(leftRight));
% 
% leftRight = [leftRight.*move; leftRight.*fliplr(move)];
% 
% rightLeft = MakeBeep(1000,0.6,freq);
% durBeep = length(rightLeft)/44100;
% move = linspace(1,0,length(rightLeft));
% 
% rightLeft = [rightLeft.*fliplr(move); rightLeft.*move];
% % this creates 5 seconds long stimuli. subjects generally pressed the keys for 1-2 seconds. If in your experiment they press the key for much longer you should increase this value.
% 
% % % depending on your condition you than have to do:
% % if condition1; Beep = leftRight; else; Beep = highBeep; end
% 
% PsychPortAudio('FillBuffer', suono1, leftRight);
% PsychPortAudio('FillBuffer', suono2, rightLeft);
% 
% 
% % if key is pressed:
% PsychPortAudio('Start', suono1);
% WaitSecs(1);
% 
% PsychPortAudio('Start', suono2);
% WaitSecs(0.5);
% 
% 
% PsychPortAudio('Close');
% % % if key is released:
% % PsychAudio('Stop', suono, 2); % this forces the sound to stop immediately.


%% Producing moving noise in a noisy back ground

nrchannels = 2;
freq = 44100;
suono1 = PsychPortAudio('Open', [], [], 0, freq, nrchannels);
suono2 = PsychPortAudio('Open', [], [], 0, freq, nrchannels);
suono3 = PsychPortAudio('Open', [], [], 0, freq, nrchannels);

backGround = .02*randn(2,length(0:1/44100:5));


leftRight = .2*randn(2,length(0:1/44100:0.2));
durBeep = length(leftRight)/44100;
move = linspace(1,0,length(leftRight));

leftRight = [leftRight(1,:).*move; leftRight(2,:).*fliplr(move)];

rightLeft = .2*randn(2,length(0:1/44100:0.2));
durBeep = length(rightLeft)/44100;
move = linspace(1,0,length(rightLeft));

rightLeft = [rightLeft(1,:).*fliplr(move); rightLeft(2,:).*move];
% this creates 5 seconds long stimuli. subjects generally pressed the keys for 1-2 seconds. If in your experiment they press the key for much longer you should increase this value.

% % depending on your condition you than have to do:
% if condition1; Beep = leftRight; else; Beep = highBeep; end

PsychPortAudio('FillBuffer', suono1, leftRight);
PsychPortAudio('FillBuffer', suono2, rightLeft);
PsychPortAudio('FillBuffer', suono3, backGround);



% if key is pressed:
PsychPortAudio('Start', suono3);
WaitSecs(2);

PsychPortAudio('Start', suono1);
WaitSecs(2);

PsychPortAudio('Start', suono2);
WaitSecs(0.5);


PsychPortAudio('Close');
% % if key is released:
% PsychAudio('Stop', suono, 2); % this forces the sound to stop immediately.



