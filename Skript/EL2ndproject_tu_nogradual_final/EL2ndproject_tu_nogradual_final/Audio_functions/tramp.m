function rampedwave=tramp(wave,fs,upramp_ms,downramp_ms)

if ~exist('downramp_ms','var')
    downramp_ms=upramp_ms;
end;

[a,b]=size(wave);
if b==length(wave);
    rotateflag=true;
    wave=wave';
else
    rotateflag=false;
end;

if upramp_ms>0
    rampedwave=internal_ramp(wave, 1/fs, 'sin', 'up____', upramp_ms/1000);
else
    rampedwave=wave;
end

if downramp_ms>0
    rampedwave=internal_ramp(rampedwave, 1/fs, 'sin', 'down__', downramp_ms/1000);
end;

if rotateflag
    rampedwave=rampedwave';
end;

function [y] = internal_ramp (x, dt, sin_or_cos, up_or_down, ramp_duration)

% Check the number of arguments that are passed in.
if (nargin < 5)
    error ('Insufficient arguments');
end
if (nargin > 5)
    error ('Too many arguments');
end

% Check input arguments common to all conditions.

if dt <= 0
    error ('the sampling period (dt) must be > 0');
end

% Start processing.

signal_length = length(x);
signal_duration = signal_length * dt;

if ramp_duration > signal_duration
    error ('ramp is longer than signal');
end

t_ramp = 0:dt:ramp_duration; 
ramp_length = length(t_ramp);  

% Calculate ramp envelopes.
switch sin_or_cos
case 'sin'   
    T = 4.0 * ramp_duration; % period of the ramp.
    arg = 2.0 * pi * t_ramp / T;
    sinrampup = sin(arg);
    sinrampdown = sin(arg + pi/2.0);
case 'cos'
    T = 2.0 * ramp_duration; % period of the ramp.
    arg = 2.0 * pi * t_ramp / T;
    cosrampup = (1 + cos(arg + pi)) / 2.0;
    cosrampdown = (1 + cos(arg)) / 2.0;
otherwise
    error ('invalid input argument');
end

y = x;

% Check whether input is in a row or a colum. If it is a
% column then, used transposed of the calculated envelope.
[n,m] = size(x);
if (n > 1) & (m == 1)
    switch sin_or_cos
    case 'sin'   
        sinrampup = sinrampup';
        sinrampdown = sinrampdown';
    case 'cos'
        cosrampup = cosrampup';
        cosrampdown = cosrampdown';
    end
elseif (n > 1) & (m > 1)
    error ('input signal must be a single row or a single column');
end

% Apply ramps.
switch up_or_down
    
case 'up____'
    
    switch sin_or_cos
    case 'sin'
        y(1:ramp_length) = x(1:ramp_length) .* sinrampup;
    case 'cos'
        y(1:ramp_length) = x(1:ramp_length) .* cosrampup;
    otherwise
        error ('invalid input argument');
    end
    
case 'down__'
    
    switch sin_or_cos
    case 'sin'
        y((signal_length - ramp_length + 1):signal_length) = ...
            x((signal_length - ramp_length + 1):signal_length) .* sinrampdown;
    case 'cos'
        y((signal_length - ramp_length + 1):signal_length) = ...
            x((signal_length - ramp_length + 1):signal_length) .* cosrampdown;
    otherwise
        error ('invalid input argument');
    end
    
case 'updown'
    
    if ramp_duration > (signal_duration/2)
        error ('ramps are longer than signal');
    end
    
    switch sin_or_cos
    case 'sin'
        y(1:ramp_length) = x(1:ramp_length) .* sinrampup;
        y((signal_length - ramp_length + 1):signal_length) = ...
            x((signal_length - ramp_length + 1):signal_length) .* sinrampdown;
    case 'cos'
        y(1:ramp_length) = x(1:ramp_length) .* cosrampup;
        y((signal_length - ramp_length + 1):signal_length) = ...
            x((signal_length - ramp_length + 1):signal_length) .* cosrampdown;
    otherwise
        error ('invalid input argument');
    end
otherwise
    error ('invalid input argument');
end
