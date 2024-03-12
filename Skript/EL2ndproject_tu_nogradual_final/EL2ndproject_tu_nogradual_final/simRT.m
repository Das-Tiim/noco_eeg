function RT = simRT(Nbsubject,NbTrial,nbCondition,meanRT,stdRT)

% Creates an array of Reaction time with a mean "meanRT' 
% and an standard deviation "stdRT' 
% for n° subject "Nbsubject", n° trials "NbTrial",
% n° condition "nbCondition".
% 
% The matrice is [Trial;Subject;condition].

RT = round(1./( meanRT + stdRT * randn(NbTrial,Nbsubject,nbCondition)));


end

    
   