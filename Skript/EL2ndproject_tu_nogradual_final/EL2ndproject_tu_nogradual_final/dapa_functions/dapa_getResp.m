function [response, respLat, correct] = dapa_getResp(keys, mainvar, effettorand)

% response to catch trials: if mapping 1 left key-press = high sound 
% if mapping 2 left key-press = low sound
keyOrder = keys.v;


response = NaN;
while isnan(response)
    [keyIsDown, respLat, keyCode] = KbCheck;
    if keyIsDown
        if keyCode(keys.dKey) || keyCode(keys.iKey)
             response = find(keyCode(keyOrder));       
        end
    end  
end
while KbCheck; end
if numel(response)>1
    response = response(1);
end

%changed 06.05
% correct = 0;
% if response == effettorand
%     correct = 1; 
% end

correct = 0;
if response == 1
    if effettorand==2 | effettorand==4
        correct = 1;
    elseif effettorand==1
        correct=99;
    end
elseif response==2
    if effettorand==3 | effettorand==5
        correct = 1;
    elseif effettorand==1
        correct=99;
    end
end
end