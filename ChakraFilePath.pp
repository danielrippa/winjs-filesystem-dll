unit ChakraFilePath;

{$mode delphi}

interface

  uses ChakraTypes;

  function GetChakraFilePath: TJsValue;

implementation

  uses Chakra, ChakraUtils, SysUtils, Win32FileSystem;

  function FilePathGetFileName(Args: PJsValue; ArgCount: Word): TJsValue;
  begin
    CheckParams('getFileName', Args, ArgCount, [jsString], 1);
    Result := StringAsJsString(ExtractFileName(JsStringAsString(Args^)));
  end;

  function FilePathGetBaseName(Args: PJsValue; ArgCount: Word): TJsValue;
  begin
    CheckParams('getBaseName', Args, ArgCount, [jsString], 1);
    Result := StringAsJsString(ExtractFileNameWithoutExt(JsStringAsString(Args^)));
  end;

  function FilePathGetPath(Args: PJsValue; ArgCount: Word): TJsValue;
  begin
    CheckParams('getPath', Args, ArgCount, [jsString], 1);
    Result := StringAsJsString(ExtractFilePath(JsStringAsString(Args^)));
  end;

  function FilePathGetFolderPath(Args: PJsValue; ArgCount: Word): TJsValue;
  begin
    CheckParams('getFolderPath', Args, ArgCount, [jsString], 1);
    Result := StringAsJsString(ExtractFileDir(JsStringAsString(Args^)));
  end;

  function FilePathGetExtension(Args: PJsValue; ArgCount: Word): TJsValue;
  begin
    CheckParams('getExtension', Args, ArgCount, [jsString], 1);
    Result := StringAsJsString(ExtractFileExt(JsStringAsString(Args^)));
  end;

  function FilePathGetDrive(Args: PJsValue; ArgCount: Word): TJsValue;
  begin
    CheckParams('getDrive', Args, ArgCount, [jsString], 1);
    Result := StringAsJsString(ExtractFileDrive(JsStringAsString(Args^)));
  end;

  function FilePathGetRelativePath(Args: PJsValue; ArgCount: Word): TJsValue;
  var
    BaseName, DestName: String;
  begin
    CheckParams('getRelativePath', Args, ArgCount, [jsString, jsString], 2);

    BaseName := JsStringAsString(Args^); Inc(Args);
    DestName := JsStringAsString(Args^);

    Result := StringAsJsString(ExtractRelativePath(BaseName, DestName));
  end;

  function GetChakraFilePath;
  begin
    Result := CreateObject;

    SetFunction(Result, 'getFileName', FilePathGetFileName);
    SetFunction(Result, 'getBaseName', FilePathGetBaseName);
    SetFunction(Result, 'getPath', FilePathGetPath);
    SetFunction(Result, 'getFolderPath', FilePathGetFolderPath);
    SetFunction(Result, 'getFileExtension', FilePathGetExtension);
    SetFunction(Result, 'getRelativePath', FilePathGetRelativePath);
  end;

end.