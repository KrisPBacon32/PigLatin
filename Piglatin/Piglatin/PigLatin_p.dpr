program PigLatin_p;

uses
  Vcl.Forms,
  PigLatin_u in 'PigLatin_u.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
