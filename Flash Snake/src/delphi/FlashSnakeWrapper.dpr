program FlashSnakeWrapper;

uses
  Forms,
  FlashSnakeUnit in 'FlashSnakeUnit.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Flash Snake';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
