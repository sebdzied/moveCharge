function varargout = AppGui(varargin)
%
% APPGUI MATLAB code file for AppGui.fig
%      APPGUI, by itself, creates a new APPGUI or raises the existing
%      singleton*.
%
%      H = APPGUI returns the handle to a new APPGUI or the handle to
%      the existing singleton*.
%
%      APPGUI('Property','Value',...) creates a new APPGUI using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to AppGui_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      APPGUI('CALLBACK') and APPGUI('CALLBACK',hObject,...) call the
%      local function named CALLBACK in APPGUI.M with the given input
%      arguments.
%
%      *See APPGUI Options on GUIDE's Tools menu.  Choose "APPGUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES
% Edit the above text to modify the response to help AppGui
% Last Modified by GUIDE v2.5 
% Begin initialization code - DO NOT EDIT
%
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @AppGui_OpeningFcn, ...
                   'gui_OutputFcn',  @AppGui_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
   gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

