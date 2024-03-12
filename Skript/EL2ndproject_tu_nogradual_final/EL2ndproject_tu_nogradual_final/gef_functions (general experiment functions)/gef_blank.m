function tblank = gef_blank(display, when)
%
% display blank screen (set to background color)
% 
% Input: display.windowPtr 
%        display.bkColor
%
% Output: onset time blank as in getsecs
%
% 2016 by Andrea Desantis

Screen('FillRect', display.windowPtr, display.bkColor);
tblank = Screen('Flip', display.windowPtr, when);

end