function varargout = interpolation_lagrange(varargin)

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @interpolation_lagrange_OpeningFcn, ...
                   'gui_OutputFcn',  @interpolation_lagrange_OutputFcn, ...
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

% --- Executes just before interpolation_lagrange is made visible.
function interpolation_lagrange_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;

guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = interpolation_lagrange_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function xvector_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function xvector_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function yvector_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function yvector_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function x0vector_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function x0vector_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function y0vector_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function y0vector_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in interpolation.
function interpolation_Callback(hObject, eventdata, handles)
cla('reset');
%��������� ������� ������
xvector=get(handles.xvector,'string');
yvector=get(handles.yvector,'string');
x0vector=get(handles.x0vector,'string');
%�������������� ������� ������ � ������
x = sscanf(xvector,'%f');
y = sscanf(yvector,'%f');
x0 = sscanf(x0vector,'%f');
%��������
if isempty(x)
    msgbox("������ � ������ ���� ��������. ��������� ����","������","error");
end
if isempty(y)
    msgbox("������ Y ������ ���� ��������. ��������� ����","������","error");
end
if isempty(x0)
    msgbox("������ �0 ������ ���� ��������. ��������� ����","������","error");
end
if length(x) ~= length(y) && ~isempty(x) && ~isempty(y)
    msgbox("������� ������ ���� ���������� �����. ��������� ����","������","error");
end
if length(unique(x)) ~= length(x)
    msgbox("������ � ������ ���� ����������. ��������� ����","������","error");
end
if length(unique(y)) ~= length(y)
    msgbox("������ Y ������ ���� ����������. ��������� ����","������","error");
end
if length(unique(x0)) ~= length(x0)
    msgbox("������ �0 ������ ���� ����������. ��������� ����","������","error");
end
%���� ��� ������ ���������, ������� � ��������
if ~isempty(x)&& ~isempty(y) && ~isempty(x0) && length(x) == length(y) && length(unique(x)) == length(x) && length(unique(y)) == length(y) && length(unique(x0)) == length(x0)
    xx=linspace(min(x),max(y),1000);
    %������ ��������
    yy = lagrange4(x,y, xx);
    [y0 L0] = lagrange4(x,y, x0);
    %������ ����������� ���������
    coeff = polyfit(x,y,length(x)-1);
    y_grid = polyval(coeff, x);
    %���������� ������� ���������� ������������ � ������� ���������� ������� � ���������� � �������� �������
    plot(x,y,'or',xx,yy,':r',x0,y0,'*b', x,y_grid), grid on
    legend('������','������������','�����','Polyval', 'location', 'northwest')
    axes(handles.axes1); 
    xlim([min(x) max(x)])
    ylabel('f(x)','FontSize',12); 
    xlabel('x','FontSize',12); 
    set(handles.axes1, 'XMinorGrid', 'on', 'YMinorGrid', 'on');
    set(handles.axes1, 'XGrid', 'on', 'YGrid', 'on', 'GridLineStyle', '-');
    %�������� �������� � ��������� ���� � �������
    set(handles.y0vector,'String',sprintf('%f ', lagrange4(x,y, x0)));
    set(handles.uitable2,'data',[x0 lagrange4(x,y, x0)]);
end
clear;

% --------------------------------------------------------------------
function demo_Callback(hObject, eventdata, handles)
%���������� ����������������� ��������, ���������� � �������
x=[1.2 1.5 1.7 2.0 2.4 2.6 3.1 3.3 3.5 3.9];
y=[7.27 7.549 7.815 8.085 8.359 8.624 8.899 9.165 9.437 9.709];
x0=[1.25 3.55];
set(handles.xvector,'String', '1.2 1.5 1.7 2.0 2.4 2.6 3.1 3.3 3.5 3.9');
set(handles.yvector,'String', '7.27 7.549 7.815 8.085 8.359 8.624 8.899 9.165 9.437 9.709');
set(handles.x0vector,'String', '1.25 3.55');
x1 = sscanf(get(handles.x0vector,'string'),'%f');
xx=linspace(min(x),max(y),1000);
yy = lagrange4(x,y, xx);
[y0 L0] = lagrange4(x,y, x0);
coeff = polyfit(x,y,length(x)-1);
y_grid = polyval(coeff, x);
yy0 = [lagrange4(x,y, x0)].';
axes(handles.axes1); 
hold on
xlim([1.2 3.9])
plot(x,y,'or',xx,yy,':r',x0,y0,'*b', x,y_grid), grid on
legend('������','������������','�����','Polyval', 'location', 'northwest')
ylabel('f(x)','FontSize',12); 
xlabel('x','FontSize',12); 
set(handles.axes1, 'XMinorGrid', 'on', 'YMinorGrid', 'on');
set(handles.axes1, 'XGrid', 'on', 'YGrid', 'on', 'GridLineStyle', '-');
set(handles.y0vector,'String',sprintf('%f ', lagrange4(x,y, x0)));
set(handles.uitable2,'data',[x1 yy0]);
clear;

% --------------------------------------------------------------------
function userdata_Callback(hObject, eventdata, handles)
%������� ���� ����� � �������
cla('reset');
set(handles.xvector,'String', '');
set(handles.yvector,'String', '');
set(handles.x0vector,'String', '');
set(handles.y0vector,'String', '');
set(handles.uitable2,'data',[]);


% --------------------------------------------------------------------
function author_Callback(hObject, eventdata, handles)
info = msgbox(["�������� ���������: ���������������� ������� �� �������� ��������";
    "����������: ����� ����������������� ����������";
    "������������ ������ �������: � ����� ����������� ����� �������, ������� �������� ���������������� ���������"; 
    "���� ��������� ��������: 21.05.23"; "���: "; "������:"; "��������:"], "���������� � ��������� � ������");

% --------------------------------------------------------------------
function menu_Callback(hObject, eventdata, handles)
