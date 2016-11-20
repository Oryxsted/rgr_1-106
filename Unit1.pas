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
     var i,j:integer;  //������ ��������
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
//������ �����
begin
close;
end;

procedure TForm1.Button2Click(Sender: TObject);//������ ���������
const Nmax = 20;
type
    Tmy = Array[1..Nmax,1..Nmax] of Extended;
    Tmx = Array[1..Nmax] of Extended;
var
mA, mX:Tmx;
mY:Tmy;
xn,Dx,an,ak,Da,b:Extended;
N,RA:integer;

function f(x:real):real;
  begin
  f:= sin(4*x)*(exp(2*x) + exp(-2*x));
  end;
function integral(km:integer; a,b,eps:real):real;
var n,i,j:integer; var S, h, integ, integ_old:real;
begin
n:=4;
integ := 0;
integ_old:=1;
  for j := 1 to km do
    begin
    S := 0;
    h := (b - a) / n;
    for i := 1 to n-1 do
      begin
      S := S + f(a+h*i);
      end;
    integ_old := integ;
    integ := h * ((f(a)+f(b))/2 + S);
    if abs(integ_old - integ) > eps then
      n:= n*2
    else
    integral := integ;
    end;
end;


procedure Tab(xn,Dx,an,ak,Da,b:Extended;N:integer; var RA:integer;var mA,mX:Tmx; var mY:Tmy);   //��������� �������������
  var
  i,j:integer;
  x,a,lz,Y:Extended;
  begin
  a :=an;
  i:= 1;
  while a<= ak do
    begin
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
    i:=i+1;
    end;
    RA:= i;
  end;
procedure RezOut(var RA,N:integer;var mA,mX:Tmx;var mY:Tmy);     //��������� ������ ����������
var I,J:Integer;
begin
for I:= 1 to (RA-1) do
  begin
  Grid1.Cells[I,0]:= ('A['+ IntToStr(I)+']='+ FloatToStr(mA[I]));
  Form1.Graf.Series[0].Clear;
  for J:= 1 to N do
    begin
     if (Grid1.ColCount<J+1) then
     Grid1.ColCount:= Grid1.ColCount + 1;
     Grid1.Cells[0,J]:= ('x['+IntToStr(J)+']='+FloatToStr(mX[J]));
     Form1.Graf.Series[0].AddXY(Mx[J],mY[I,J]);
     Grid1.Cells[I,J]:= FloatToStr(mY[I,J]);
     end;
     If (Grid1.RowCount<I+1) then
        Grid1.RowCount := Grid1.RowCount + 1;
    end;
    end;
begin
Edit12.Text:= FloatToStr(integral(StrToInt(Edit4.Text),StrToFloat(Edit2.Text), StrToFloat(Edit5.Text), StrToFloat(Edit3.Text)));
xn:= StrToFloat(Edit6.Text);
N := StrToInt(Edit7.Text);
Dx:= StrToFloat(Edit8.Text);
an:= StrToFloat(Edit9.Text);
ak:=StrToFloat(Edit10.Text);
Da :=StrToFloat(Edit11.Text);
b:=StrToFloat(Edit12.Text);
Tab(xn,Dx,an,ak,Da,b,N,RA,mA,mX,mY);
RezOut(RA,N,mA,mX,mY);
end;

end.
