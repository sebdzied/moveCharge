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
% test program
%
clear all;
close all force
clc;

restoredefaultpath
addpath('gui');
addpath('frontend');
addpath('backend');

method = 1;
step=0.0002; % its time [s] if active 1st method
%step=0.001; % its the constant distance between by further points [m] if active EULER method

q=1.60217653*10^-19; %elementary charge value in coulombs [C]
m=9.10938*10^-31;  %elementary charge mass in [kg]
v=[50,-20,0]; %initial velocity [m/s]
r=[-3,3,0]; %coordinates initial charge location [m]
areaDim = [-3,1;2,4]; %area (game board) dimision [x;y] [m]
Rsmall= 0.01; % radius smaller charge  [m]
Rlarge = 0.02; %radius bigger charge   [m]
Rwire = 0.02;  %radius wire  [m]
current=-0.002; %aeamperage in wires [A]

charges(1) = struct('coord',[-2.5,2.3,0],'radius',Rsmall,'value',-q);
charges(2) = struct('coord',[0.5,3,0],'radius',Rlarge,'value',q);
wires(1) = struct('pktPlus',[-2,4,0],'radius',Rwire,'pktMinus',[1,3.25,0],'value',current);

[rSaved, isSimCorrect] = calculations(charges,wires,v,r,q,m,step,method,areaDim);

%plot (visualisation)
absDim = abs(areaDim(:,2) - areaDim(:,1));
scaleR=800;
figure
hold on;
for i=1:size(charges,2)
    if(charges(i).value>0)
        plot(charges(i).coord(1),charges(i).coord(2),'b:+','MarkerSize',charges(i).radius*scaleR/2,'LineWidth',0.5,'Color',[0 0 1]);
        plot(charges(i).coord(1),charges(i).coord(2),'b:o','MarkerSize',charges(i).radius*scaleR,'LineWidth',0.5,'Color',[0 0 1]);
    else
        minusX=[charges(i).coord(1)-0.004*absDim(1),charges(i).coord(1)+ 0.006*absDim(1)];
        minusY=[charges(i).coord(2),charges(i).coord(2)];
        line(minusX,minusY, 'LineWidth',0.5,'Color',[1 0 0]);
        plot(charges(i).coord(1),charges(i).coord(2),'r:o','MarkerSize',charges(i).radius*scaleR,'LineWidth',0.5,'Color',[1 0 0]);
    end
end
for i=1:size(wires,2)
    if(wires(i).value~=0)
        wireX=[wires(i).pktPlus(1),wires(i).pktMinus(1)];
        wireY=[wires(i).pktPlus(2),wires(i).pktMinus(2)];
        line(wireX,wireY, 'Color',[0 0 0],'LineWidth',1);
        
        plot(wires(i).pktPlus(1),wires(i).pktPlus(2),'o','MarkerSize',6,'LineWidth',1,'MarkerEdgeColor',[0 0 1],'MarkerFaceColor',[0 0 1]);
        plot(wires(i).pktPlus(1)-0.02*absDim(1),wires(i).pktPlus(2)-0.02*absDim(2),'+','MarkerSize',6,'LineWidth',1,'MarkerEdgeColor',[0 0 1],'MarkerFaceColor',[0 0 1]);
        plot(wires(i).pktMinus(1),wires(i).pktMinus(2),'o','MarkerSize',6,'LineWidth',1,'MarkerEdgeColor',[1 0 0],'MarkerFaceColor',[1 0 0]);
        
        minusX=[wires(i).pktMinus(1)-0.02*absDim(1),wires(i).pktMinus(1)-0.03*absDim(1)];
        minusY=[wires(i).pktMinus(2)-0.02*absDim(2),wires(i).pktMinus(2)-0.02*absDim(2)];
        line(minusX,minusY, 'Color',[1 0 0],'LineWidth',1.25);

    end
end

hold on;
if(~isempty(rSaved)) 
    plot(rSaved(:,1),rSaved(:,2),'.','MarkerSize',4,'Color',[0 0 0]);
    text(rSaved(1,1)+0.01*absDim(1),rSaved(1,2)+0.02*absDim(2),'Start','Tag','labvo','Color',[0 0 0]);
    text(rSaved(end,1)-0.04*absDim(1),rSaved(end,2)+0.05*absDim(2),'End','Tag','labvo','Color',[0 0 0]);
end
grid on;
box on;
axis('equal');
axis([areaDim(1,1),areaDim(1,2),areaDim(2,1),areaDim(2,2)]);

