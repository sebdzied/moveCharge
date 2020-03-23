function draw_game_area(charges, wires, area,areaDim,r,vo)
%
%  draw_game_area: a function that draws wires and charges on the board
%
% INPUTS
%  charges    : a structure consisting all of charges related parameters (e.g location,q,radius)
%  wires      : a structure consisting all of charges related parameters
%  area       : axis handle
%  areaDim    : area (game board) dimension [x;y]
%  r          : vector of location
%  vo         : initial velocity
%
% OUTPUTS
%  this function has no output args
%
scaleR=950; %scaling to a specific size GUI
absDim = abs(areaDim(:,2) - areaDim(:,1));
centerArea = (areaDim(:,2) +  areaDim(:,1))/2;

set(plot(area,r(1,1),r(1,2),'b:+','MarkerSize',scaleR*0.01/2,'LineWidth',0.5),'Tag','movingChargeSign','Color',[0 0 1]);
set(plot(area,r(1,1),r(1,2),'b:o','MarkerSize',scaleR*0.01,'LineWidth',0.5),'Tag','movingChargeFrame','Color',[0 0 1]);

set(text(area,r(1,1)-0.013*absDim(1),r(1,2)+0.045*absDim(2),'\uparrow','FontSize',25),'Tag','labvoarrow','Color',[0 0 0]);
set(text(area,r(1,1)+0.02*absDim(1),r(1,2)+0.04*absDim(2),['Vo = ',num2str(vo(1,2)),' m/s']),'Tag','labvo','Color',[0 0 0]);

shiftChargeMinusXstart = 0.004*absDim(1);
shiftChargeMinusXend = 0.006*absDim(1);

shiftWirePlusX = 0.02*absDim(1);
shiftWirePlusY = 0.02*absDim(2);
shiftWireMinusX = 0.02*absDim(1);
shiftWireMinusY = 0.02*absDim(2);
shiftWireMinusLenX = shiftWireMinusX+0.01*absDim(1);

for i=1:size(charges,2)
    if(charges(i).value>0)
        plus = plot(area,charges(i).coord(1),charges(i).coord(2),'b:+','MarkerSize',charges(i).radius*scaleR/2,'LineWidth',0.5);
        frame = plot(area,charges(i).coord(1),charges(i).coord(2),'b:o','MarkerSize',charges(i).radius*scaleR,'LineWidth',0.5);
        set(plus,'Tag',['cSignP',num2str(i)]);
        set(frame,'ButtonDownFcn','service_move moveCharge','Tag',['cFrameP',num2str(i)]);
    elseif(charges(i).value<0)
        minusX=[charges(i).coord(1)-shiftChargeMinusXstart,charges(i).coord(1)+shiftChargeMinusXend];
        minusY=[charges(i).coord(2),charges(i).coord(2)];
        minus = line(area,minusX,minusY, 'Color','Red','LineWidth',0.5);
        frame = plot(area,charges(i).coord(1),charges(i).coord(2),'r:o','MarkerSize',charges(i).radius*scaleR,'LineWidth',0.5);
        set(minus,'Tag',['cSignM',num2str(i)]);
        set(frame,'ButtonDownFcn','service_move moveCharge','Tag',['cFrameM',num2str(i)]);
    end
end

for i=1:size(wires,2)
    
    if(wires(i).value~=0)
        wireX=[wires(i).pktPlus(1),wires(i).pktMinus(1)];
        wireY=[wires(i).pktPlus(2),wires(i).pktMinus(2)];
        wireLine = line(area,wireX,wireY, 'Color',[0 0 0],'LineWidth',1);
        
        framePlus = plot(area,wires(i).pktPlus(1),wires(i).pktPlus(2),'o','MarkerSize',6,'LineWidth',1,'MarkerEdgeColor',[0 0 1],'MarkerFaceColor',[0 0 1]);
        frameMinus=plot(area,wires(i).pktMinus(1),wires(i).pktMinus(2),'o','MarkerSize',6,'LineWidth',1,'MarkerEdgeColor',[1 0 0],'MarkerFaceColor',[1 0 0]);
        if(wireX(1)<centerArea(1) && wireY(1)<centerArea(2))
            plus = plot(area,wires(i).pktPlus(1)+shiftWirePlusX,wires(i).pktPlus(2)+shiftWirePlusY,'+','MarkerSize',6,'LineWidth',1,'MarkerEdgeColor',[0 0 1],'MarkerFaceColor',[0 0 1]);
        elseif(wireX(1)>centerArea(1) && wireY(1)<centerArea(2))
            plus = plot(area,wires(i).pktPlus(1)-shiftWirePlusX,wires(i).pktPlus(2)+shiftWirePlusY,'+','MarkerSize',6,'LineWidth',1,'MarkerEdgeColor',[0 0 1],'MarkerFaceColor',[0 0 1]);
        elseif(wireX(1)>centerArea(1) && wireY(1)>centerArea(2))
            plus = plot(area,wires(i).pktPlus(1)-shiftWirePlusX,wires(i).pktPlus(2)-shiftWirePlusY,'+','MarkerSize',6,'LineWidth',1,'MarkerEdgeColor',[0 0 1],'MarkerFaceColor',[0 0 1]);
        elseif(wireX(1)<centerArea(1) && wireY(1)>centerArea(2))
            plus = plot(area,wires(i).pktPlus(1)+shiftWirePlusX,wires(i).pktPlus(2)-shiftWirePlusY,'+','MarkerSize',6,'LineWidth',1,'MarkerEdgeColor',[0 0 1],'MarkerFaceColor',[0 0 1]);
        end
        
        if(wireX(2)<centerArea(1) && wireY(2)<centerArea(2))
            minusX=[wires(i).pktMinus(1)+shiftWireMinusX,wires(i).pktMinus(1)+shiftWireMinusLenX];
            minusY=[wires(i).pktMinus(2)+shiftWireMinusY,wires(i).pktMinus(2)+shiftWireMinusY];
        elseif(wireX(2)>centerArea(1) && wireY(2)<centerArea(2))
            minusX=[wires(i).pktMinus(1)-shiftWireMinusX,wires(i).pktMinus(1)-shiftWireMinusLenX];
            minusY=[wires(i).pktMinus(2)+shiftWireMinusY,wires(i).pktMinus(2)+shiftWireMinusY];
        elseif(wireX(2)>centerArea(1) && wireY(2)>centerArea(2))
            minusX=[wires(i).pktMinus(1)-shiftWireMinusX,wires(i).pktMinus(1)-shiftWireMinusLenX];
            minusY=[wires(i).pktMinus(2)-shiftWireMinusY,wires(i).pktMinus(2)-shiftWireMinusY];
        elseif(wireX(2)<centerArea(1) && wireY(2)>centerArea(2))
            minusX=[wires(i).pktMinus(1)+shiftWireMinusX,wires(i).pktMinus(1)+shiftWireMinusLenX];
            minusY=[wires(i).pktMinus(2)-shiftWireMinusY,wires(i).pktMinus(2)-shiftWireMinusY];
        end
        
        minus = line(area,minusX,minusY, 'Color',[1 0 0],'LineWidth',0.5);
        
        set(wireLine,'Tag',['wireLine',num2str(i)]);
        set(framePlus,'ButtonDownFcn','service_move moveWire','Tag',['wFrameP',num2str(i)]);
        set(plus,'Tag',['wSignP',num2str(i)]);
        set(frameMinus,'ButtonDownFcn','service_move moveWire','Tag',['wFrameM',num2str(i)]);
        set(minus,'Tag',['wSignM',num2str(i)]);
        
    end
end

end

