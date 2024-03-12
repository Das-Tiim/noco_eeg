function [tSnd] = mkPureTone(fs, frq, dur)

if nargin < 1; fs = 44100; end
if nargin < 2; frq = 1000; end
if nargin < 3; dur = 0.1; end


rtimeup = 0.009;    % duration of the ramp up in seconds
rtimedown = 0.009;   % duration of the ramp down in seconds
trup = 0:1/fs:rtimeup-1/fs;
lrup = length(trup);
rampup = (cos(2*pi*trup/rtimeup/2+pi)+1)/2;
trdown = 0:1/fs:rtimedown-1/fs;
lrdown = length(trdown);
rampdown = (cos(2*pi*trdown/rtimedown/2)+1)/2;

% compute target sound
time = 0:1/44100:dur;

sound = sin(2*pi*frq*time);
lt = length(sound);
sound(1:lrup) = sound(1:lrup).*rampup;
sound(lt-lrdown+1:end) = sound(lt-lrdown+1:end).*rampdown;
tSnd = sound;

% wavplay(tSnd, fs);

end