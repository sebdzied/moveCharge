function service_move(event)
%
%  service_move:  mouse event handling
%
% INPUTS
%  event   : event associated moving wire or charge (catched or released mouse)
%
% OUTPUTS
%  this function has no output args directly
%  gcbf returns the handle of the figure that contains the object whose callback is currently executing
%  gca  returns the current axes for the current object
%  gco  returns the handle of the current object
%
global simulation

areaDim = simulation.areaDim;
absDim = abs(areaDim(:,2) - areaDim(:,1));
centerArea = (areaDim(:,2) +  areaDim(:,1))/2;

shiftChargeMinusXstart = 0.004*absDim(1);
shiftChargeMinusXend = 0.006*absDim(1);

shiftWireFrameX = 0.01*absDim(1);
shiftWireFrameY = 0.01*absDim(2);
shiftWirePlusX = 0.02*absDim(1);
shiftWirePlusY = 0.02*absDim(2);
shiftWireMinusX = 0.02*absDim(1);
shiftWireMinusY = 0.02*absDim(2);
shiftWireMinusLenX = shiftWireMinusX+0.01*absDim(1);

switch event
    case 'moveCharge'
        set(gcbf,'WindowButtonMotionFcn','service_move catchCharge');
        set(gcbf,'WindowButtonUpFcn','service_move releaseCharge');
    case 'catchCharge'
        pkt = get(gca,'CurrentPoint');
        which = get(gco,'Tag');
        
        switch which(7)
            case 'P'
                sign = findobj('Tag',['cSignP',which(8:end)]);
                if(pkt(1,1)>=areaDim(1,1) && pkt(1,2)>=areaDim(2,1) && pkt(1,1)<=areaDim(1,2) && pkt(1,2)<=areaDim(2,2))
                    chargeXrelease=pkt(1,1);
                    chargeYrelease=pkt(1,2);
                else
                    chargeXrelease = centerArea(1);
                    chargeYrelease = centerArea(2);
                end
            case 'M'
                sign = findobj('Tag',['cSignM',which(8:end)]);
                if(pkt(1,1)>=areaDim(1,1) && pkt(1,2)>=areaDim(2,1) && pkt(1,1)<=areaDim(1,2) && pkt(1,2)<=areaDim(2,2))
                    chargeXrelease=[pkt(1,1)-shiftChargeMinusXstart,pkt(1,1)+shiftChargeMinusXend];
                    chargeYrelease=[pkt(1,2),pkt(1,2)];
                else
                    chargeXrelease =[centerArea(1)-shiftChargeMinusXstart,centerArea(1)+shiftChargeMinusXend];
                    chargeYrelease =[centerArea(2),centerArea(2)];
                end
        end
        
        set(sign,'XData',chargeXrelease);
        set(sign,'YData',chargeYrelease);
        if(pkt(1,1)>=areaDim(1,1) && pkt(1,2)>=areaDim(2,1) && pkt(1,1)<=areaDim(1,2) && pkt(1,2)<=areaDim(2,2))
            set(gco,'XData',pkt(1,1));
            set(gco,'YData',pkt(1,2));
        else
            set(gco,'XData',centerArea(1));
            set(gco,'YData',centerArea(2));
        end
        drawnow;
        
    case 'releaseCharge'
        set(gcbf,'WindowButtonMotionFcn','');
        set(gcbf,'WindowButtonUpFcn','');
        snapnow;
        
    case 'moveWire'
        set(gcbf,'WindowButtonMotionFcn','service_move catchWire');
        set(gcbf,'WindowButtonUpFcn','service_move releaseWire');
        
    case 'catchWire'
        pkt = get(gca,'CurrentPoint');
        set(gco,'XData',pkt(1,1));
        set(gco,'YData',pkt(1,2));
        
        which = get(gco,'Tag');
        wireLine = findobj('Tag',['wireLine',which(8:end)]);
        
        wireXcatch=get(wireLine,'XData');
        wireYcatch=get(wireLine,'YData');
        
        switch which(7)
            case 'P'
                newWireX = [pkt(1,1) wireXcatch(1,2)];
                newWireY = [pkt(1,2) wireYcatch(1,2)];
                
            case 'M'
                newWireX = [wireXcatch(1,1) pkt(1,1)];
                newWireY = [wireYcatch(1,1) pkt(1,2)];
        end
        set(wireLine,'XData',newWireX);
        set(wireLine,'YData',newWireY);
        drawnow;
        
    case 'releaseWire'
        pkt = get(gca,'CurrentPoint');
        which = get(gco,'Tag');
        wireX=pkt(1,1);
        wireY=pkt(1,2);
        wireLine = findobj('Tag',['wireLine',which(8:end)]);
        wireXrelease=get(wireLine,'XData');
        wireYrelease=get(wireLine,'YData');
        switch which(7)
            case 'P'
                sign = findobj('Tag',['wSignP',which(8:end)]);
                
                if(wireX<centerArea(1) && wireY<centerArea(2))
                    if(wireX-areaDim(1,1)<=wireY-areaDim(2,1))
                        newWireX = [areaDim(1,1)+shiftWireFrameX wireXrelease(1,2)];
                        newWireY = [pkt(1,2) wireYrelease(1,2)];
                        pktSignX = areaDim(1,1)+shiftWirePlusX;
                        pktSignY = pkt(1,2)+shiftWirePlusY;
                    else
                        newWireX = [pkt(1,1) wireXrelease(1,2)];
                        newWireY = [areaDim(2,1)+shiftWireFrameY wireYrelease(1,2)];
                        pktSignX = pkt(1,1)+shiftWirePlusX;
                        pktSignY = areaDim(2,1)+shiftWirePlusY;
                    end
                elseif(wireX>centerArea(1) && wireY<centerArea(2))
                    if((areaDim(1,2)-wireX)<=wireY-areaDim(2,1))
                        newWireX = [areaDim(1,2)-shiftWireFrameX wireXrelease(1,2)];
                        newWireY = [pkt(1,2) wireYrelease(1,2)];
                        pktSignX = areaDim(1,2)-shiftWirePlusX;
                        pktSignY = pkt(1,2)+shiftWirePlusY;
                    else
                        newWireX = [pkt(1,1) wireXrelease(1,2)];
                        newWireY = [areaDim(2,1)+shiftWireFrameY wireYrelease(1,2)];
                        pktSignX = pkt(1,1)-shiftWirePlusX;
                        pktSignY = areaDim(2,1)+shiftWirePlusY;
                    end
                elseif(wireX>centerArea(1) && wireY>centerArea(2))
                    if((areaDim(1,2)-wireX)<=(areaDim(2,2)-wireY))
                        newWireX = [areaDim(1,2)-shiftWireFrameX wireXrelease(1,2)];
                        newWireY = [pkt(1,2) wireYrelease(1,2)];
                        pktSignX = areaDim(1,2)-shiftWirePlusX;
                        pktSignY = pkt(1,2)-shiftWirePlusY;
                    else
                        newWireX = [pkt(1,1) wireXrelease(1,2)];
                        newWireY = [areaDim(2,2)-shiftWireFrameY wireYrelease(1,2)];
                        pktSignX = pkt(1,1)-shiftWirePlusX;
                        pktSignY = areaDim(2,2)-shiftWirePlusY;
                    end
                elseif(wireX<centerArea(1) && wireY>centerArea(2))
                    if(wireX-areaDim(1,1)<=(areaDim(2,2)-wireY))
                        newWireX = [areaDim(1,1)+shiftWireFrameX wireXrelease(1,2)];
                        newWireY = [pkt(1,2) wireYrelease(1,2)];
                        pktSignX = areaDim(1,1)+shiftWirePlusX;
                        pktSignY = pkt(1,2)-shiftWirePlusY;
                    else
                        newWireX = [pkt(1,1) wireXrelease(1,2)];
                        newWireY = [areaDim(2,2)-shiftWireFrameY wireYrelease(1,2)];
                        pktSignX = pkt(1,1)+shiftWirePlusX;
                        pktSignY = areaDim(2,2)-shiftWirePlusY;
                    end
                end
                
                set(gco,'XData',newWireX(1));
                set(gco,'YData',newWireY(1));
                
            case 'M'
                sign = findobj('Tag',['wSignM',which(8:end)]);
                
                if(wireX<centerArea(1) && wireY<centerArea(2))
                    if(wireX-areaDim(1,1)<=wireY-areaDim(2,1))
                        newWireX = [wireXrelease(1,1) areaDim(1,1)+shiftWireFrameX];
                        newWireY = [wireYrelease(1,1) pkt(1,2)];
                        pktSignX = [areaDim(1,1)+shiftWireMinusX areaDim(1,1)+shiftWireMinusLenX];
                        pktSignY = [pkt(1,2)+shiftWireMinusY pkt(1,2)+shiftWireMinusY];
                    else
                        newWireX = [wireXrelease(1,1) pkt(1,1)];
                        newWireY = [wireYrelease(1,1) areaDim(2,1)+shiftWireFrameY];
                        pktSignX = [pkt(1,1)+shiftWireMinusX pkt(1,1)+shiftWireMinusLenX];
                        pktSignY = [areaDim(2,1)+shiftWireMinusY areaDim(2,1)+shiftWireMinusY];
                    end
                elseif(wireX>centerArea(1) && wireY<centerArea(2))
                    if((areaDim(1,2)-wireX)<=wireY-areaDim(2,1))
                        newWireX = [wireXrelease(1,1) areaDim(1,2)-shiftWireFrameX];
                        newWireY = [wireYrelease(1,1) pkt(1,2)];
                        pktSignX = [areaDim(1,2)-shiftWireMinusX areaDim(1,2)-shiftWireMinusLenX];
                        pktSignY = [pkt(1,2)+shiftWireMinusY pkt(1,2)+shiftWireMinusY];
                    else
                        newWireX = [wireXrelease(1,1) pkt(1,1)];
                        newWireY = [wireYrelease(1,1) areaDim(2,1)+shiftWireFrameY];
                        pktSignX = [pkt(1,1)-shiftWireMinusX pkt(1,1)-shiftWireMinusLenX];
                        pktSignY = [areaDim(2,1)+shiftWireMinusY areaDim(2,1)+shiftWireMinusY];
                    end
                elseif(wireX>centerArea(1) && wireY>centerArea(2))
                    if((areaDim(1,2)-wireX)<=(areaDim(2,2)-wireY))
                        newWireX = [wireXrelease(1,1) areaDim(1,2)-shiftWireFrameX];
                        newWireY = [wireYrelease(1,1) pkt(1,2)];
                        pktSignX = [areaDim(1,2)-shiftWireMinusX areaDim(1,2)-shiftWireMinusLenX];
                        pktSignY = [pkt(1,2)-shiftWireMinusY pkt(1,2)-shiftWireMinusY];
                    else
                        newWireX = [wireXrelease(1,1) pkt(1,1)];
                        newWireY = [wireYrelease(1,1) 1-shiftWireFrameY];
                        pktSignX = [pkt(1,1)-shiftWireMinusX pkt(1,1)-shiftWireMinusLenX];
                        pktSignY = [areaDim(2,2)-shiftWireMinusY areaDim(2,2)-shiftWireMinusY];
                    end
                elseif(wireX<centerArea(1) && wireY>centerArea(2))
                    if(wireX-areaDim(1,1)<=(areaDim(2,2)-wireY))
                        newWireX = [wireXrelease(1,1) areaDim(1,1)+shiftWireFrameX];
                        newWireY = [wireYrelease(1,1) pkt(1,2)];
                        pktSignX = [areaDim(1,1)+shiftWireMinusX areaDim(1,1)+shiftWireMinusLenX];
                        pktSignY = [pkt(1,2)-shiftWireMinusY pkt(1,2)-shiftWireMinusY];
                    else
                        newWireX = [wireXrelease(1,1) pkt(1,1)];
                        newWireY = [wireYrelease(1,1) 1-shiftWireFrameY];
                        pktSignX = [pkt(1,1)+shiftWireMinusX pkt(1,1)+shiftWireMinusLenX];
                        pktSignY = [areaDim(2,2)-shiftWireMinusY areaDim(2,2)-shiftWireMinusY];
                    end
                end
                set(gco,'XData',newWireX(2));
                set(gco,'YData',newWireY(2));
                
        end
        set(sign,'XData',pktSignX);
        set(sign,'YData',pktSignY);
        
        set(wireLine,'XData',newWireX);
        set(wireLine,'YData',newWireY);
        
        set(gcbf,'WindowButtonMotionFcn','');
        set(gcbf,'WindowButtonUpFcn','');
        
end

end

