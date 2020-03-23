function AppGui_OpeningFcn(hObject, eventdata, handles, varargin)
%
% --- Executes just before gui is made visible.
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui (see VARARGIN)
%
% Choose default command line output for gui
% UIWAIT makes gui wait for user response (see UIRESUME)
% uiwait(handles.Window);
%
handles.output = hObject;

global message simulation
%initial setting GUI
set(handles.Window,'Name',message.title);
set(handles.Reset,'Visible','Off');
set(handles.Simulation,'Visible','Off');
set(handles.TextHeading,'String', message.textHeadingInit);
set(handles.TextLeft,'String',message.textLeftInit);
set(handles.MenuLevel,'selectedobject',handles.LvL1);

set(handles.Reset,'String',message.buttonReset);
set(handles.Simulation,'String',message.buttonSimulation);
set(handles.NewGame,'String',message.buttonNewGame);
set(handles.MenuLevel,'Title',message.buttonMenuLevel);

for i=1:simulation.maxLevel
    handles.AttemptsText(i) = findobj('Tag',['Attempts', num2str(i)]);
end
hold on;
axis(handles.Area,'equal');
axis(handles.Area,[simulation.areaDim(1,1),simulation.areaDim(1,2),simulation.areaDim(2,1),simulation.areaDim(2,2)]);
% update handles structure
guidata(hObject, handles);

end

