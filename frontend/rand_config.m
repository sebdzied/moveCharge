function [charges, wires] = rand_config(level,q,Rsmall,Rlarge,Rwire,areaDim,current)
%
%  rand_config:  a function that creates random location wires and charges on the area game
%                layout and difficults depends of choose level 
%
% INPUTS
%  level       : number of level
%  q           : elementary charge value in coulombs
%  Rsmall      : radius smaller charge 
%  Rlarge      : radius bigger charge 
%  areamDim    : area (game board) dimension [x;y]
%  current     : aeamperage in wires [A]
%
% OUTPUTS
%  charges     : a structure consisting all of charges related parameters (e.g location,q,radius)
%  wires       : a structure consisting all of wires related parameters (e.g location,current)
%
absDim = abs(areaDim(:,2) - areaDim(:,1));
shiftWireFrameX = 0.01*absDim(1);
shiftWireFrameY = 0.01*absDim(2);
charges(1) = struct('coord',[0,0,0],'radius',Rsmall,'value',0);
charges(2) = struct('coord',[0,0,0],'radius',Rlarge,'value',0);
wires(1:2) = struct('pktPlus',[0,0,0],'radius',Rwire,'pktMinus',[0,0,0],'value',0);

switch level
    case 1
        if(rand>0.5)
            sign =1;
        else
            sign=-1;
        end
        tempX = (areaDim(1,2)-areaDim(1,1)).*rand + areaDim(1,1);
        tempY = (areaDim(2,2)-areaDim(2,1)).*rand + areaDim(2,1);
        charges(1).coord =[tempX tempY 0];
        charges(1).value=q*sign;
    case 2
        for i=1:2
            if(rand>0.5)
                sign =1;
            else
                sign=-1;
            end
            tempX = (areaDim(1,2)-areaDim(1,1)).*rand + areaDim(1,1);
            tempY = (areaDim(2,2)-areaDim(2,1)).*rand + areaDim(2,1);
            charges(i).coord =[tempX tempY 0];
            charges(i).value=q*sign;
        end
    case 3
        wires(1).value = current;
        if(rand<0.5)
            tempXp = (areaDim(1,2)-areaDim(1,1)).*rand + areaDim(1,1);
            tempXm = (areaDim(1,2)-areaDim(1,1)).*rand + areaDim(1,1);
            if(rand>0.5)
                wires(1).pktPlus = [tempXp areaDim(2,1)+shiftWireFrameY 0];
                wires(1).pktMinus = [tempXm areaDim(2,2)-shiftWireFrameY 0];
            else
                wires(1).pktPlus = [tempXp areaDim(2,2)-shiftWireFrameY 0];
                wires(1).pktMinus = [tempXm areaDim(2,1)+shiftWireFrameY 0];
            end
        else
            tempYp = (areaDim(2,2)-areaDim(2,1)).*rand + areaDim(2,1);
            tempYm = (areaDim(2,2)-areaDim(2,1)).*rand + areaDim(2,1);
            if(rand>0.5)
                wires(1).pktPlus = [areaDim(1,1)+shiftWireFrameX tempYp 0];
                wires(1).pktMinus = [areaDim(1,2)-shiftWireFrameX tempYm 0];
            else
                wires(1).pktPlus = [areaDim(1,2)-shiftWireFrameX tempYp 0];
                wires(1).pktMinus = [areaDim(1,1)+shiftWireFrameX tempYm 0];
            end
        end
    case 4
        if(rand>0.5)
            sign =1;
        else
            sign=-1;
        end
        tempX = (areaDim(1,2)-areaDim(1,1)).*rand + areaDim(1,1);
        tempY = (areaDim(2,2)-areaDim(2,1)).*rand + areaDim(2,1);
        charges(1).coord =[tempX tempY 0];
        charges(1).value=q*sign;
        
        wires(1).value = current;
        if(rand<0.5)
            tempXp = (areaDim(1,2)-areaDim(1,1)).*rand + areaDim(1,1);
            tempXm = (areaDim(1,2)-areaDim(1,1)).*rand + areaDim(1,1);
            if(rand>0.5)
                wires(1).pktPlus = [tempXp areaDim(2,1)+shiftWireFrameY 0];
                wires(1).pktMinus = [tempXm areaDim(2,2)-shiftWireFrameY 0];
            else
                wires(1).pktPlus = [tempXp areaDim(2,2)-shiftWireFrameY 0];
                wires(1).pktMinus = [tempXm areaDim(2,1)+shiftWireFrameY 0];
            end
        else
            tempYp = (areaDim(2,2)-areaDim(2,1)).*rand + areaDim(2,1);
            tempYm = (areaDim(2,2)-areaDim(2,1)).*rand + areaDim(2,1);
            if(rand>0.5)
                wires(1).pktPlus = [areaDim(1,1)+shiftWireFrameX tempYp 0];
                wires(1).pktMinus = [areaDim(1,2)-shiftWireFrameX tempYm 0];
            else
                wires(1).pktPlus = [areaDim(1,2)-shiftWireFrameX tempYp 0];
                wires(1).pktMinus = [areaDim(1,1)+shiftWireFrameX tempYm 0];
            end
        end
    case 5
        for i=1:2
            if(rand>0.5)
                sign =1;
            else
                sign=-1;
            end
            tempX = (areaDim(1,2)-areaDim(1,1)).*rand + areaDim(1,1);
            tempY = (areaDim(2,2)-areaDim(2,1)).*rand + areaDim(2,1);
            charges(i).coord =[tempX tempY 0];
            charges(i).value=q*sign;
            
            wires(i).value = current;
            if(rand<0.5)
                tempXp = (areaDim(1,2)-areaDim(1,1)).*rand + areaDim(1,1);
                tempXm = (areaDim(1,2)-areaDim(1,1)).*rand + areaDim(1,1);
                if(rand>0.5)
                    wires(i).pktPlus = [tempXp areaDim(2,1)+shiftWireFrameY 0];
                    wires(i).pktMinus = [tempXm areaDim(2,2)-shiftWireFrameY 0];
                else
                    wires(i).pktPlus = [tempXp areaDim(2,2)-shiftWireFrameY 0];
                    wires(i).pktMinus = [tempXm areaDim(2,1)+shiftWireFrameY 0];
                end
            else
                tempYp = (areaDim(2,2)-areaDim(2,1)).*rand + areaDim(2,1);
                tempYm = (areaDim(2,2)-areaDim(2,1)).*rand + areaDim(2,1);
                if(rand>0.5)
                    wires(i).pktPlus = [areaDim(1,1)+shiftWireFrameX tempYp 0];
                    wires(i).pktMinus = [areaDim(1,2)-shiftWireFrameX tempYm 0];
                else
                    wires(i).pktPlus = [areaDim(1,2)-shiftWireFrameX tempYp 0];
                    wires(i).pktMinus = [areaDim(1,1)+shiftWireFrameX tempYm 0];
                end
            end
        end
end

end

