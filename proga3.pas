program lab3_integral;

uses
  Crt;

var
  a, b: real;
  n: integer;
  choice: integer;
  exitFlag: boolean;
  result_computed: boolean;
  integral_value, error_value: real;

// функция заданная в условии
function f(x: real): real;
begin
  f := 2*x*x*x + 2*x*x + 7;
end;

function F(x: real): real;
begin
  F := (1/2)*x*x*x*x+(2/3)*x*x*x+7*x;
end;

// вычисление интеграла методом средних прямоугольников
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
  // макс значение 2 производной на [a,b]
  max_f2: real;
  h: real;
  x: real;
begin

 real_integral = abs(F(b)-F(a));
  
  estimate_error := calculate_integral(a,b)-real_integral;
  relative_error := abs(estimate_error/real_integral) * 100;
  writeln('абсолютная погрешность: ', estimate_error:0:6);
  writeln('относительная погрешность: ', relative_error:0:6);
end;

// ввод одного предела (a или b)
procedure input_a_or_b(var name: real; a_or_b: string);
begin
  ClrScr;
  write('Введите ', a_or_b, ': ');
  readln(name);
  writeln('Значение ', a_or_b, ' = ', name:0:6);
  writeln('Нажмите любую клавишу для продолжения...');
  ReadKey;
end;

// ввод количества разбиений (n)
procedure input_n(var value: integer; name: string);
begin
  ClrScr;
  repeat
    write('Введите ', name, ' (целое, > 0): ');
    readln(value);
    if value <= 0 then
      writeln('Ошибка: значение должно быть больше 0!');
  until value > 0;
  writeln('Значение ', name, ' = ', value);
  writeln('Нажмите любую клавишу для продолжения...');
  ReadKey;
end;

// Вычисление интеграла и погрешности (если возможно)
function can_compute: boolean;
begin
  can_compute := (n > 0) and (a <= b) and (calculate_integral(a, b, n) <> 0);
end;

// Процедура отрисовки меню
procedure menu;
begin
  ClrScr;
  writeln('Программа вычисления интеграла методом средних прямоугольников');
  writeln('f(x) = 2x³ + 2x² + 7');
  writeln('=============================================================');
  writeln;

  if choice = 1 then write('-> ') else write('   ');
  writeln('1. Ввести нижний предел (a)');

  if choice = 2 then write('-> ') else write('   ');
  writeln('2. Ввести верхний предел (b)');

  if choice = 3 then write('-> ') else write('   ');
  writeln('3. Ввести количество разбиений (n)');

  if choice = 4 then write('-> ') else write('   ');
  writeln('4. Вывести значение интеграла');

  if choice = 5 then write('-> ') else write('   ');
  writeln('5. Вывести оценку погрешности');

  if choice = 6 then write('-> ') else write('   ');
  writeln('6. Выход');

  writeln;
  writeln('Текущие значения:');
  writeln('  a = ', a:0:6);
  writeln('  b = ', b:0:6);
  writeln('  n = ', n);
  if a > b then writeln('обязательно a > b');
  if n <= 0 then writeln('n не задано корректно');
  writeln;
  writeln('Используйте W/S для навигации, Enter — выбор');
end;

// Основная программа
begin
  // Инициализация
  a := 0.0;
  b := 0.0;
  n := 0;
  choice := 1;

  repeat
    menu;

    case ReadKey of
      'ц', 'Ц', 'w', 'W', #38:  // Вверх
        begin
          choice := choice - 1;
          if choice < 1 then choice := 6;
        end;
      'ы', 'Ы', 's', 'S', #40:  // Вниз
        begin
          choice := choice + 1;
          if choice > 6 then choice := 1;
        end;
      #13:  // Enter
        begin
          case choice of
            1: input_a_or_b(a, 'нижний предел (a)');
            2: input_a_or_b(b, 'верхний предел (b)');
            3: input_n(n, 'количество разбиений n');
            4:
              begin
                ClrScr;
                if not can_compute then
                begin
                  writeln('ошибка: невозможно вычислить интеграл.');
                  if n <= 0 then writeln('n должно быть > 0');
                  if a > b then writeln('обязательно a <= b');
                end
                else
                begin
                  integral_value := calculate_integral(a, b, n);
                  writeln('значение интеграла: ', integral_value:0:6);
                end;
                writeln('нажмите любую клавишу для продолжения...');
                ReadKey;
              end;
            5:
              begin
                ClrScr;
                if not can_compute then
                begin
                  writeln('ошибка, невозможно оценить погрешность.');
                  if n <= 0 then writeln('n должно быть > 0');
                  if a > b then writeln('обязательно a <= b');
                    else writeln('введите а и b')
                end
                else
                begin
                    estimate_error(a, b, n);
                end;
                writeln('нажмите любую клавишу для продолжения...');
                ReadKey;
              end;
            6: exit;
          end;
        end;
    end;

  ClrScr;
  writeln('программа завершена');
  writeln('нажмите любую клавишу для выхода...');
  ReadKey;
end.
