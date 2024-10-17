unit ChakraTextFile;

{$mode delphi}

interface

  uses
    ChakraTypes;

  function GetChakraTextFile: TJsValue;

implementation

  uses
    Chakra, ChakraError, Win32TextFile, SysUtils;

  function ChakraReadTextFile(Args: PJsValue; ArgCount: Word): TJsValue;
  var
    Filename: WideString;
    Content: WideString;
  begin
    Result := Undefined;
    CheckParams('read', Args, ArgCount, [jsString], 1);

    Filename := JsStringAsString(Args^);

    if not FileExists(Filename) then Exit;

    if ReadTextFileContent(Filename, Content) then begin
      Result := StringAsJsString(Content);
    end;
  end;

  function ChakraWriteTextFile(Args: PJsValue; ArgCount: Word): TJsValue;
  var
    FilePath, FileContent: WideString;
  begin
    Result := BooleanAsJsBoolean(False);

    CheckParams('write', Args, ArgCount, [jsString, jsString], 2);

    FilePath := JsStringAsString(Args^); Inc(Args);
    FileContent := JsStringAsString(Args^);

    Result := BooleanAsJsBoolean(WriteTextFileContent(FilePath, FileContent));
  end;

  function ChakraTextFileAppendLine(Args: PJsValue; ArgCount: Word): TJsValue;
  var
    aFileName, aLine: WideString;
  begin
    CheckParams('appendLine', Args, ArgCount, [jsString, jsString], 2);

    aFileName := JsStringAsString(Args^); Inc(Args);
    aLine := JsStringAsString(Args^);

    Result := BooleanAsJsBoolean(AppendTextFileLine(aFileName, aLine));
  end;

  function GetChakraTextFile;
  begin

    Result := CreateObject;

    SetFunction(Result, 'read', ChakraReadTextFile);
    SetFunction(Result, 'write', ChakraWriteTextFile);
    SetFunction(Result, 'appendLine', ChakraTextFileAppendLine);

  end;

end.