unit Unit1;

interface

uses
  Windows, Math, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, ExtCtrls, TeeProcs, TeEngine, TeeFunci,
  Chart , Series;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Label11: TLabel;
    Label12: TLabel;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Edit9: TEdit;
    Edit11: TEdit;
    Edit10: TEdit;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Edit12: TEdit;
    Label23: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Grid1: TStringGrid;
    Series1: TLineSeries;
    Graf: TChart;
    Label24: TLabel;
    Series2: TLineSeries;
    Series3: TLineSeries;
    TeeFunction1: TAddTeeFunction;
    Series4: TLineSeries;
    Series5: TLineSeries;
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
     var i,j:integer;  //Кнопка Очистить
     begin
     Edit2.Clear; Edit3.Clear; Edit4.Clear; Edit5.Clear; Edit6.Clear;  Edit7.Clear;
     Edit8.Clear;  Edit9.Clear;  Edit10.Clear;  Edit11.Clear;  Edit12.Clear;
     Edit2.SetFocus;
     Form1.Graf.Series[0].Clear;
     for i:=0 to 20 do
      for j:=0 to 20 do
        Grid1.Cells[i,j]:='';
     end;


procedure TForm1.Button3Click(Sender: TObject);
//Кнопка Конец
begin
close;
end;

procedure TForm1.Button2Click(Sender: TObject);//Кнопка выполнить
const Nmax = 20;
type
    Tmy = Array[1..Nmax,1..Nmax] of Real;
    Tmx = Array[1..Nmax] of Real;
var
mA, mX:Tmx;
mY:Tmy;
xn,Dx,an,ak,Da,b,GA,GB,eps:Real;
N,RA,km,ER:integer;


function f(x:real):real;
  begin
  f:= sin(4*x)*(exp(2*x) + exp(-2*x));
  end;


procedure integral_trap(GA,GB,eps:real; km:integer; var ER:integer; var integ:real);
  var n,i,j:integer; var S, h, integ_old:real;
  begin
n:=4; ER:=1;
integ_old:=0; j:=1;
  while j<=km do
    begin
    S := 0;
    h := (GB - GA) / n;
    for i := 1 to n-1 do
      begin
      S := S + f(GA+h*i);
      end;
    integ := h * ((f(GA)+f(GB))/2 + S);
    if abs(integ_old - integ) > eps then
      begin
      integ_old := integ;
      n:= n*2;
      end
    else
      begin
      ER:= 0;
      j:=km;
      end;
    j:= j+1;
    end;
  end;

procedure Tab(xn,Dx,an,ak,Da,b:Real;N:integer; var RA:integer;var mA,mX:Tmx; var mY:Tmy);   //Процедура табулирования
  var
  i,j:integer;
  x,a,lz,Y:Real;
  begin
  a :=an;
  i:= 0;
  while a<= ak do
    begin
    i:=i+1;
    x:=xn;
    for j:=1 to N do
      begin
      if x > 1 then
           begin
           Y := Sin(a*x)* Cos(b*x);
           mY[i, j] := Y;
           end
      else
          begin
          lz:= a*a + x*x*x*x + b*b;
          Y := x*x*sqrt(lz);
          mY[i, j] := Y;
          end;
      mX[j]:= x;
      x:= x + Dx;
      end;
    mA[i]:= a;
    a:= a + Da;
    end;
    RA:= i;
  end;
procedure RezOut(var RA,N:integer;var mA,mX:Tmx;var mY:Tmy);     //процедура вывода результата
var I,J:Integer;
begin
for I:= 1 to RA do
  begin
  Grid1.Cells[I,0]:= ('A['+ IntToStr(I)+']='+ FloatToStr(mA[I]));
   if I<=4 then
  Form1.Graf.Series[I-1].Clear;
  for J:= 1 to N do
    begin
     if (Grid1.ColCount<J+1) then
     Grid1.ColCount:= Grid1.ColCount + 1;
     Grid1.Cells[0,J]:= ('x['+IntToStr(J)+']='+FloatToStr(mX[J]));
     if I<=4 then
       Form1.Graf.Series[I-1].AddXY(Mx[J],mY[I,J]);
     Grid1.Cells[I,J]:= FloatToStr(mY[I,J]);
     end;
     If (Grid1.RowCount<I+1) then
        Grid1.RowCount := Grid1.RowCount + 1;
    end;
    end;
begin
GA:= StrToFloat(Edit2.Text);
GB:= StrToFloat(Edit5.Text);
eps:= StrToFloat(Edit3.Text);
km:= StrToInt(Edit4.Text);
integral_trap(GA,GB,eps,km,ER,b);
if ER = 1 then
  begin
  Edit12.Text:= 'Интеграл не найден';
  exit;
  end;
Edit12.Text:= FloatToStr(b);
xn:= StrToFloat(Edit6.Text);
N := StrToInt(Edit7.Text);
Dx:= StrToFloat(Edit8.Text);
an:= StrToFloat(Edit9.Text);
ak:=StrToFloat(Edit10.Text);
Da :=StrToFloat(Edit11.Text);
Tab(xn,Dx,an,ak,Da,b,N,RA,mA,mX,mY);
RezOut(RA,N,mA,mX,mY);
end;

end.
