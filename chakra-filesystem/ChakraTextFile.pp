unit ChakraTextFile;

{$mode delphi}

interface

  uses
    ChakraTypes;

  function GetChakraTextFile: TJsValue;

implementation

  uses
    Chakra, ChakraUtils, Win32TextFile, SysUtils;

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

  function GetChakraTextFile;
  begin

    Result := CreateObject;

    SetFunction(Result, 'read', ChakraReadTextFile);
    SetFunction(Result, 'write', ChakraWriteTextFile);

  end;

end.