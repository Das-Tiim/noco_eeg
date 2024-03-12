function tgeneratetonefiles(frequencies,duration_s,fs,rmspower,phase,rootfilename)
%frequencies=vector of required frequencies

if ~exist('fs','var'); fs=44100; end;
if ~exist('rootfilename','var'); rootfilename='puretone'; end;
if ~exist('rmspower','var'); rmspower=0.05; end;
if ~exist('phase','var'); phase=0; end;

%hard-wired variables
rampduration_ms=5;
nbits=16;

if length(unique(round(frequencies)))<length(frequencies); error('Some frequencies are going to have the same name: you need to tweak the file-naming scheme'); end;

for ff=1:length(frequencies)
    wave=tpuretone(frequencies(ff),duration_s,phase,fs,rmspower,rampduration_ms);
    wavwrite(wave,fs,nbits,sprintf('%s%.0f.wav',rootfilename,frequencies(ff)))
end;