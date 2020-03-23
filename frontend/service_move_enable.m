function service_move_enable(enable)
%
%  service_move_enable: a function that enables/disables mouse event handling 
%
% INPUTS
%  enable    : flag "1" enable / "0" disable mouse event
%
% OUTPUTS
%  this function has no output args
%
global simulation

if enable==0
    for i=1:size(simulation.charges,2)
        if(simulation.charges(i).value>0)
            set(findobj('Tag',['cFrameP',num2str(i)]),'ButtonDownFcn',[]);
        elseif(simulation.charges(i).value<0)
            set(findobj('Tag',['cFrameM',num2str(i)]),'ButtonDownFcn',[]);
        end
    end
    for i=1:size(simulation.wires,2)
        if(simulation.wires(i).value~=0)
            set(findobj('Tag',['wFrameP',num2str(i)]),'ButtonDownFcn',[]);
            set(findobj('Tag',['wFrameM',num2str(i)]),'ButtonDownFcn',[]);
        end
    end
else
    for i=1:size(simulation.charges,2)
        if(simulation.charges(i).value>0)
            set(findobj('Tag',['cFrameP',num2str(i)]),'ButtonDownFcn','service_move moveCharge');
        elseif(simulation.charges(i).value<0)
            set(findobj('Tag',['cFrameM',num2str(i)]),'ButtonDownFcn','service_move moveCharge');
        end
    end
    for i=1:size(simulation.wires,2)
        if(simulation.wires(i).value~=0)
            set(findobj('Tag',['wFrameP',num2str(i)]),'ButtonDownFcn','service_move moveWire');
            set(findobj('Tag',['wFrameM',num2str(i)]),'ButtonDownFcn','service_move moveWire');
        end
    end
end

end

