function [noise, szBackG] = gef_rndNoise(width, height, luminance)

if nargin < 1; width = 200; end
if nargin < 1; height = 200; end
if nargin < 2; luminance = 200; end


bgNoise = rand(height, width)*255; % noise = rand(200)*255;
noise(:,:,1) = bgNoise;
noise(:,:,2) = bgNoise;
noise(:,:,3) = bgNoise;
noise(:,:,4) = luminance;

szBackG = size(bgNoise);

end