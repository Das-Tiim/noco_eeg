function display = OpenWindow(display)
%display = OpenWindow([display])
%
%Calls the psychtoolbox command "Screen('OpenWindow') using the 'display'
%structure convention.
%
%Inputs:
%   display             A structure containing display information with fields:
%       screenNum       Screen Number (default is 0)
%       bkColor         Background color (default is gray: [127,127,127])
%       skipChecks      Flag for skpping screen synchronization (default is 0, or don't check)
%                       When set to 1, vbl sync check will be skipped,
%                       along with the text and annoying visual (!) warning
%
%Outputs:
%   display             Same structure, but with additional fields filled in:
%       windowPtr       Pointer to window, as returned by 'Screen'
%       frameRate       Frame rate in Hz, as determined by Screen('GetFlipInterval')
%       refreshRate     Monitor flip interval in sec.
%       resolution      [width,height] of screen in pixels
%       center          [x,y] center of screeen in pixels 
%
%Note: for full functionality, the additional fields of 'display' should be
%filled in:
%
%       dist             distance of viewer from screen (cm)
%       width            width of screen (cm)

% Written 11/13/07 by gmb
% 9/17/09 gmb zre added the 'center' field in ouput of display structure.
%
% Modified by Andrea Desantis 11/03/2013: AD added the output display.refreshRate

if ~exist('display','var')
    display.screenNum = 0;
end

if ~isfield(display,'screenNum')
    display.screenNum = 0;
end

if ~isfield(display,'bkColor')
    display.bkColor = [127,127,127]; 
end

if ~isfield(display,'provideSz')
    display.provideSz = 0; 
end

if ~isfield(display,'skipChecks')
    display.skipChecks = 0;
end

if display.skipChecks
    Screen('Preference', 'Verbosity', 0);
    Screen('Preference', 'SkipSyncTests',1);
    Screen('Preference', 'VisualDebugLevel',0);
    
end

Screen('Preference', 'SuppressAllWarnings', 1);

% Open the window
if display.provideSz
    [display.windowPtr,res]=Screen('OpenWindow',display.screenNum,display.bkColor,[0 0 600 600]);
else
    [display.windowPtr,res]=Screen('OpenWindow',display.screenNum,display.bkColor);
end

% Set the display parameters 'frameRate' and 'resolution'
display.frameRate = 1/Screen('GetFlipInterval',display.windowPtr); %Hz

display.refreshRate = 1/display.frameRate; % sec

if ~isfield(display,'resolution')
    display.resolution = res([3,4]);
end

display.center = floor(display.resolution/2);
