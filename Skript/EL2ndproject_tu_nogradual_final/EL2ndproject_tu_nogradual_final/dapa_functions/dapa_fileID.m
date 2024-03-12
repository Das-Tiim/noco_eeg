function mainvar = dapa_fileID(mainvar)

%folder name for data storage
mainvar.folderName = 'dapa_data';

% experiment name
mainvar.exptname = mainvar.folderName(1:4); % decode saccades

% path to storage data folder
mainvar.folder = fullfile(pwd, mainvar.folderName);

% if not existing create folder for data storage
if ~isdir(mainvar.folder); mkdir(mainvar.folder); end

% imputMode 1 = enter all values, inputMode 0 = take the following default values

mainvar.name = 'Test';
mainvar.age = 31;
mainvar.sNum = '99';
mainvar.hand = 'R';
mainvar.mapping = 2; % handedness

mainvar.inputMode = input('\n >>->> inputMode : ');
if mainvar.inputMode
    
    % name and subject number
    mainvar.name = input('\n >>->> Initials : ', 's');
    mainvar.sNum = input('\n >>->> Subject n : ', 's');
    
    % if only one number add 0 in the front
    if length(mainvar.sNum) < 2
        mainvar.sNum = ['0', mainvar.sNum];
    end
    mainvar.gender = input('\n >>->> Gender : ', 's'); % gender
    mainvar.age = input('\n >>->> Age : ');% age
    mainvar.hand = input('\n >>->> Handedness : ', 's'); % handedness
    mainvar.mapping = input('\n >>->> Mapping (1 or 2) : '); % handedness
end
  
mainvar.fdata = fullfile(mainvar.folder, [mainvar.sNum, mainvar.exptname, '.mat']); % building folder for specific participant number
mainvar.fdata2 = fullfile(mainvar.folder, [mainvar.name, '_', mainvar.sNum, mainvar.exptname, '_', num2str([num2str(mainvar.clock(4)), num2str(mainvar.clock(5))])]); % clock(4)=time.hour; clock(5)=minutes
mainvar.fdataTr = fullfile(mainvar.folder, [mainvar.sNum, mainvar.exptname, 'Train.mat']); % trainfolderfor specific partcipant


mainvar.abort = 0;

% verify whether file exist. if exist open input window on screen and ask
% to continue and overwrite or stop
if exist(mainvar.fdata,'file') %does this specific file exist? 'file': checks for files or folders
    resp = questdlg({['the file ' mainvar.fdata ' already exists']; 'do you want to overwrite it?'}, 'duplicate warning','cancel','ok','ok');
    if ~strcmp(resp,'ok')
        mainvar.abort = 1; %??? what does this do?
        error('')
        error('Experiment Aborted')
        return
    end
end

end
