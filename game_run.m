% Copyright (c) 2018 Gdansk University of Technology
% 
% Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
% 
% The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
% 
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
%
%
% Author: Sebastian Dziedziewicz
% Project homepage: https://github.com/sebdzied/
%

%
% main program - The game presents movement of a charge in a static electromagnetic 
%
clear all;
close all force
clc;

restoredefaultpath
addpath('gui');
addpath('frontend');
addpath('backend');

% input file
analysis_parameters 

global simulation
absDim = abs(simulation.areaDim(:,2) - simulation.areaDim(:,1));
if(simulation.r(1)<=simulation.areaDim(1,1)-absDim(1)*0.01 || simulation.r(1)>=simulation.areaDim(1,2)+absDim(1)*0.01) || (simulation.r(2)<=simulation.areaDim(2,1)-absDim(2)*0.01 || simulation.r(2)>=simulation.areaDim(2,2)+absDim(2)*0.01)
    disp('Check the initial conditions! The charge is not inside the board.')
    return
end

set_message 
hGui = AppGui; 

