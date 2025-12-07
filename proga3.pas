program lab3_integral;

uses
  Crt;

var
  a, b, result, error_est: real;
  n: integer;
  choice: integer;
  exitFlag: boolean;
  paragraphs: integer;

// Функция, заданная в условии
function f(x: real): real;
begin
  f := 2*x*x*x + 2*x*x + 7;
end;

// Вычисление интеграла методом средних прямоугольников
function calculate_integral(a, b: real; n: integer): real;
var
  h, x_mid, sum: real;
  i: integer;
begin
  h := (b - a) / n;
  sum := 0;
  
  for i := 1 to n do
  begin
    x_mid := a + (i - 0.5) * h;
    sum := sum + f(x_mid);
  end;
  
  calculate_integral := h * sum;
end;

// оценка погрешности метода средних прямоугольников
function estimate_error(a, b: real; n: integer): real;
var
  h, max_second_derivative, error: real;
begin
  // |E| <= (b-a) * h^2 * max|f''(x)| / 24
  
  h := (b - a) / n;
  
  max_second_derivative := max(abs(12*a + 4), abs(12*b + 4));
  
  // вычисляем оценку погрешности
  error := (b - a) * h * h * max_second_derivative / 24;
  
  estimate_error := error;
end;

// процедура ввода пределов интегрирования
procedure input_limits;
begin
  ClrScr;
  write('Введите нижний и верхний предел интегрирования (a b): ');
  read(a, b);
  
  if a > b then
  begin
    writeln('Замечание: a > b');
    input_limits;
  end;
  
  write('Введите количество разбиений (n): ');
  readln(n);
  
  if n <= 0 then 
  begin
    writeln('Замечание: n должно быть больше 0');
    input_limits
  end;
  
  writeln('Пределы установлены: a = ', a, ', b = ', b, ', n = ', n);
  writeln('Нажмите любую клавишу для продолжения...');
  ReadKey;
end;

// процедура вычисления интеграла
procedure compute_integral;
begin
  ClrScr;
  if not ((a <> 0) or (b <> 0)) then
  begin
    writeln('Ошибка: сначала установите пределы интегрирования!');
    writeln('Нажмите любую клавишу для продолжения...');
    ReadKey;
    exit;
  end;
  
  result := calculate_integral(a, b, n);
  error_est := estimate_error(a, b, n);
  
  writeln('результаты вычислений:');
  writeln('площадь фигуры (интеграл): ', result:0:3);
  writeln('оценка погрешности: ±', error_est:0:3);
  writeln('Нажмите любую клавишу для продолжения...');
  ReadKey;
end;

// процедура отрисовки меню
procedure menu;
begin
  ClrScr;
  writeln('Программа вычисления площади фигуры');
  writeln('f(x) = 2x³ + 2x² + 7');
  writeln('====================================');
  writeln;
  
  if choice = 1 then write('-> ') else write('   ');
  writeln('1. Ввести пределы интегрирования');
  
  if choice = 2 then write('-> ') else write('   ');
  writeln('2. Вычислить площадь (интеграл)');
  
  if choice = 3 then write('-> ') else write('   ');
  writeln('0. Выход');
  writeln;
  
  if (a <> 0) or (b <> 0) then
    writeln('Текущие пределы: a = ', a, ', b = ', b, ', n = ', n)
  else
    writeln('Пределы интегрирования не заданы');
  writeln;
  writeln('Используйте W/S для навигации, Enter - выбор');
end;

// основная программа
begin
  // инициализация переменных
  a := 0;
  b := 0;
  n := 0;
  choice := 1;
  exitFlag := false;
  paragraphs := 3;
  
  repeat
    menu;
    
    case ReadKey of
      'ц', 'Ц', 'w', 'W', #38:  // Вверх
        begin
          choice := choice - 1;
          if choice < 1 then choice := paragraphs;
        end;
      'ы', 'Ы', 's', 'S', #40:  // Вниз
        begin
          choice := choice + 1;
          if choice > paragraphs then choice := 1;
        end;
      #13:  // Enter
        begin
          case choice of
            1: input_limits;
            2: compute_integral;
            3: exitFlag := True;
          end;
        end;
    end;
    
  until exitFlag;
  
  writeln('Завершение программы...');
end.