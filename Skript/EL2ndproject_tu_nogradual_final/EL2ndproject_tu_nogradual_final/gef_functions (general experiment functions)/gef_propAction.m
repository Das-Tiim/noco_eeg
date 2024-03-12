function resp = gef_propAction(display, actions)

nActions = size(actions);
totActions = sum(sum(actions)); 

for i = 1:nActions(1)
    resp.action.(['na' num2str(i)]) = sum(actions(i,:));
    resp.action.(['pa' num2str(i)]) = round(resp.action.(['na' num2str(i)]) / totActions * 100);
    resp.action.(['tpa' num2str(i)]) = num2str(resp.action.(['pa' num2str(i)]));    
end

if i == 2
    txtFeedB = [resp.action.tpa1, ' %', '                        ', resp.action.tpa2, ' %'];
else
    txtFeedB = [resp.action.tpa1, ' %', '               ', resp.action.tpa2, ' %', '               ', resp.action.tpa3, ' %', '               ', resp.action.tpa4, ' %'];
end

DrawFormattedText(display.windowPtr, ...
    ['Percentage of left and right key presses', '\n', ...
    txtFeedB, '\n', ...
    'Try to press equally often with your left and right index finger', '\n',  ...
    'Press SPACE to continue'], ...
    'center', 'center', [], [], [], [], 3.5);

% DrawFormattedText(display.windowPtr, ...
%     ['Frequency of left and right key-presses', '\n', ...
%     txtFeedB, '\n', ...
%     'You should try to keep these numbers relatively equal', '\n',  ...
%     'Please press SPACE to continue'], ...
%     'center', 'center', [], [], [], [], 3.5);

Screen(display.windowPtr,'Flip');
KbWait;
while KbCheck; end

end
