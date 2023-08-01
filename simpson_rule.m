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

%ввод функции
f=get(handles.FunctionName,'String');
%проверка возможности использования функции в расчете
try func = str2func(['@(x)' f]);
    
    % ввод левой границы
    strStart=get(handles.Start,'String'); 
    a=str2double(strStart);
    %проверка левой границы на буквы/спецсимволы
    if isnan(a)
        msgbox("Левая граница должна быть числом. Повторите ввод","Ошибка","error");
    end
    
    % ввод правой границы
    strLast=get(handles.Last,'String'); 
    b=str2double(strLast);
    % проверка правой границы на буквы/спецсимволы
    if isnan(b)
        msgbox("Правая граница должна быть числом. Повторите ввод","Ошибка","error");
    end
    
    %ввод точности
    strepsilon=get(handles.epsilon,'String');
    eps=str2double(strepsilon);
    %проверка точности на буквы/спецсимволы
    if isnan(eps) || eps<=0
        msgbox("Точность должна быть положительным числом. Повторите ввод","Ошибка","error");
    end
    
    %ввод количества шагов
    strSteps=get(handles.Steps,'String');
    N=str2double(strSteps);
    %проверка количества шагов на буквы/спецсимволы, четность и
    %положительность
    if isnan(N) || rem(N,2) ~= 0 || N <= 0
        msgbox("Количество шагов должно быть четным положительным числом. Повторите ввод","Ошибка","error");
    end
    
    %проверка на корректность границ: левая граница должна быть меньше
    %правой
    if a>b
        msgbox("Левая граница должна быть меньше правой. Повторите ввод","Ошибка","error");
        
    %если выполняются все условия корректности ввода данных, производится
    %расчет
    elseif a<b && rem(N,2) == 0 && N>0 && eps>0
        %расчет шага
        h = (b-a)/N;
        %инициализация слагаемых общего значения интеграла
        I1 = 0; %для нечентных членов
        I2 = 0; %для четных членов
        %начальное значение счетчика для получения показателя степени
        q = 0; 
        while eps < 1
            eps = eps*10;
            q = q+1;
        end
        %расчет значения интеграла на границах интервала      
        I0 = func(a) + func(b);
        %метод Симпсона
        for i = 1:N-1
            x = a+i*h;
                if rem(i,2) == 0
                    I2 = I2 + 2*func(x);
                else
                    I1 = I1 + 4*func(x);
                end
        end
        I = roundn((h/3*(I0 + I1 + I2)), -q);
        %преобразование значения интеграла в строку
        strI=num2str(I);
        %вывод значения интеграла
        set(handles.Integral,'String',strI);
        %расчет значения интеграла с помощью встроенной функции
        strIBase=num2str(roundn(quad(func,a,b,eps), -q));
        %вывод значения интеграла, рассчитанного встроенной функцией
        set(handles.IntegralBase,'String',strIBase); 
    end     
catch
    %если функция не задана или не может быть преобразована в функцию
    msgbox("Задайте функцию","Ошибка","error");
end



% --- Executes on button press in pbPlot.
function pbPlot_Callback(hObject, eventdata, handles)

try 
    %построение функции, которую ввели 
    x=get(handles.FunctionName,'String'); 
    min=str2double(get(handles.Start,'String')); 
    max=str2double(get(handles.Last,'String')); 
    ezplot(x,[min,max]);
    %подпись оси y
    ylabel('f(x)','FontSize',12);
    %подпись оси x
    xlabel('x','FontSize',12); 
    %сетка графика
    set(handles.axes1, 'XMinorGrid', 'on', 'YMinorGrid', 'on');
    set(handles.axes1, 'XGrid', 'on', 'YGrid', 'on', 'GridLineStyle', '-'); 
catch
    msgbox("Невозможно построить график. Проверьте ввод","Ошибка","error");
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
%создание пункта "Меню"
function Menu_Callback(hObject, eventdata, handles)

% --------------------------------------------------------------------
function demonstrate_Callback(hObject, eventdata, handles)
% расчет тестового варианта
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
%График функции из демонстрационного варианта
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
%очистка всех полей и графика
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
info = msgbox(["Название программы: Численное интегрирование методом Симпсона";
    "Назначение: расчет значения интеграла методом Симпсона";
    "Используемые методы решения: интервал интегрирования разбивается на заданное количество шагов; организуется цикл, в зависимости от четности/нечетности индекса значение слагаемых интергала умножается на соответствующий коэффициент"; 
    "Дата последней редакции: 20.05.23"; "ФИО: "; "Группа: "; "Контакты: "], "Информация об авторе");
