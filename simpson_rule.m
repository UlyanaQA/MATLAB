function varargout = simpson_rule(varargin)
% Begin initialization code
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @simpson_rule_OpeningFcn, ...
                   'gui_OutputFcn',  @simpson_rule_OutputFcn, ...
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
% End initialization code


% --- Executes just before simpson_rule is made visible.
function simpson_rule_OpeningFcn(hObject, eventdata, handles, varargin)
% Choose default command line output for simpson_rule
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes simpson_rule wait for user response (see UIRESUME)

% --- Outputs from this function are returned to the command line.
function varargout = simpson_rule_OutputFcn(hObject, eventdata, handles) 
% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in pbCalculation.
function pbCalculation_Callback(hObject, eventdata, handles)

%���� �������
f=get(handles.FunctionName,'String');
%�������� ����������� ������������� ������� � �������
try func = str2func(['@(x)' f]);
    
    % ���� ����� �������
    strStart=get(handles.Start,'String'); 
    a=str2double(strStart);
    %�������� ����� ������� �� �����/�����������
    if isnan(a)
        msgbox("����� ������� ������ ���� ������. ��������� ����","������","error");
    end
    
    % ���� ������ �������
    strLast=get(handles.Last,'String'); 
    b=str2double(strLast);
    % �������� ������ ������� �� �����/�����������
    if isnan(b)
        msgbox("������ ������� ������ ���� ������. ��������� ����","������","error");
    end
    
    %���� ��������
    strepsilon=get(handles.epsilon,'String');
    eps=str2double(strepsilon);
    %�������� �������� �� �����/�����������
    if isnan(eps) || eps<=0
        msgbox("�������� ������ ���� ������������� ������. ��������� ����","������","error");
    end
    
    %���� ���������� �����
    strSteps=get(handles.Steps,'String');
    N=str2double(strSteps);
    %�������� ���������� ����� �� �����/�����������, �������� �
    %���������������
    if isnan(N) || rem(N,2) ~= 0 || N <= 0
        msgbox("���������� ����� ������ ���� ������ ������������� ������. ��������� ����","������","error");
    end
    
    %�������� �� ������������ ������: ����� ������� ������ ���� ������
    %������
    if a>b
        msgbox("����� ������� ������ ���� ������ ������. ��������� ����","������","error");
        
    %���� ����������� ��� ������� ������������ ����� ������, ������������
    %������
    elseif a<b && rem(N,2) == 0 && N>0 && eps>0
        %������ ����
        h = (b-a)/N;
        %������������� ��������� ������ �������� ���������
        I1 = 0; %��� ��������� ������
        I2 = 0; %��� ������ ������
        %��������� �������� �������� ��� ��������� ���������� �������
        q = 0; 
        while eps < 1
            eps = eps*10;
            q = q+1;
        end
        %������ �������� ��������� �� �������� ���������      
        I0 = func(a) + func(b);
        %����� ��������
        for i = 1:N-1
            x = a+i*h;
                if rem(i,2) == 0
                    I2 = I2 + 2*func(x);
                else
                    I1 = I1 + 4*func(x);
                end
        end
        I = roundn((h/3*(I0 + I1 + I2)), -q);
        %�������������� �������� ��������� � ������
        strI=num2str(I);
        %����� �������� ���������
        set(handles.Integral,'String',strI);
        %������ �������� ��������� � ������� ���������� �������
        strIBase=num2str(roundn(quad(func,a,b,eps), -q));
        %����� �������� ���������, ������������� ���������� ��������
        set(handles.IntegralBase,'String',strIBase); 
    end     
catch
    %���� ������� �� ������ ��� �� ����� ���� ������������� � �������
    msgbox("������� �������","������","error");
end



% --- Executes on button press in pbPlot.
function pbPlot_Callback(hObject, eventdata, handles)

try 
    %���������� �������, ������� ����� 
    x=get(handles.FunctionName,'String'); 
    min=str2double(get(handles.Start,'String')); 
    max=str2double(get(handles.Last,'String')); 
    ezplot(x,[min,max]);
    %������� ��� y
    ylabel('f(x)','FontSize',12);
    %������� ��� x
    xlabel('x','FontSize',12); 
    %����� �������
    set(handles.axes1, 'XMinorGrid', 'on', 'YMinorGrid', 'on');
    set(handles.axes1, 'XGrid', 'on', 'YGrid', 'on', 'GridLineStyle', '-'); 
catch
    msgbox("���������� ��������� ������. ��������� ����","������","error");
end



function FunctionName_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function FunctionName_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Start_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function Start_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Last_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function Last_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Integral_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function Integral_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function epsilon_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function epsilon_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function Steps_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function Steps_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function IntegralBase_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function IntegralBase_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
%�������� ������ "����"
function Menu_Callback(hObject, eventdata, handles)

% --------------------------------------------------------------------
function demonstrate_Callback(hObject, eventdata, handles)
% ������ ��������� ��������
%exp(-x.^2/2)
func = str2func('@(x) exp(-x.^2/2)');
set(handles.FunctionName,'String', 'exp(-x.^2/2)');
set(handles.Start,'String', '0');
set(handles.Last,'String', '0.042');
set(handles.epsilon,'String', '0.001');
set(handles.Steps,'String', '2');
a = 0;
b = 0.042;
eps = 0.001;
N=2;
h = (b-a)/N;
I0 = func(a) + func(b);
I1 = 0;
I2 = 0;
for i = 1:N-1
    x = a+i*h;
    if rem(i,2) == 0
        I2 = I2 + 2*func(x);
    else
        I1 = I1 + 4*func(x);
    end
end
I = roundn((h/3*(I0 + I1 + I2)), -3);
strI=num2str(I); 
set(handles.Integral,'String',strI);
strIBase=num2str(roundn(quad(func,a,b,eps), -3)); 
set(handles.IntegralBase,'String',strIBase);
%������ ������� �� ����������������� ��������
axes(handles.axes1); 
cla;
x='exp(-x^2/2)'; 
min=a; 
max=b; 
ezplot(x,[min,max]);
ylabel('f(x)','FontSize',12); 
xlabel('x','FontSize',12); 
set(handles.axes1, 'XMinorGrid', 'on', 'YMinorGrid', 'on');
set(handles.axes1, 'XGrid', 'on', 'YGrid', 'on', 'GridLineStyle', '-');

% --------------------------------------------------------------------
function userdata_Callback(hObject, eventdata, handles)
%������� ���� ����� � �������
cla('reset');
set(handles.FunctionName,'String', '');
set(handles.Start,'String', '');
set(handles.Last,'String', '');
set(handles.epsilon,'String', '');
set(handles.Steps,'String', '');
set(handles.Integral,'String','');
set(handles.IntegralBase,'String','');



% --------------------------------------------------------------------
function about_Callback(hObject, eventdata, handles) 
info = msgbox(["�������� ���������: ��������� �������������� ������� ��������";
    "����������: ������ �������� ��������� ������� ��������";
    "������������ ������ �������: �������� �������������� ����������� �� �������� ���������� �����; ������������ ����, � ����������� �� ��������/���������� ������� �������� ��������� ��������� ���������� �� ��������������� �����������"; 
    "���� ��������� ��������: 20.05.23"; "���: "; "������: "; "��������: "], "���������� �� ������");
