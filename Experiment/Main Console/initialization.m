function varargout = initialization(varargin)
% INITIALIZATION MATLAB code for initialization.fig
%      INITIALIZATION, by itself, creates a new INITIALIZATION or raises the existing
%      singleton*.
%
%      H = INITIALIZATION returns the handle to a new INITIALIZATION or the handle to
%      the existing singleton*.
%
%      INITIALIZATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INITIALIZATION.M with the given input arguments.
%
%      INITIALIZATION('Property','Value',...) creates a new INITIALIZATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before initialization_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to initialization_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help initialization

% Last Modified by GUIDE v2.5 24-Apr-2017 00:12:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @initialization_OpeningFcn, ...
                   'gui_OutputFcn',  @initialization_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
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


% --- Executes just before initialization is made visible.
function initialization_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to initialization (see VARARGIN)

% Choose default command line output for initialization
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes initialization wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = initialization_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function sessionnumber_Callback(hObject, eventdata, handles)
% hObject    handle to sessionnumber (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sessionnumber as text
%        str2double(get(hObject,'String')) returns contents of sessionnumber as a double


% --- Executes during object creation, after setting all properties.
function sessionnumber_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sessionnumber (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in enter.
function enter_Callback(hObject, eventdata, handles)
% hObject    handle to enter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.enter,'Enable','off') 
 
global sessionNumber 
sessionNumber = str2double(get(handles.sessionnumber,'String'));

global player1xcoord
global player1ycoord
global player2xcoord
global player2ycoord
global player3xcoord
global player3ycoord
global player4xcoord
global player4ycoord
global player5xcoord
global player5ycoord

player1xcoord = str2double(get(handles.loc11,'String'));
player1ycoord = str2double(get(handles.loc12,'String'));
player2xcoord = str2double(get(handles.loc21,'String'));
player2ycoord = str2double(get(handles.loc22,'String'));
player3xcoord = str2double(get(handles.loc31,'String'));
player3ycoord = str2double(get(handles.loc32,'String'));
player4xcoord = str2double(get(handles.loc41,'String'));
player4ycoord = str2double(get(handles.loc42,'String'));
player5xcoord = str2double(get(handles.loc51,'String'));
player5ycoord = str2double(get(handles.loc52,'String'));

close(initialization)

potareas 

function loc11_Callback(hObject, eventdata, handles)
% hObject    handle to loc11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of loc11 as text
%        str2double(get(hObject,'String')) returns contents of loc11 as a double


% --- Executes during object creation, after setting all properties.
function loc11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to loc11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function loc12_Callback(hObject, eventdata, handles)
% hObject    handle to loc12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of loc12 as text
%        str2double(get(hObject,'String')) returns contents of loc12 as a double


% --- Executes during object creation, after setting all properties.
function loc12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to loc12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function loc21_Callback(hObject, eventdata, handles)
% hObject    handle to loc21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of loc21 as text
%        str2double(get(hObject,'String')) returns contents of loc21 as a double


% --- Executes during object creation, after setting all properties.
function loc21_CreateFcn(hObject, eventdata, handles)
% hObject    handle to loc21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function loc22_Callback(hObject, eventdata, handles)
% hObject    handle to loc22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of loc22 as text
%        str2double(get(hObject,'String')) returns contents of loc22 as a double


% --- Executes during object creation, after setting all properties.
function loc22_CreateFcn(hObject, eventdata, handles)
% hObject    handle to loc22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function loc31_Callback(hObject, eventdata, handles)
% hObject    handle to loc31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of loc31 as text
%        str2double(get(hObject,'String')) returns contents of loc31 as a double


% --- Executes during object creation, after setting all properties.
function loc31_CreateFcn(hObject, eventdata, handles)
% hObject    handle to loc31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function loc32_Callback(hObject, eventdata, handles)
% hObject    handle to loc32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of loc32 as text
%        str2double(get(hObject,'String')) returns contents of loc32 as a double


% --- Executes during object creation, after setting all properties.
function loc32_CreateFcn(hObject, eventdata, handles)
% hObject    handle to loc32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function loc41_Callback(hObject, eventdata, handles)
% hObject    handle to loc41 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of loc41 as text
%        str2double(get(hObject,'String')) returns contents of loc41 as a double


% --- Executes during object creation, after setting all properties.
function loc41_CreateFcn(hObject, eventdata, handles)
% hObject    handle to loc41 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function loc42_Callback(hObject, eventdata, handles)
% hObject    handle to loc42 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of loc42 as text
%        str2double(get(hObject,'String')) returns contents of loc42 as a double


% --- Executes during object creation, after setting all properties.
function loc42_CreateFcn(hObject, eventdata, handles)
% hObject    handle to loc42 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function loc51_Callback(hObject, eventdata, handles)
% hObject    handle to loc51 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of loc51 as text
%        str2double(get(hObject,'String')) returns contents of loc51 as a double


% --- Executes during object creation, after setting all properties.
function loc51_CreateFcn(hObject, eventdata, handles)
% hObject    handle to loc51 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function loc52_Callback(hObject, eventdata, handles)
% hObject    handle to loc52 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of loc52 as text
%        str2double(get(hObject,'String')) returns contents of loc52 as a double


% --- Executes during object creation, after setting all properties.
function loc52_CreateFcn(hObject, eventdata, handles)
% hObject    handle to loc52 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
