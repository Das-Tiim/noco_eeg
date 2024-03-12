% Perform basic initialization of the sound driver:
InitializePsychSound(1);

[tSnd] = mkPureTone(44100, 400, 0.1);
tSnd = tpowerassign(tSnd, 70); % 69 dB

tSnd = [tSnd/44100;tSnd/44100];

dots.noisedur = 0:1/44100:60;
dots.noisex=randn(length(dots.noisedur),1);
dots.noisefx=fft(dots.noisex); % frequency domain .
dots.noiseN=length(dots.noisefx);
dots.noisep=0.4/2; % desired bandwidth  percentage, /2 because fft is TWO sided !!!
dots.noiseP=round(dots.noisep*dots.noiseN);
dots.noisefx(dots.noiseP+1:end)=0;
dots.noise2play=ifft(dots.noisefx);
dots.noise2play = tpowerassign(real(dots.noise2play), 60); % 69 dB
dots.noise2play = [dots.noise2play/44100, dots.noise2play/44100]';

pahandle(1) = PsychPortAudio('Open', [], [], 0);
PsychPortAudio('FillBuffer', pahandle(1), dots.noise2play);

for bb = 2:61
    pahandle(bb) = PsychPortAudio('Open', [], [], 0);
%     buffer(bb) = PsychPortAudio('FillBuffer', pahandle, tSnd);
    PsychPortAudio('FillBuffer', pahandle(bb), tSnd);

end

PsychPortAudio('Start', pahandle(1));
for cc = 2:61
    PsychPortAudio('Start', pahandle(cc));
%     PsychPortAudio('Start', buffer(cc));

    WaitSecs(0.3);
end

PsychPortAudio('Close');