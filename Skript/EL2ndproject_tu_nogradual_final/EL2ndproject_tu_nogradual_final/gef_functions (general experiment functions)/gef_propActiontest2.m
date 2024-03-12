% function for relevance without movement
function resptest2 = gef_propActiontest2(display, testaction, block)
% resptest = gef_propActiontest(display, testaction)
% then define testaction=mainvar.eData in mainscript and block=mainvar.bb

    resptest2.total=sum(testaction(:,11)==block)-sum(testaction(:,1)==0 & testaction(:,11)==block);
    resptest2.left=sum(testaction(:,1)==1 & testaction(:,11)==block);
    resptest2.right=sum(testaction(:,1)==2 & testaction(:,11)==block);
    
    Percleft = resptest2.left/resptest2.total*100
    Percright = resptest2.right/resptest2.total*100
    
    txtFeedBack = [num2str(Percleft), ' %', '                        ', num2str(Percright), ' %'];

   DrawFormattedText(display.windowPtr, ...
    ['Percentage of left and right key presses', '\n', ...
    txtFeedBack, '\n', ...
    'Try to initate each sequence equally often with your left and right index finger', '\n',  ...
    'Press SPACE to continue'], ...
    'center', 'center', [], [], [], [], 3.5);


Screen(display.windowPtr,'Flip');
KbWait;
while KbCheck; end

end
    