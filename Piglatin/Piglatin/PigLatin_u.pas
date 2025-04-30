unit PigLatin_u;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  System.Character;

type
  TForm1 = class(TForm)
    btnTranslate: TButton;
    btnClear: TButton;
    btnExit: TButton;
    memInput: TMemo;
    memOutput: TMemo;
    lblEnterEnglishTextHere: TLabel;
    lblPigLatinTranslation: TLabel;
    procedure btnClearClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure btnTranslateClick(Sender: TObject);
  private
      { Private declarations }
    function TranslateToPigLatin(const Text: string): String; // Main Function
    function IsVowel(C: Char): Boolean; // Helper Function.
  public
      { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

  // Clear Button. Clears The two memos and sets focus to Input Memo.
procedure TForm1.btnClearClick(Sender: TObject);
begin
  memInput.Clear;
  memOutput.Clear;
  memInput.SetFocus;
end;

  // Exit Button. confirm Exit.
procedure TForm1.btnExitClick(Sender: TObject);
begin
    // Shows a Conformation message box
  if MessageDlg('Are you Sure You Want To Close', TMsgDlgType.mtConfirmation,
    [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], 0) = mrYes then
    begin
        // If user clicks Yes, Close the Form
      Close;
    end;
    // If user clicks No, Nothing Happens

end;

procedure TForm1.btnTranslateClick(Sender: TObject);
begin
  if Trim(memInput.Text).isempty then
    Showmessage('Please Enter Text To Translate.')
  else
    memOutput.Text := TranslateToPigLatin(memInput.Text);
end;

  // Helper Function
function TForm1.IsVowel(C: Char): Boolean;
begin
  Result := C.ToLower in ['a', 'e', 'i', 'o', 'u']; // checks if char in lower Case is a Vowel
end;

function TForm1.TranslateToPigLatin(const Text: string): String;
var
  arrWords, arrResultWords: TArray<String>; // Arrays to store Words and Translated Words.
  sWord, sPunctuation, sBaseWord: String; // Variables for Processing each Word.
  iFirstVowelPos, i: Integer; // Variables To Find Position of The First Vowel.

begin

    // Step 1 : Initialize the translated words Array;
  arrResultWords := []; // makes the array Empty.

    // Step 2 : Split The input into individual words.
  arrWords := Text.Split([' '], TStringSplitOptions.ExcludeEmpty); // Text = Input String
    // Takes the string and puts Each word into the array usue the ' ' (spaces) as a seperator.

    // Step 3 : loop Through Each word in the array and process
  for sWord in arrWords do
    begin

        // Step 4 : Check if The Word ends in Punctuation.
      sPunctuation := ''; // sets sPunctuation to empty.
      sBaseWord := sWord; // copies sWord into sBaseWord.

        // step 5 : Skip Translation if word contains numbers or symbols
      if sBaseWord.IndexOfAny(['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '@', '#', '$', '%',
        '&', '*']) > - 1 then
        begin
          arrResultWords := arrResultWords + [sWord];
          Continue;
        end; // End of IF

      while (sBaseWord <> '') and (not sBaseWord[sBaseWord.Length].IsLetter) do
          // Loops through sBaseWord Removing Punctuation while its not empty and last char is not a letter
        begin
          sPunctuation := sBaseWord[sBaseWord.Length] + sPunctuation;
            // coppies all punctuation into sPunctuation
          sBaseWord := sBaseWord.Substring(0, sBaseWord.Length - 1);
            // coppies the word without punctuation.
        end; // END of While

        // Step 6 : See How to translate the word based on the first letter
      if IsVowel(sBaseWord[Low(sBaseWord)]) then // if it starts with a Vowel.
        begin
          sBaseWord := sBaseWord + 'way'
        end
      else // Find pos of first vowel or 'y'.
        begin
          iFirstVowelPos := 1;
          for i := 1 to Length(sBaseWord) do
            if IsVowel(sBaseWord[i]) or ((sBaseWord[i].ToLower = 'y') and (i > 1)) then
              begin
                iFirstVowelPos := i;
                Break;
              end;

          sBaseWord := sBaseWord.Substring(iFirstVowelPos - 1) +
            sBaseWord.Substring(0, iFirstVowelPos - 1) + 'ay';
        end;

        // Step 9 : put Punctuation back at the end of the Word
      sBaseWord := sBaseWord + sPunctuation;



        // Step 10 : add the translated Words to the Resualts array
      arrResultWords := arrResultWords + [sBaseWord.toLower];

    end; // END of for sWord in arrwords do.

    // Step 11 : // Put all translated words into a string.
  Result := string.Join(' ', arrResultWords);

end; // END of TranslateToPigLatin.

end.
