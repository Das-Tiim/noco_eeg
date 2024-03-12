function display=dapa_path(mainvar)

if mainvar.whichMachine == 1
    cd('/Volumes/Untitled/EL2ndproject_hazard_tu'); % laptop
    display.dist = 50; % 50;                                      % viewing distance (cm)
    display.width = 30; % 30; %%% desktop                        % width of screen (cm)
elseif mainvar.whichMachine == 2
    cd('/Users/elindner/ownCloud/EL2ndproject_tu_nogradual_final'); % Office
    display.dist = 50; % 50;                                      % viewing distance (cm)
    display.width = 35; % 30; %%% desktop                        % width of screen (cm)
elseif mainvar.whichMachine == 3
    cd('/Volumes/Untitled/EL2ndproject_tu_nogradual'); % mac laptop
    display.dist = 50; % 50;                                      % viewing distance (cm)
    display.width = 30; % 30; %%% desktop                        % width of screen (cm)
elseif mainvar.whichMachine == 4 % h421
    cd('C:\Users\arezoo\Documents\MATLAB\Projects\Experimente\dapa'); % setup
    display.dist = 91; % 50;                                      % viewing distance (cm)
    display.width = 52.2; % 30; %%% desktop                        % width of screen (cm)
    
elseif mainvar.whichMachine == 6 % T??bingen
    cd('/home/ngaekp/Schreibtisch/Experimente/Agency/EL2ndproject_tu_nogradual_final'); % setup
    display.dist = 70; % 50;                                      % viewing distance (cm)
    display.width = 48; % 30; %%% desktop                        % width of screen (cm)
end
end


