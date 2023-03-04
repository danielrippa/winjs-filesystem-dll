unit Win32TextFile;

{$mode delphi}

interface

  function ReadTextFileContent(FilePath: WideString; out Content: WideString): Boolean;
  function WriteTextFileContent(FilePath, Content: WideString): Boolean;

implementation

  uses
    Classes;

  function ReadTextFileContent;
  var
    FileStream: TFileStream;
    S: UTF8String;
  begin
    Result := False;

    FileStream := TFileStream.Create(FilePath, fmOpenRead);
    try

      if FileStream.Size = 0 then Exit;

      with FileStream do begin
        SetLength(S, Size);
        Read(S[1], Size);

        Content := UTF8String(S);

        Result := True;
      end;

    finally
      FileStream.Free;
    end;

  end;


  function WriteTextFileContent;
  var
    FileContent: String;
  begin
    Result := False;
    try
      FileContent := UTF8Encode(Content);
      with TFileStream.Create(FilePath, fmCreate) do begin
        Write(FileContent[1], Length(FileContent));
        Free;
      end;

      Result := True;
    except
    end;
  end;


end.