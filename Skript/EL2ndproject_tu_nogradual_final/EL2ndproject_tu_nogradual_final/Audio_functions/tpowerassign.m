function [output_signal] = tpowerassign(input_signal, targetpower_db)
%function [output_signal] = tpowerassign(input_signal, targetpower_db)
%
% The gpowerequal function assign the power of a signal to a specified  target power in dB 
% power given as an input 
% 
%   adapted from a program by Ga?tan Gilbert, Autumn 2004 (3xi2004)
%

current_linearpower = mean(input_signal .* input_signal); %mean of power
%current_linearpower = current_linearpower + 1e-99;
currentpower_db = 10*log10(current_linearpower); % calculation to decibel
output_signal = input_signal * sqrt(10^((targetpower_db/10 - currentpower_db/10))); %