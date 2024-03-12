function [perf, fa] = gef_performance(display, catchTrials, nonCatchTrials, hit, fa, phase)

if nargin < 3 || isempty(fa); nonCatchTrials = 0; end
if nargin < 4 || isempty(hit); hit = 0; end
if nargin < 5 || isempty(fa); fa = 0; end
if nargin < 6 || isempty(hit); phase = 2; end

%% Calculate and display correct responses (and false alarms)

% trials with signal
catchTrials = catchTrials(:,1);
catchTrials = catchTrials(~isnan(catchTrials));

% trials with noise
nonCatchTrials = nonCatchTrials(:,1);
nonCatchTrials = nonCatchTrials(~isnan(nonCatchTrials));

% proportion of hit
perf = sum(hit)/length(catchTrials)*100;
if phase == 1
    % proportion of fa
    fa = sum(fa)/length(nonCatchTrials)*100;
    DrawFormattedText(display.windowPtr, [' Performance phase 1:' '\n' num2str(perf) ' % correct responses' '\n' num2str(fa) ' % false alarms' '\n', 'Press SPACE to continue'], 'center', 'center', [], [], [], [], 3);
else
    DrawFormattedText(display.windowPtr, [' Performance phase 2:' '\n' num2str(perf),' % correct responses' '\n', 'Press SPACE to continue'], 'center', 'center', [], [], [], [], 3);
end
Screen('Flip', display.windowPtr);
KbWait([],2);
while KbCheck; end


end