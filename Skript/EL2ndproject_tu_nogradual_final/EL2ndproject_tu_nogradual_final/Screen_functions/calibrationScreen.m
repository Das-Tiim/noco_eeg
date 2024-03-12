%SCREEN CALIBRATION _ Gamma Correction for gray


% Tipical set of gamma corrections
% GunValue red Y green Y blue Y
% 0 0 0 0
% 28 4.4 5.3 .2
% 57 11.7 14.3 5.7
% 85 20.1 25.1 9.6
% 113 29.5 37.4 13.9
% 142 40.2 51.5 18.8
% 170 51.2 66.3 23.8
% 198 63.0 82.0 29.0
% 227 75.7 99.4 34.6
% 255 88.6 116.9 40.3

%% I = alpha * g^y + betha
% Where I is the intensity of the gun (or guns if you are calibrating for grayscale with all thres guns
% on at an equal gun value), and g is the gun value.

%%% inverse of the gamma function g = ((I-betha)/alpha)^1/y

%%% Example gamma correction gray
calib.gv=[0 28 57 85 113 142 170 198 227 255]; % gun value (gun values refer to the triplet [x y z])
calib.measuredgray= [0.3000 0.5000 4 10 20 35 70 110 140 180]; % desired luminance in cd/m2 (?)
calib.graygamma.alpha = 0.0002141;
calib.graygamma.beta = 0.0023;
calib.graygamma.gamma = 2.4666;

desiredlum = linspace(min(calib.measuredgray), max(calib.measuredgray), 256);

calib.inversegray=((desiredlum-calib.graygamma.beta) ./ calib.graygamma.alpha) .^ (1./calib.graygamma.gamma);

gtable=[calib.inversegray; calib.inversegray; calib.inversegray]';