function draw_trajectory(area,areaDim,rSaved,pktStop,drawNow)
%
%  draw_trajectory: function that draws particular points "." 
%                   it creates detailed movement of charge on the board
%
% INPUTS
%  area            : axis handle
%  aredDim         : area (game board) dimension [x;y]
%  rSaved          : saved trajectory in form vector of location
%  pktStop         : index of location where instance path equals "0", doesnt fit
%  drawNow         : flag, is every point to be drawn in real time mode?
%
% OUTPUTS          
%  this function has no output args
%
i=1;
set(findobj('Tag','labvoarrow'),'String','');
set(findobj('Tag','labvo'),'String','');
absDim = abs(areaDim(:,2) - areaDim(:,1));

while(rSaved(i,1)>=areaDim(1,1)-absDim(1)*0.01 && rSaved(i,1)<=areaDim(1,2)+absDim(1)*0.01) && (rSaved(i,2)>=areaDim(2,1)-absDim(2)*0.01 && rSaved(i,2)<=areaDim(2,2)+absDim(2)*0.01)
    if(i<pktStop && pktStop>0)
        movingChargeFrame = findobj('Tag','movingChargeFrame');
        set(movingChargeFrame,'XData',rSaved(i,1));
        set(movingChargeFrame,'YData',rSaved(i,2));
        movingChargeSign = findobj('Tag','movingChargeSign');
        set(movingChargeSign,'XData',rSaved(i,1));
        set(movingChargeSign,'YData',rSaved(i,2));
        plot(area,rSaved(i,1),rSaved(i,2),'.','Color',[0 0 0]);
    else
        movingChargeFrame = findobj('Tag','movingChargeFrame');
        set(movingChargeFrame,'XData',rSaved(i,1));
        set(movingChargeFrame,'YData',rSaved(i,2));
        movingChargeSign = findobj('Tag','movingChargeSign');
        set(movingChargeSign,'XData',rSaved(i,1));
        set(movingChargeSign,'YData',rSaved(i,2));
        plot(area,rSaved(i,1),rSaved(i,2),'.','Color',[1 0 0]);
    end
    if(pktStop==0)
        movingChargeFrame = findobj('Tag','movingChargeFrame');
        set(movingChargeFrame,'XData',rSaved(i,1));
        set(movingChargeFrame,'YData',rSaved(i,2));
        movingChargeSign = findobj('Tag','movingChargeSign');
        set(movingChargeSign,'XData',rSaved(i,1));
        set(movingChargeSign,'YData',rSaved(i,2));
        plot(area,rSaved(i,1),rSaved(i,2),'.','Color',[0 1 0]);
    end
    
    if(drawNow==1)
        drawnow
    end
    i=i+1;
end

end

