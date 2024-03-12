function keys = dapa_keyAssign

keys.space = KbName('SPACE');
keys.escape = KbName('ESCAPE');
keys.iKey = KbName('E');
keys.dKey = KbName('Q');
keys.rKey = KbName('P');
keys.enter = KbName('return');
% keys.high = KbName('T');
% keys.low = KbName('B');
keys.r= [keys.rKey];
keys.s=[keys.space];
%keys.rr=[keys.lKey, keys.rKey, keys.space];
%keys.actions = [1,2];
%keys.actions2 = [1,2,3];
keys.v=[keys.dKey, keys.iKey]
keys.allowed=[keys.r, keys.v, keys.space, keys.escape]; 

keys.one = KbName('1');
keys.two = KbName('2');
keys.three = KbName('3');
keys.four = KbName('4');
keys.five = KbName('5');
keys.six = KbName('6');
keys.seven = KbName('7');
keys.agency = [keys.one, keys.two, keys.three,...
    keys.four, keys.five, keys.six, keys.seven];

end

