%% Create sounds
InitializePsychSound(1);

% Sample rate
stim.sr = 44100;
% Duration
stim.soundDur = 1;

%% Play sound 1

% High pitch tone
[hTone] = mkPureTone2(stim.sr, 2000, stim.soundDur);
[hToneL] = tpowerassign(hTone, 82);
[hToneR] = tpowerassign(hTone, 82);
s1 = [hToneL/44100; hToneR/44100];

suono1 = PsychPortAudio('Open', [], [], 0, stim.sr);
PsychPortAudio('FillBuffer', suono1, s1);
PsychPortAudio('Start', suono1);
WaitSecs(stim.soundDur);
PsychPortAudio('Close');
WaitSecs(1)
% High pitch tone
[hTone] = mkPureTone2(stim.sr, 2000, stim.soundDur);
[hToneL] = tpowerassign(hTone, 83);
[hToneR] = tpowerassign(hTone, 83);
s1 = [hToneL/44100; hToneR/44100];

suono1 = PsychPortAudio('Open', [], [], 0, stim.sr);
PsychPortAudio('FillBuffer', suono1, s1);
PsychPortAudio('Start', suono1);
WaitSecs(stim.soundDur);
PsychPortAudio('Close');
%% Play sound 2

% Low pitch tone
[lTone] = mkPureTone(stim.sr, 1000, stim.soundDur);
[lToneL] = tpowerassign(lTone, 87); 
[lToneR] = tpowerassign(lTone, 87.5); 
s2 = [lToneL/44100; lToneR/44100];

suono2 = PsychPortAudio('Open', [], [], 0, stim.sr);
PsychPortAudio('FillBuffer', suono2, s2);
PsychPortAudio('Start', suono2);
WaitSecs(stim.soundDur+1);
PsychPortAudio('Close');

