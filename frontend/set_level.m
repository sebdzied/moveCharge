function [charges,wires] = set_level(level,charges,wires,hObject)
%
%  set_level:  a function that checks and sets wires and charges for a given level before simulation
%
% INPUTS
%  level          : vector of location
%  charges        : input structure consisting all of charges related parameters (e.g location,q,radius)
%  wires          : input a structure consisting all of wires related parameters (e.g location,current)
%  hObject        : handle to figure
%
% OUTPUTS
%  charges        : modified structure consisting all of charges related parameters (e.g location,q,radius)
%  wires          : modified a structure consisting all of wires related parameters (e.g location,current)
%
switch level
    case 1
        if(charges(1).value>0)
            charge = findobj('Tag','cFrameP1');
        else
            charge = findobj('Tag','cFrameM1');
        end
        chargeX = get(charge,'XData');
        chargeY = get(charge,'YData');
        charges(1).coord(1) = chargeX;
        charges(1).coord(2) = chargeY;
    case 2
        for i=1:2
            if(charges(i).value >0)
                charge = findobj('Tag',['cFrameP',num2str(i)]);
            else
                charge = findobj('Tag',['cFrameM',num2str(i)]);
            end
            chargeX = get(charge,'XData');
            chargeY = get(charge,'YData');
            charges(i).coord(1) = chargeX;
            charges(i).coord(2) = chargeY;
        end
        
    case 3
        wire = findobj('Tag','wireLine1');
        wireX = get(wire,'XData');
        wireY = get(wire,'YData');
        wires(1).pktPlus(1) = wireX(1);
        wires(1).pktPlus(2) = wireY(1);
        wires(1).pktMinus(1) = wireX(2);
        wires(1).pktMinus(2) = wireY(2);
    case 4
        wire = findobj('Tag','wireLine1');
        wireX = get(wire,'XData');
        wireY = get(wire,'YData');
        wires(1).pktPlus(1) = wireX(1);
        wires(1).pktPlus(2) =  wireY(1);
        wires(1).pktMinus(1) = wireX(2);
        wires(1).pktMinus(2) =  wireY(2);
        
        if(charges(1).value>0)
            charge = findobj('Tag','cFrameP1');
        else
            charge = findobj('Tag','cFrameM1');
        end
        chargeX = get(charge,'XData');
        chargeY = get(charge,'YData');
        charges(1).coord(1) = chargeX;
        charges(1).coord(2) = chargeY;
        
    case 5
        for i=1:2
            wire = findobj('Tag',['wireLine',num2str(i)]);
            wireX = get(wire,'XData');
            wireY = get(wire,'YData');
            wires(i).pktPlus(1) = wireX(1);
            wires(i).pktPlus(2) = wireY(1);
            wires(i).pktMinus(1) = wireX(2);
            wires(i).pktMinus(2) = wireY(2);
            
            if(charges(i).value >0)
                charge = findobj('Tag',['cFrameP',num2str(i)]);
            else
                charge = findobj('Tag',['cFrameM',num2str(i)]);
            end
            chargeX = get(charge,'XData');
            chargeY = get(charge,'YData');
            charges(i).coord(1) = chargeX;
            charges(i).coord(2) = chargeY;
        end
end

end

