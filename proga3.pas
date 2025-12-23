program lab3_integral;

uses
  Crt;

var
  a, b: real;
  n: integer;
  choice: integer;
  exitFlag: boolean;
  Calculated: boolean;
  integral_value, error_value: real;

// функция заданная в условии
function f(x: real): real;
begin
  f := 2*x*x*x + 2*x*x + 7;
end;

// первообразная функция
function F_antiderivative(x: real): real;
begin
  F_antiderivative := (1/2)*x*x*x*x + (2/3)*x*x*x + 7*x;
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
procedure display_error_estimation(a, b: real; n: integer);
var
  real_integral, approx_integral: real;
  absolute_error, relative_error: real;
begin
  // вычисляем точное значение через первообразную
  real_integral := F_antiderivative(b) - F_antiderivative(a);
  
  // вычисляем приближенное значение
  approx_integral := calculate_integral(a, b, n);
  
  // абсолютная погрешность
  absolute_error := abs(approx_integral - real_integral);
  
  // относительная погрешность (в процентах)
  if real_integral <> 0 then
    relative_error := (absolute_error / abs(real_integral)) * 100
  else
    relative_error := 0;
  
  writeln('Точное значение интеграла: ', real_integral:0:6);
  writeln('Приближенное значение: ', approx_integral:0:6);
  writeln('Абсолютная погрешность: ', absolute_error:0:6);
  writeln('Относительная погрешность: ', relative_error:0:6, ' %');
end;

// ввод одного предела (a или b)
procedure input_a_or_b(var value: real; a_or_b: string);
begin
  ClrScr;
  write('Введите ', a_or_b, ': ');
  readln(value);
  writeln('Значение ', a_or_b, ' = ', value:0:6);
  writeln('Нажмите любую клавишу для продолжения...');
  Calculated := false;
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
  Calculated := false;
  ReadKey;
end;

// Проверка возможности вычисления
function can_compute: boolean;
begin
  can_compute := (n > 0) and (a < b);
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
  if a >= b then writeln('ВАЖНО: a должно быть < b');
  if n <= 0 then writeln('ВАЖНО: n должно быть > 0');
  if Calculated then writeln('Интеграл вычислен: ДА') else writeln('Интеграл вычислен: НЕТ');
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
  exitFlag := false;
  Calculated := false;

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
                  writeln('Ошибка: невозможно вычислить интеграл.');
                  if n <= 0 then writeln('Причина: n должно быть > 0');
                  if a >= b then writeln('Причина: a должно быть < b (сейчас a >= b)');
                end
                else
                begin
                  integral_value := calculate_integral(a, b, n);
                  writeln('Приближенное значение интеграла: ', integral_value:0:6);
                  Calculated := true;
                end;
                writeln('Нажмите любую клавишу для продолжения...');
                ReadKey;
              end;
            5:
              begin
                ClrScr;
                if (not can_compute) or (not Calculated) then
                begin
                  writeln('Ошибка: невозможно оценить погрешность.');
                  if n <= 0 then 
                    writeln('Причина: n должно быть > 0');
                  if a >= b then 
                    writeln('Причина: a должно быть < b (сейчас a >= b)');
                  if not Calculated then 
                    writeln('Причина: сначала выполните вычисление интеграла (пункт 4)');
                end
                else
                begin
                  display_error_estimation(a, b, n);
                end;
                writeln('Нажмите любую клавишу для продолжения...');
                ReadKey;
              end;
            6: exitFlag := true;
          end;
        end;
    end;
  until exitFlag;

  ClrScr;
  writeln('Программа завершена');
  writeln('Нажмите любую клавишу для выхода...');
  ReadKey;
end.
