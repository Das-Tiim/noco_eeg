function wave=tpuretone(frequency,duration_s,phase,fs,rmspower,rampduration_ms)

if ~exist('rmspower','var'); rmspower=0.05; end;
if ~exist('rampduration_ms','var'); rampduration_ms=5; end;
if ~exist('phase','var'); phase=0; end;
if ~exist('fs','var'); fs=44100; end;

if phase==-1; phase=rand*2*pi; end; %for random initials phase

wave=rmspower/sqrt(2)*sin(phase+2*pi*(0:(1/fs):duration_s)*frequency);
wave=tramp(wave,fs,rampduration_ms,rampduration_ms);