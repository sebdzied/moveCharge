function NewGame_Callback(hObject, eventdata, handles)
%
% --- Executes on button press in NewGame.
% hObject    handle to buttonNewGame (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%
global message simulation
cla(handles.Area); % reset graphics objects before start new game
set(handles.Simulation,'Enable','Off');
set(handles.NewGame,'Enable','Off');
set(handles.TextHeading,'String',message.textHeadingWait);

simulation.gameFlag=1;
simulation.isSimCorrect=0;

% get selected 'radiobutton' with 'buttongroup', object containing a menu with levels
simulation.level= get(get(handles.MenuLevel,'SelectedObject'),'UserData'); %check which level has been selected

set(handles.TextLeft,'String',message.textLeft{simulation.level}); %set the level description

%zeroing the level settings
set(findobj('Tag',['Check',num2str(simulation.level)]), 'Value', 0);
simulation.nrOfAttempts(simulation.level) = 0;
set(handles.AttemptsText(simulation.level),'String',simulation.nrOfAttempts(simulation.level));

maxIt = 100;
it = 0;
while(simulation.isSimCorrect==0 && it<maxIt)
    %draw a initial configurations depend to the level
    [simulation.charges, simulation.wires] = rand_config(simulation.level,simulation.q,simulation.Rsmall,simulation.Rlarge,simulation.Rwire,simulation.areaDim,simulation.current);
    %make a main calculations
    [simulation.rSaved, simulation.isSimCorrect] = calculations(simulation.charges,simulation.wires,simulation.v,simulation.r,simulation.q,simulation.m,simulation.step,simulation.method,simulation.areaDim);
    it = it+1;
end

if(simulation.isSimCorrect==1)
    %filling the path based on the received track
    [simulation.path] = calc_path(simulation.rSaved,simulation.gridSize, size(simulation.path),simulation.areaDim);
    draw_path(simulation.gridSize,simulation.path,handles.Area,simulation.areaDim);
    
    %re-drawing to confuse players
    [simulation.charges, simulation.wires] = rand_config(simulation.level,simulation.q,simulation.Rsmall,simulation.Rlarge,simulation.Rwire,simulation.areaDim,simulation.current);
    draw_game_area(simulation.charges,simulation.wires,handles.Area,simulation.areaDim,simulation.r,simulation.v); %drawing of wires and charges
    
    simulation.pktStop1=0;
    simulation.pktStop=0;
    absDim = abs(simulation.areaDim(:,2) - simulation.areaDim(:,1));
    simulation.rSaved1 = [simulation.areaDim(1,2)+absDim(1),simulation.areaDim(2,2)+absDim(2)];
    simulation.rSaved = [simulation.areaDim(1,2)+absDim(1),simulation.areaDim(2,2)+absDim(2)];
    
    set(handles.Simulation,'Visible','On');
    set(handles.Reset','Visible','On');
    set(handles.TextHeading,'String',message.textHeadingStart);
else
    %protection in case of some simulation problems
    set(handles.TextHeading,'String',message.textHeadingError);
    set(handles.Simulation,'Visible','Off');
end

set(handles.Simulation,'Enable','On');
set(handles.NewGame,'Enable','On');
% update handles structure
guidata(hObject, handles);

end

