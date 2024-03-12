function gef_fbCorrResp(display, performance, space) 

fb = 1;
while fb
    DrawFormattedText(display.windowPtr, ['Reponses correctes = ', num2str(performance), ' %', '\n', 'Appuyez sur ESPACE pour continuer'], 'center', 'Center', [], [], [], [], 2.5); %% 2.5 = Approx. 50 pixels
    Screen(display.windowPtr,'Flip');
    [keyIsDown, respOnset, keyCode] = KbCheck;
    if keyIsDown && keyCode(space)
        fb = 0;
    end
end