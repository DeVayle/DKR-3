program dkr3_casemenu;
uses Crt;

const
  NORM = 14; { цвет невыделеного пункта }
  SEL = 11; { цвет выделенного пункта }
  Num = 2;

var
  menu: array[1..Num] of string[24];{ названия пунктов меню }
  punkt: integer;
  ch: char;
  x_menu, y_menu, TextAttr: byte;
  a, b, h, x, y, s, ff, p: real;
  n: integer;
  
procedure pravye;
  
function f(xx: real): real;
begin
  f:= xx**3+(-2)*xx**2+(-5)*xx+1;
end;

function perv(xx: real): real;
begin
  perv:= ((b**4)/4 - (2*b**3)/3 - (5*b**2)/2 + b) - ((a**4)/4 - (2*a**3)/3 - (5*a**2)/2 + a);
end;

begin
  writeln('Введите границы интегрирования: ');
  readln(a, b);
  writeln('Введите количество промежутков: ');
  readln(n);
  h:= (b-a)/n;
  x:= a;
  for var i:=1 to n do
  begin
    s+= f(x);
    x+= h;
  end;
  s*= h;
  writeln('Интеграл равен: ', s:0:3);
  writeln('Погрешность: ', perv(x)-s);
end;

procedure punkt1;
begin
  ClrScr;
  pravye;
  writeln;
  writeln('Процедура завершена. Нажмите <Enter> для продолжения.');
  repeat
    ch := readkey;
  until ch = #13;
end;

procedure MenuToScr;{ вывод меню на экран }
var
  i: integer;
begin
  ClrScr;
  for i := 1 to Num do
  begin
    GoToXY(x_menu, y_menu + i - 1);
    write(menu[i]);
  end;
  TextColor(SEL);
  GoToXY(x_menu, y_menu + punkt - 1);
  write(menu[punkt]);{ выделим строку меню }
  TextColor(NORM);
end;





begin
  menu[1] := ' Начать интегрирование ';
  menu[2] := ' Выход ';
  punkt := 1; x_menu := 5; y_menu := 5;
  TextColor(NORM);
  MenuToScr;
  repeat
    ch := ReadKey;
    if ch = #0 then begin
      ch := ReadKey;
      case ch of
        #40:{ стрелка вниз }
          if punkt < Num then begin
            GoToXY(x_menu, y_menu + punkt - 1); write(menu[punkt]);
            punkt := punkt + 1;
            TextColor(SEL);
            GoToXY(x_menu, y_menu + punkt - 1); write(menu[punkt]);
            TextColor(NORM);
          end;
        #38:{ стрелка вверх }
          if punkt > 1 then begin
            GoToXY(x_menu, y_menu + punkt - 1); write(menu[punkt]);
            punkt := punkt - 1;
            TextColor(SEL);
            GoToXY(x_menu, y_menu + punkt - 1); write(menu[punkt]);
            TextColor(NORM);
          end;
      end;
    end
    else
    if ch = #13 then begin{ нажата клавиша <Enter> }
      case punkt of
        1: punkt1;
        2: ch := #27;{ выход }
      end;
      MenuToScr;
    end;
  until ch = #27;{ 27 - код <Esc> }
end.