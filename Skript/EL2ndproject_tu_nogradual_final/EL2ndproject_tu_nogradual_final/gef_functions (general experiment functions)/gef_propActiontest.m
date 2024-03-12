%function to get distribution of right and left key presses per block (first key
%press of sequence) for test phase
function resptest = gef_propActiontest(display, testaction, block)
% resptest = gef_propActiontest(display, testaction)
% then define testaction=mainvar.eData in mainscript and block=mainvar.bb

    resptest.total=sum(testaction(:,9)==block)-sum(testaction(:,1)==0 & testaction(:,9)==block);
    resptest.left=sum(testaction(:,1)==1 & testaction(:,9)==block);
    resptest.right=sum(testaction(:,1)==2 & testaction(:,9)==block);
    
    Percleft = round(resptest.left/resptest.total*100);
    Percright = round(resptest.right/resptest.total*100);
    
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
    