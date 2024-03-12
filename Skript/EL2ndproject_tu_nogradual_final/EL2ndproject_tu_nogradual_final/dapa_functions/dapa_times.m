function tempo = dapa_times(display)
% Hi
if nargin < 1 || isempty(display); display.refreshRate = 1/60; end

tempo.intSeq = 0.3; %  time intervals between sounds in the learning phase
tempo.ITIlrn = 0.6;% Inter Trial Interval in the learning phase
tempo.waitCatchLrn = 0.7;
tempo.base = .5; % fixation only before cue
%tempo.cue = .2; % duration cue presentation
tempo.go = 1.0; % go signal onset: gradual change of the fixation from circle into a square
tempo.rampStep =linspace(0,255,round(tempo.go/display.refreshRate));
% tempo.stimSoa = [-.6 -.4 -.2 .4]; % Soa action-target
%tempo.stimSoa = [-.2 -.1 -.05 0 .05 .1 .2 .4 .6]; % Soa action-target
%tempo.stimSoa = [-.2 -.1 0 .2 .4 .6]; % Soa action-target
%tempo.stimSoa = [-.2 -.1 0 .2 .6]; % Soa action-target
tempo.stimSoa = [0 .05 .2 .6]; % Soa action-target



tempo.tooLate = .5; % maximum waiting time for response after onset of the go signals
tempo.waitAfterKey = .4; % wait time after key is pressed
tempo.blank = 0.2; % duration of blank when presented
tempo.waitQuest = 0.6; % if catch trials wait .6 ms before displaying question
tempo.feedback = 0.3;
tempo.ITI = 0.6; % Inter Trial Interval
tempo.fdbackText = 0.4;
tempo.goFr = secs2frames(display, tempo.go);
tempo.tooLateFr = secs2frames(display, tempo.tooLate);
tempo.scndgocue = 1.5;
tempo.scndsound = 0.4;
tempo.waitforMatchMismatch = 1.5;
tempo.waitaftersound=1.5;
tempo.waitaftersoundFr=secs2frames(display, tempo.waitaftersound);
tempo.waitafterkeyFr=secs2frames(display, tempo.waitAfterKey);

end

