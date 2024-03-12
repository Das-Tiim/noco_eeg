function EL2LE(fn);

% Aufruf: EL2LE(fn);
% fn=filename Psychophysik-Protokollfile vom EEG
% speichert NOCO_*.mat file mit angepassten Variablennamen für
% Probitanalyse (psychometrischer Fit).
% Axel: 18.05.2022 



load(fn);
levellist=[0 -1 1 -2 2]+74;
%levellist=[0 -1 1 -1 2]+74; %Bug Files!
for z=1:size(mainvar.eData,1)
	trial(z).number=z;
	trial(z).valid=1;
	trial(z).decision=mainvar.eData(z,3)-1;
	trial(z).pool=round(mainvar.eData(z,14)*1000);
	trial(z).level=levellist(mainvar.eData(z,30));
end;
save(['NOCO_' fn]);




	
	
	
	
	
	
	