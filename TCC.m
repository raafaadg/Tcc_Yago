function varargout = TCC(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @TCC_OpeningFcn, ...
                   'gui_OutputFcn',  @TCC_OutputFcn, ...
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

% --- Executes just before TCC is made visible.
function TCC_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
clc
global com

com=comm;
handles.timer = timer(...
    'ExecutionMode', 'fixedRate', ...       % Run timer repeatedly.
    'Period', .5, ...                        % Initial period is 1 sec.
    'TimerFcn', {@atualizarslider,hObject}); % Specify callback function.

% Update handles structure
guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = TCC_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

guidata(hObject,handles);
% 
% function z= dh(z)
% %  for i=1:6
%       z(i)=dh(i);
%   end 
%      
% --- Executes on slider movement.

function edit1_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.

function edit1_CreateFcn(hObject, eventdata, handles)

%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit2_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)

%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit3_Callback(hObject, eventdata, handles)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
%  Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit5_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in bt_arduino.
function bt_arduino_Callback(hObject, eventdata, handles)
global com
if(isempty(com.ard))
    com.ard=com.conectaArduino;
end
    
guidata(hObject,handles);

 %disp(double(vet))
% --- Executes on button press in bt_close.
function bt_close_Callback(hObject, eventdata, handles)
global com
 com.descomunica;
 clear 
close all


% --- Executes on button press in bt_comunica.
function bt_comunica_Callback(hObject, eventdata, handles)
% hObject    handle to bt_comunica (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global com
if(isempty(com.hCom))
    set(handles.bt_libera,'visible','on')
    com=com.conecta;
    com.comunica; 
else
    set(handles.bt_libera,'visible','off')
end
guidata(hObject,handles);


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in bt_libera.
function bt_libera_Callback(hObject, eventdata, handles)
% hObject    handle to bt_libera (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)]
global com
if(com.FlagResposta == false)
    if (strcmp(com.hCom.Status,'closed'))
        com.comunica;
        disp(' merda')
    end
        atualizaSlider
        com.comunica;
        com=com.envia;
       com.FlagResposta = true;
         start(handles.timer)
         disp('Funciona')
             disp('Timer Ativado')
   
else
    warning('aguardando resposta na serial')
end

%Hint: get(hObject,'Value') returns toggle state of bt_libera
guidata(hObject, handles);

function atualizarslider(hObject, eventdata, handles)
global com

if(com.hCom.BytesAvailable>0)
    com=com.recebe;
    disp(com.BufferRecebe)
    if(strcmp(com.BufferRecebe,'T') || strcmp(com.BufferRecebe,'G') || strcmp(com.BufferRecebe,'OK'))
        stop(hObject)
        com.FlagResposta = false;
        com.descomunica;
    end
end
%    set(handles.edit1,'String', varSlider(1));
%    set(handles.edit2,'String', varSlider(2));
%    set(handles.edit3,'String', varSlider(3));
%    set(handles.edit4,'String', varSlider(4));
%    set(handles.edit5,'String', varSlider(5));
%    set(handles.edit6,'String', varSlider(6));

guidata(handles);

% --- Executes on button press in bt_garra.
function bt_garra_Callback(hObject, eventdata, handles)
% hObject    handle to bt_garra (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global com
   if (strcmp(com.hCom.Status, 'closed'))
      com=com.comunica;
   end 
com=com.envia;
com.outputdata = 'b';
com=com.descomunica;
guidata(hObject, handles);

% --- Executes on button press in bt_origem.
function bt_origem_Callback(hObject, eventdata, handles)
% hObject    handle to bt_origem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global com
if (strcmp(com.hCom.Status, 'closed'))
    com=com.comunica;
end
com=com.envia;
com.outputdata ='c';
com=com.descomunica;

guidata(hObject, handles);
