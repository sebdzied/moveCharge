function Reset_Callback(hObject, eventdata, handles)
%
% --- Executes on button press in Reset.
% hObject    handle to Reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%
handles.output = hObject;
%comeback to initial setting
analysis_parameters
global message simulation
cla(handles.Area);
set(handles.Reset,'Visible','Off');
set(handles.Simulation,'Visible','Off');
set(handles.TextHeading,'String', message.textHeadingInit);
set(handles.TextLeft,'String',message.textLeftInit);
set(handles.MenuLevel','selectedobject',handles.LvL1);
set(handles.AttemptsText(1,:),'String','');

for i=1:simulation.maxLevel
    set(findobj('Tag',['Check',num2str(i)]), 'Value', 0);
end
hold on;
axis(handles.Area,'equal');
axis(handles.Area,[simulation.areaDim(1,1),simulation.areaDim(1,2),simulation.areaDim(2,1),simulation.areaDim(2,2)]);
% update handles structure
guidata(hObject, handles);

end

