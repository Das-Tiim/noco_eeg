function [y,xf,cf] = stepgram(x,fs,compress,lowfreq,numchan,toPlot)
% [y,xf,cf] = ERBgram(x,fs,dbthres,lowfreq,numchan,toPlot)
% fs: sampling frequency
% dbthres: threshold 
% Default fs = 44100; dbthres = 60, lowfreq = 100, numchan = 64

if nargin < 6
  toPlot = 1;
end

%compress = 0.5;

if nargin < 5
  numchan = 64;
end

if nargin < 4
  lowfreq = 100;
end

if nargin < 3
  compress = 1;
end

if nargin < 2
  fs = 44100;
end

%added TA 28iii2010
if numchan*length(x)>15000000 %likely to cause memory problems
    %disp('Resampling')
    reductionfactor=2; %e.g., 2 => half the sample-rate
    x=resample(x,1,reductionfactor);
    fs=fs/reductionfactor;
end;

% external middle ear
[Bext,Aext] = butter(1,[400 8500]*2/fs);
x = filter(Bext,Aext,x);

% compute coefs
[fcoefs,cf] = MakeERBFilters2(fs,numchan,lowfreq);
[B,A] = butter(2,20*2/fs);

% erb filtering
xf = ERBFilterBank2(x,fcoefs);

% clean up data
y = max(xf,0);

% compress
y = y.^compress;

% smoothing
y = filter(B,A,y');
y = y';


if toPlot
  % build time axis
  t = [0:1:size(y,2)-1]/fs*1000;
  %  imagesc(t,[1:1:length(cf)],20*log10(y))
  imagesc(t,[1:1:length(cf)],y)
  f = [4:4:length(cf)];
  set(gca,'ytick',f);
  set(gca,'yticklabel',round(cf(f)));
  xlabel('Time (ms)');
  ylabel('Centre Frequency (Hz)')
end
