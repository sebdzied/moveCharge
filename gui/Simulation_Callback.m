function Simulation_Callback(hObject, eventdata, handles)
%
%--- Executes on button press in Simulation.
% hObject    handle to buttonSimulation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%
global message simulation
set(handles.Simulation,'Enable','Off');
set(handles.NewGame,'Enable','Off');
set(handles.Reset,'Enable','Off');
set(handles.TextHeading, 'String', message.textHeadingMove);

if(simulation.gameFlag==1)
    simulation.nrOfAttempts(simulation.level)=simulation.nrOfAttempts(simulation.level)+1;
    set(handles.AttemptsText(simulation.level),'String',simulation.nrOfAttempts(simulation.level));
    [simulation.charges,simulation.wires]=set_level(simulation.level,simulation.charges,simulation.wires,hObject);
end

cla(handles.Area);
draw_path(simulation.gridSize,simulation.path,handles.Area,simulation.areaDim);
draw_game_area(simulation.charges,simulation.wires,handles.Area,simulation.areaDim,simulation.r,simulation.v);
service_move_enable(0);

simulation.rSaved2 = simulation.rSaved1;
simulation.rSaved1 = simulation.rSaved;

simulation.pktStop2 =simulation.pktStop1;
simulation.pktStop1=simulation.pktStop;

simulation.isSimCorrect=0;
[simulation.rSaved, simulation.isSimCorrect] = calculations(simulation.charges,simulation.wires,simulation.v,simulation.r,simulation.q,simulation.m,simulation.step,simulation.method,simulation.areaDim);

if(simulation.isSimCorrect==1)
    simulation.pktStop=check_path(simulation.rSaved, simulation.gridSize,simulation.path,simulation.areaDim);
else
    simulation.pktStop=size(simulation.rSaved,1);
end
%save the last three attempts
draw_trajectory(handles.Area,simulation.areaDim,simulation.rSaved2,simulation.pktStop2,0);
draw_trajectory(handles.Area,simulation.areaDim,simulation.rSaved1,simulation.pktStop1,0);
draw_trajectory(handles.Area,simulation.areaDim,simulation.rSaved,simulation.pktStop,1);

if(simulation.pktStop==0 && simulation.isSimCorrect==1)
    set(handles.TextHeading, 'String', message.textHeadingWin);
    simulation.gameFlag=0;
    set(handles.Simulation,'Visible','Off');
    set(findobj('Tag',['Check',num2str(simulation.level)]), 'Value', 1);
else
    set(handles.TextHeading, 'String', message.textHeadingLose);
    service_move_enable(1);
end

set(handles.Simulation,'Enable','On');
set(handles.NewGame,'Enable','On');
set(handles.Reset,'Enable','On');
% update handles structure
guidata(hObject, handles);

end

