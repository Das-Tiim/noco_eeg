function gef_instruction(display, instruct) 

instruct = Screen('MakeTexture', display.windowPtr, instruct);
Screen('DrawTexture', display.windowPtr, instruct, [], [0 0 display.resolution(1) display.resolution(2)]);
Screen(display.windowPtr,'Flip');
KbWait([], 2);
while KbCheck; end
Screen('Close', instruct);

end
