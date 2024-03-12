function gef_phase(display, text)

DrawFormattedText(display.windowPtr, [text, '\n', ...
                'Druecken Sie die Leertaste'], 'center', 'center', display.colorText, [], [], [], 3);
Screen(display.windowPtr,'Flip');
KbWait([],2);
while KbCheck; end

end

    
