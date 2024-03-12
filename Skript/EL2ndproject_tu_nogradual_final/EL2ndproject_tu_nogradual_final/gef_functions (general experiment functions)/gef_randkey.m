function randomkey = randkey(listAction)

% listAction = [1 0 1 0 1 0 1 0];

takefromlist1 = 2:2:length(listAction);
takefromlist2 = 1:2:length(listAction);

listActionC1 = listAction(takefromlist1);
listActionC2 = listAction(takefromlist2);

repetcheck = abs(listActionC1-listActionC2);

sommaCheck = sum(repetcheck);
        
randomkey = 1;
if sommaCheck == length(listAction)/2
    randomkey = 0;
end
end