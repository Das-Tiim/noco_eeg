kDown = 0;
while ~kDown
    
    [kDown, secs, kCode] = KbCheck;
    if kDown
        Beeper
    end
end